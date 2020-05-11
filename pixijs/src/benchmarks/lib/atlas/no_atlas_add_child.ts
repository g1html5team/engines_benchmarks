import * as PIXI from 'pixi.js';
import { Benchmark } from '../benchmark';

export class NoAtlasAddChild extends Benchmark {
  public constructor(width: number, height: number, private numberOfObjects: number) {
    super(width, height);
    for (let i = 0; i < 100; i++) {
      const imageName = i < 10 ? `img0${i}` : `img${i}`;
      this.app.loader.add(imageName, `../assets/atlas/${imageName}.png`);
    }
  }

  protected eachFrameCallback(): void {
    for (let i = 0; i < this.numberOfObjects; i++) {
      const imageNumber = Math.floor(Math.random() * 100);
      const imageName = imageNumber < 10 ? `img0${imageNumber}` : `img${imageNumber}`;
      const sprite = new PIXI.Sprite(this.app.loader.resources[imageName].texture);
      this.app.stage.addChild(sprite);
      sprite.x = Math.random() * this.app.renderer.screen.width;
      sprite.y = Math.random() * this.app.renderer.screen.height;
    }
  }
}
