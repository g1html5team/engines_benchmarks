import * as PIXI from 'pixi.js';
import { BenchmarkResult } from '../model/benchmark_result';

declare const RENDERER: string;

export abstract class Benchmark {
  private readonly benchmarkDuration = 5;
  private frameDurations: number[] = [];
  protected app: PIXI.Application;
  protected assetsToLoad: Map<string, string> = new Map();
  private incorrectRenderer = false;

  protected constructor(width: number, height: number) {
    let preferredWebGLVersion = 2;
    switch (RENDERER) {
      case 'webgl1':
        PIXI.settings.PREFER_ENV = PIXI.ENV.WEBGL;
        preferredWebGLVersion = 1;
        break;
      case 'canvas':
        // TODO (sch)
        break;
      default:
        PIXI.settings.PREFER_ENV = PIXI.ENV.WEBGL2;
    }

    this.app = new PIXI.Application({
      width,
      height,
      resolution: window.devicePixelRatio,
      autoDensity: true,
      autoStart: false,
    });

    if (
      this.app.renderer.type === PIXI.RENDERER_TYPE.WEBGL &&
      this.app.renderer.context.webGLVersion !== preferredWebGLVersion
    ) {
      window.alert(`Couldn't use WebGL ${preferredWebGLVersion}`);
      this.incorrectRenderer = true;
    }

    document.body.appendChild(this.app.view);
  }

  public async init(): Promise<void> {
    if (this.incorrectRenderer) {
      return Promise.resolve();
    }

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
    if (this.incorrectRenderer) {
      return Promise.resolve(null);
    }

    this.app.ticker.add(() => {
      this.eachFrameCallback();
      this.frameDurations.push(this.app.ticker.elapsedMS);
    });

    return new Promise((resolve) => {
      this.app.start();

      setTimeout(() => {
        this.app.stop();
        resolve(this.processResult());
      }, this.benchmarkDuration * 1000);
    });
  }

  protected abstract eachFrameCallback(deltaTime?: number): void;

  private processResult(): BenchmarkResult {
    const frameDurationsSum = this.frameDurations.reduce((previousValue, currentValue) => previousValue + currentValue);
    const averageFrameDuration = frameDurationsSum / this.frameDurations.length;
    const fps = Math.min(this.frameDurations.length / this.benchmarkDuration, 60);

    return new BenchmarkResult(averageFrameDuration, fps);
  }
}
