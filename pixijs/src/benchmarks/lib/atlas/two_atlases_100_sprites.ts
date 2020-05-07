import * as PIXI from 'pixi.js';
import { Benchmark } from '../benchmark';

export class TwoAtlases100Sprites extends Benchmark {
  private sprites: PIXI.Sprite[] = [];
  private isAtlasA = true;

  public constructor(width: number, height: number, private numberOfObjects: number) {
    super(width, height);
    this.app.loader.add('atlas50a', '../assets/atlas/data50a.json');
    this.app.loader.add('atlas50b', '../assets/atlas/data50b.json');
  }

  public async init(): Promise<void> {
    await super.init();

    for (let i = 0; i < 100; i++) {
      const sprite = new PIXI.Sprite(this.app.loader.resources.atlas50a.textures['atlas50a.img00a']);
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
        const imageNumber = Math.floor(Math.random() * 50) + (this.isAtlasA ? 0 : 50);
        const atlasName = this.isAtlasA ? 'atlas50a' : 'atlas50b';
        let imageName;
        if (this.isAtlasA) {
          imageName = imageNumber < 10 ? `atlas50a.img0${imageNumber}a` : `atlas50a.img${imageNumber}a`;
        } else {
          imageName = `atlas50b.img${imageNumber}b`;
        }

        sprite.texture = this.app.loader.resources[atlasName].textures[imageName];

        this.isAtlasA = !this.isAtlasA;
      });
    }
  }
}
