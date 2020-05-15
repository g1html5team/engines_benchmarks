import * as PIXI from 'pixi.js-legacy';
import { BenchmarkResult } from '../model/benchmark_result';

declare const RENDERER: string;

export abstract class Benchmark {
  private readonly benchmarkDuration = 5;
  private frameDurations: number[] = [];
  protected app: PIXI.Application;
  protected assetsToLoad: Map<string, string> = new Map();
  private readonly incorrectRenderer: boolean = false;

  protected constructor(width: number, height: number) {
    // Force preferred renderer based on environment variable RENDERER
    if (RENDERER === 'webgl2') {
      PIXI.settings.PREFER_ENV = PIXI.ENV.WEBGL2;
    } else if (RENDERER === 'webgl1') {
      PIXI.settings.PREFER_ENV = PIXI.ENV.WEBGL;
    }

    // Create the pixi application
    this.app = new PIXI.Application({
      width,
      height,
      resolution: window.devicePixelRatio,
      autoDensity: true,
      autoStart: false,
      forceCanvas: RENDERER === 'canvas',
    });

    // Check if the app runs the desired renderer
    if (RENDERER === 'webgl2' || RENDERER === 'webgl1') {
      const preferredWebGLVersion = RENDERER === 'webgl2' ? 2 : 1;
      if (
        this.app.renderer.type !== PIXI.RENDERER_TYPE.WEBGL ||
        (this.app.renderer.context as PIXI.systems.ContextSystem).webGLVersion !== preferredWebGLVersion
      ) {
        window.alert(`Couldn't use WebGL ${preferredWebGLVersion}`);
        this.incorrectRenderer = true;
      }
    } else if (RENDERER === 'canvas' && this.app.renderer.type !== PIXI.RENDERER_TYPE.CANVAS) {
      window.alert("Couldn't use canvas");
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

    let firstFrame = true;
    let firstFrameTime = 0;

    return new Promise((resolve) => {
      this.app.ticker.add(() => {
        if (firstFrame) {
          firstFrame = false;
          firstFrameTime = this.app.ticker.lastTime;
        }

        this.eachFrameCallback(this.app.ticker.deltaTime, this.app.ticker.lastTime);
        this.frameDurations.push(this.app.ticker.elapsedMS);

        if (this.app.ticker.lastTime - firstFrameTime >= this.benchmarkDuration * 1000) {
          this.app.stop();
          resolve(this.processResult());
        }
      });

      this.app.start();
    });
  }

  protected abstract eachFrameCallback(deltaTime?: number, lastTime?: number): void;

  private processResult(): BenchmarkResult {
    const frameDurationsSum = this.frameDurations.reduce((previousValue, currentValue) => previousValue + currentValue);
    const averageFrameDuration = frameDurationsSum / this.frameDurations.length;
    const fps = Math.min(this.frameDurations.length / this.benchmarkDuration, 60);

    console.log(`averageFrameDuration = ${averageFrameDuration}`);
    console.log(`fps = ${this.frameDurations.length / this.benchmarkDuration}`);

    return new BenchmarkResult(averageFrameDuration, fps);
  }
}
