import * as PIXI from 'pixi.js';
import { Benchmark } from '../benchmark';

export class FlipbookBenchmark extends Benchmark {
  private flipbook: PIXI.AnimatedSprite;
  private currentFrame = 0;

  public constructor(width: number, height: number) {
    super(width, height);
    for (let i = 0; i < 30; i++) {
      const imageNumber = i < 10 ? `0${i}` : `${i}`;
      this.app.loader.add(`v00${imageNumber}`, `../assets/flipbook/v00${imageNumber}.jpg`);
    }
  }

  public async init(): Promise<void> {
    await super.init();

    const frames: PIXI.Texture[] = [];
    for (let i = 0; i < 30; i++) {
      const imageNumber = i < 10 ? `0${i}` : `${i}`;
      frames.push(this.app.loader.resources[`v00${imageNumber}`].texture);
    }

    this.flipbook = new PIXI.AnimatedSprite(frames);
    this.app.stage.addChild(this.flipbook);
  }

  protected eachFrameCallback(): void {
    this.flipbook.gotoAndStop(this.currentFrame);
    this.currentFrame = (this.currentFrame + 1) % 30;
  }
}
