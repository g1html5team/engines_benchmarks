import * as PIXI from 'pixi.js';
import { AZIndexBenchmark } from './a_zindex_benchmark';

export class ZIndexOneChildBenchmark extends AZIndexBenchmark {
  private bigBunny: PIXI.Sprite;

  public constructor(width: number, height: number, numberOfObjects: number) {
    super(width, height, numberOfObjects);
    this.assetsToLoad.set('redBunny', '../assets/bunny_red.png');
  }

  public async init(): Promise<void> {
    await super.init();

    this.bigBunny = new PIXI.Sprite(this.app.loader.resources.redBunny.texture);
    this.bigBunny.scale = new PIXI.Point(3, 3);
    this.bigBunny.x = this.app.renderer.screen.width / 2;
    this.bigBunny.y = this.app.renderer.screen.height / 2;
    this.bigBunny.anchor = new PIXI.Point(0.5, 0.5);
  }

  protected eachFrameCallback(): void {
    this.container.addChildAt(this.bigBunny, Math.floor(Math.random() * this.numberOfObjects));
  }
}
