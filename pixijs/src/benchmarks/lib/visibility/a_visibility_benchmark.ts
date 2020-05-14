import * as PIXI from 'pixi.js';
import { Benchmark } from '../benchmark';

export abstract class AVisibilityBenchmark extends Benchmark {
  protected bunnies: PIXI.Sprite[] = [];

  public constructor(width: number, height: number, private numberOfObjects: number) {
    super(width, height);
    this.assetsToLoad.set('bunny', '../assets/bunny.png');
  }

  public async init(): Promise<void> {
    await super.init();

    const container = new PIXI.Container();

    for (let i = 0; i < this.numberOfObjects; i++) {
      const bunny = new PIXI.Sprite(this.app.loader.resources.bunny.texture);
      container.addChild(bunny);
      bunny.x = this.app.renderer.screen.width / 2 + Math.random() * 300 - 150;
      bunny.y = this.app.renderer.screen.height / 2 + Math.random() * 300 - 150;
      bunny.rotation = Math.random() * Math.PI;
      bunny.anchor = new PIXI.Point(0.5, 0.5);
      this.bunnies.push(bunny);
    }

    this.app.stage.addChild(container);
  }
}
