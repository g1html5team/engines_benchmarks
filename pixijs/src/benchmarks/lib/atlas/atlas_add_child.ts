import * as PIXI from 'pixi.js';
import { Benchmark } from '../benchmark';

export class AtlasAddChild extends Benchmark {
  public constructor(width: number, height: number, private numberOfObjects: number) {
    super(width, height);
    this.app.loader.add('atlas100', '../assets/atlas/data100.json');
  }

  protected eachFrameCallback(): void {
    this.app.stage.removeChildren();

    for (let i = 0; i < this.numberOfObjects; i++) {
      const imageNumber = Math.floor(Math.random() * 99);
      const imageName = imageNumber < 10 ? `atlas100.img0${imageNumber}` : `atlas100.img${imageNumber}`;
      const sprite = new PIXI.Sprite(this.app.loader.resources.atlas100.textures[imageName]);
      this.app.stage.addChild(sprite);
      sprite.x = Math.random() * this.app.renderer.screen.width;
      sprite.y = Math.random() * this.app.renderer.screen.height;
    }
  }
}
