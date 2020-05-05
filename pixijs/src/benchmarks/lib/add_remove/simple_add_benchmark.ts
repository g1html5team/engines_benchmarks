import * as PIXI from 'pixi.js';
import { Benchmark } from '../benchmark';

export class SimpleAddBenchmark extends Benchmark {
  private bunnies: PIXI.Sprite[] = [];
  private container: PIXI.Container = new PIXI.Container();

  public constructor(width: number, height: number, private numberOfObjects: number) {
    super(width, height);
  }

  public async init(): Promise<void> {
    await super.init();

    for (let i = 0; i < this.numberOfObjects; i++) {
      const bunny = new PIXI.Sprite(this.app.loader.resources.bunny.texture);
      this.bunnies.push(bunny);
    }

    this.app.stage.addChild(this.container);
  }

  protected eachFrameCallback(): void {
    this.bunnies.forEach((bunny) => {
      this.container.addChild(bunny);
      bunny.x = Math.random() * this.app.renderer.screen.width;
      bunny.y = Math.random() * this.app.renderer.screen.height;
    });
  }
}
