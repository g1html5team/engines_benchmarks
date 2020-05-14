import * as PIXI from 'pixi.js';
import { Benchmark } from '../benchmark';

export abstract class AZIndexBenchmark extends Benchmark {
  protected bunnies: PIXI.Sprite[] = [];
  protected container: PIXI.Container = new PIXI.Container();

  protected constructor(width: number, height: number, protected numberOfObjects: number) {
    super(width, height);
    this.assetsToLoad.set('bunny', '../assets/bunny.png');
  }

  public async init(): Promise<void> {
    await super.init();

    for (let i = 0; i < this.numberOfObjects; i++) {
      const bunny = new PIXI.Sprite(this.app.loader.resources.bunny.texture);
      this.container.addChild(bunny);
      bunny.x = this.app.renderer.screen.width / 2 + Math.random() * 300 - 150;
      bunny.y = this.app.renderer.screen.height / 2 + Math.random() * 300 - 150;
      bunny.rotation = Math.random() * Math.PI;
      bunny.anchor = new PIXI.Point(0.5, 0.5);
      this.bunnies.push(bunny);
    }

    this.app.stage.addChild(this.container);
  }
}
