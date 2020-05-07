import * as PIXI from 'pixi.js';
import { BenchmarkResult } from '../model/benchmark_result';

export abstract class Benchmark {
  private readonly benchmarkDuration = 5;
  private frameDurations: number[] = [];
  protected app: PIXI.Application;
  protected assetsToLoad: Map<string, string> = new Map();

  protected constructor(width: number, height: number) {
    this.app = new PIXI.Application({
      width,
      height,
      resolution: window.devicePixelRatio,
      autoDensity: true,
      autoStart: false,
    });

    document.body.appendChild(this.app.view);
  }

  public async init(): Promise<void> {
    this.assetsToLoad.forEach((value, key) => {
      this.app.loader.add(key, value);
    });

    return new Promise((resolve) => {
      this.app.loader.load(() => {
        resolve();
      });
    });
  }

  public async run(): Promise<BenchmarkResult> {
    this.app.ticker.add((delta) => {
      this.eachFrameCallback();
      this.frameDurations.push(delta);
    });

    return new Promise((resolve) => {
      this.app.start();

      setTimeout(() => {
        this.app.stop();
        resolve(this.processResult());
      }, this.benchmarkDuration * 1000);
    });
  }

  protected abstract eachFrameCallback(): void;

  private processResult(): BenchmarkResult {
    const frameDurationsSum = this.frameDurations.reduce((previousValue, currentValue) => previousValue + currentValue);
    const averageFrameDuration = frameDurationsSum / this.frameDurations.length;
    const fps = Math.min(this.frameDurations.length / this.benchmarkDuration, 60);

    return new BenchmarkResult(averageFrameDuration, fps);
  }
}
