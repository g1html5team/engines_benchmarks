import * as PIXI from 'pixi.js';
import { Benchmark } from '../benchmark';

export class SimpleAddRemoveBenchmark extends Benchmark {
  private bunnies: PIXI.Sprite[] = [];
  private removedBunnies: PIXI.Sprite[] = [];
  private container: PIXI.Container = new PIXI.Container();
  private drawNow = false;

  public constructor(width: number, height: number, private numberOfObjects: number) {
    super(width, height);
  }

  public async init(): Promise<void> {
    await super.init();

    for (let i = 0; i < this.numberOfObjects; i++) {
      const bunny = new PIXI.Sprite(this.app.loader.resources.bunny.texture);
      this.container.addChild(bunny);
      this.setRandomPosition(bunny);
      bunny.anchor = new PIXI.Point(0.5);
      this.bunnies.push(bunny);
    }

    this.app.stage.addChild(this.container);
  }

  protected eachFrameCallback(): void {
    if (this.removedBunnies.length === 0 && this.container.children.length > 0) {
      this.bunnies.forEach((bunny) => {
        this.container.removeChild(bunny);
        this.removedBunnies.push(bunny);
      });
    } else if (this.drawNow) {
      this.drawNow = false;
    } else {
      this.removedBunnies.forEach((bunny) => {
        this.container.addChild(bunny);
        this.setRandomPosition(bunny);
      });
      this.drawNow = true;
      this.removedBunnies = [];
    }
  }

  private setRandomPosition(sprite: PIXI.Sprite): void {
    sprite.x = Math.random() * this.app.renderer.screen.width;
    sprite.y = Math.random() * this.app.renderer.screen.height;
    sprite.rotation = Math.random() * Math.PI;
  }
}
