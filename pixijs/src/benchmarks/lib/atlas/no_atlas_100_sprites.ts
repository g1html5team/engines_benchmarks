import * as PIXI from 'pixi.js';
import { Benchmark } from '../benchmark';

export class NoAtlas100Sprites extends Benchmark {
  private sprites: PIXI.Sprite[] = [];

  public constructor(width: number, height: number, private numberOfObjects: number) {
    super(width, height);
    for (let i = 0; i < 100; i++) {
      const imageName = i < 10 ? `img0${i}` : `img${i}`;
      this.app.loader.add(imageName, `../assets/atlas/${imageName}.png`);
    }
  }

  public async init(): Promise<void> {
    await super.init();

    for (let i = 0; i < 100; i++) {
      const sprite = new PIXI.Sprite(this.app.loader.resources.img00.texture);
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
        const imageNumber = Math.floor(Math.random() * 100);
        const imageName = imageNumber < 10 ? `img0${imageNumber}` : `img${imageNumber}`;
        sprite.texture = this.app.loader.resources[imageName].texture;
      });
    }
  }
}
