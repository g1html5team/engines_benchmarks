import * as PIXI from 'pixi.js';
import { BenchmarkResult } from '../model/benchmark_result';

export abstract class Benchmark {
  private readonly benchmarkDuration = 5;
  private frameDurations: number[] = [];
  protected app: PIXI.Application;

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
    return new Promise((resolve) => {
      this.app.loader.add('bunny', '../benchmarks/assets/bunny.png').load(() => {
        resolve();
      });
    });
  }

  public async run(): Promise<BenchmarkResult> {
    this.app.ticker.add((delta) => {
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

  private processResult(): BenchmarkResult {
    const frameDurationsSum = this.frameDurations.reduce((previousValue, currentValue) => previousValue + currentValue);
    const averageFrameDuration = frameDurationsSum / this.frameDurations.length;
    const fps = Math.min(this.frameDurations.length / this.benchmarkDuration, 60);

    return new BenchmarkResult(averageFrameDuration, fps);
  }
}
