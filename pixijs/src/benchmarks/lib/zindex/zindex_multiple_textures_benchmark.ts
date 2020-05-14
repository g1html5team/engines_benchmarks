import * as PIXI from 'pixi.js';
import { AZIndexBenchmark } from './a_zindex_benchmark';

export class ZIndexMultipleTexturesBenchmark extends AZIndexBenchmark {
  public constructor(width: number, height: number, private totalNumberOfObjects: number) {
    super(width, height, totalNumberOfObjects / 2);
    this.assetsToLoad.set('redBunny', '../assets/bunny_red.png');
  }

  public async init(): Promise<void> {
    await super.init();

    for (let i = 0; i < this.numberOfObjects; i++) {
      const bunny = new PIXI.Sprite(this.app.loader.resources.redBunny.texture);
      this.container.addChild(bunny);
      bunny.x = this.app.renderer.screen.width / 2 + Math.random() * 300 - 150;
      bunny.y = this.app.renderer.screen.height / 2 + Math.random() * 300 - 150;
      bunny.rotation = Math.random() * Math.PI;
      bunny.anchor = new PIXI.Point(0.5, 0.5);
      this.bunnies.push(bunny);
    }
  }

  protected eachFrameCallback(): void {
    this.bunnies.forEach((bunny) => {
      this.container.addChildAt(bunny, Math.floor(Math.random() * this.totalNumberOfObjects));
    });
  }
}
