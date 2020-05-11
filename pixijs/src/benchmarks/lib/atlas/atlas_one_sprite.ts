import * as PIXI from 'pixi.js';
import { Benchmark } from '../benchmark';

export class AtlasOneSprite extends Benchmark {
  private sprite: PIXI.Sprite;

  public constructor(width: number, height: number, private numberOfObjects: number) {
    super(width, height);
    this.app.loader.add('atlas100', '../assets/atlas/data100.json');
  }

  public async init(): Promise<void> {
    await super.init();

    this.sprite = new PIXI.Sprite(this.app.loader.resources.atlas100.textures['atlas100.img00']);
    this.app.stage.addChild(this.sprite);
  }

  protected eachFrameCallback(): void {
    for (let i = 0; i < this.numberOfObjects; i++) {
      const imageNumber = Math.floor(Math.random() * 99);
      const imageName = imageNumber < 10 ? `atlas100.img0${imageNumber}` : `atlas100.img${imageNumber}`;
      this.sprite.texture = this.app.loader.resources.atlas100.textures[imageName];
    }
  }
}
