import * as PIXI from 'pixi.js';
import { Benchmark } from '../benchmark';

export class TwoAtlasesOneSprite extends Benchmark {
  private sprite: PIXI.Sprite;
  private isAtlasA = true;

  public constructor(width: number, height: number, private numberOfObjects: number) {
    super(width, height);
    this.app.loader.add('atlas50a', '../assets/atlas/data50a.json');
    this.app.loader.add('atlas50b', '../assets/atlas/data50b.json');
  }

  public async init(): Promise<void> {
    await super.init();

    this.sprite = new PIXI.Sprite(this.app.loader.resources.atlas50a.textures['atlas50a.img00a']);
    this.app.stage.addChild(this.sprite);
  }

  protected eachFrameCallback(): void {
    for (let i = 0; i < this.numberOfObjects; i++) {
      const imageNumber = Math.floor(Math.random() * 50) + (this.isAtlasA ? 0 : 50);
      const atlasName = this.isAtlasA ? 'atlas50a' : 'atlas50b';
      let imageName;
      if (this.isAtlasA) {
        imageName = imageNumber < 10 ? `atlas50a.img0${imageNumber}a` : `atlas50a.img${imageNumber}a`;
      } else {
        imageName = `atlas50b.img${imageNumber}b`;
      }

      this.sprite.texture = this.app.loader.resources[atlasName].textures[imageName];

      this.isAtlasA = !this.isAtlasA;
    }
  }
}
