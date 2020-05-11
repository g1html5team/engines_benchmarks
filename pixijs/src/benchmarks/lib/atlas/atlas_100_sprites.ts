import * as PIXI from 'pixi.js';
import { Benchmark } from '../benchmark';

export class Atlas100Sprites extends Benchmark {
  private sprites: PIXI.Sprite[] = [];

  public constructor(width: number, height: number, private numberOfObjects: number) {
    super(width, height);
    this.app.loader.add('atlas100', '../assets/atlas/data100.json');
  }

  public async init(): Promise<void> {
    await super.init();

    for (let i = 0; i < 100; i++) {
      const sprite = new PIXI.Sprite(this.app.loader.resources.atlas100.textures['atlas100.img00']);
      this.sprites.push(sprite);

      const row = Math.floor(i / 10);
      const column = i % 10;
      sprite.x = column * (this.app.renderer.screen.width / 10);
      sprite.y = row * (this.app.renderer.screen.height / 10);

      this.app.stage.addChild(sprite);
    }
  }

  protected eachFrameCallback(): void {
    for (let i = 0; i < this.numberOfObjects; i++) {
      this.sprites.forEach((sprite) => {
        const imageNumber = Math.floor(Math.random() * 99);
        const imageName = imageNumber < 10 ? `atlas100.img0${imageNumber}` : `atlas100.img${imageNumber}`;
        sprite.texture = this.app.loader.resources.atlas100.textures[imageName];
      });
    }
  }
}
