import * as PIXI from 'pixi.js';
import { Benchmark } from '../benchmark';

export class ThreeAtlasesAddChild extends Benchmark {
  private atlasUsed = 0;

  public constructor(width: number, height: number, private numberOfObjects: number) {
    super(width, height);
    this.app.loader.add('atlas50a', '../assets/atlas/data50a.json');
    this.app.loader.add('atlas50b', '../assets/atlas/data50b.json');
    this.app.loader.add('atlas100', '../assets/atlas/data100.json');
  }

  protected eachFrameCallback(): void {
    this.app.stage.removeChildren();

    for (let i = 0; i < this.numberOfObjects; i++) {
      let imageNumber;
      let atlasName;
      let imageName;

      switch (this.atlasUsed) {
        case 0:
          imageNumber = Math.floor(Math.random() * 50);
          atlasName = 'atlas50a';
          imageName = imageNumber < 10 ? `atlas50a.img0${imageNumber}a` : `atlas50a.img${imageNumber}a`;
          break;
        case 1:
          imageNumber = Math.floor(Math.random() * 50) + 50;
          atlasName = 'atlas50b';
          imageName = `atlas50b.img${imageNumber}b`;
          break;
        default:
          imageNumber = Math.floor(Math.random() * 99);
          atlasName = 'atlas100';
          imageName = `atlas100.img${imageNumber}`;
      }

      const sprite = new PIXI.Sprite(this.app.loader.resources[atlasName].textures[imageName]);
      this.app.stage.addChild(sprite);
      sprite.x = Math.random() * this.app.renderer.screen.width;
      sprite.y = Math.random() * this.app.renderer.screen.height;

      this.atlasUsed = (this.atlasUsed + 1) % 3;
    }
  }
}
