import * as PIXI from 'pixi.js';
import { Benchmark } from '../benchmark';

export class NoAtlasOneSprite extends Benchmark {
  private sprite: PIXI.Sprite;

  public constructor(width: number, height: number, private numberOfObjects: number) {
    super(width, height);
    for (let i = 0; i < 100; i++) {
      const imageName = i < 10 ? `img0${i}` : `img${i}`;
      this.app.loader.add(imageName, `../assets/atlas/${imageName}.png`);
    }
  }

  public async init(): Promise<void> {
    await super.init();

    this.sprite = new PIXI.Sprite(this.app.loader.resources.img00.texture);
    this.app.stage.addChild(this.sprite);
  }

  protected eachFrameCallback(): void {
    for (let i = 0; i < this.numberOfObjects; i++) {
      const imageNumber = Math.floor(Math.random() * 100);
      const imageName = imageNumber < 10 ? `img0${imageNumber}` : `img${imageNumber}`;
      this.sprite.texture = this.app.loader.resources[imageName].texture;
    }
  }
}
