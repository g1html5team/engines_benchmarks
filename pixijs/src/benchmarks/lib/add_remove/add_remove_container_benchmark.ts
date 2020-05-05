import * as PIXI from 'pixi.js';
import { Benchmark } from '../benchmark';

export class AddRemoveContainerBenchmark extends Benchmark {
  private container1: PIXI.Container = new PIXI.Container();
  private container2: PIXI.Container = new PIXI.Container();
  private hasContainer1 = true;

  public constructor(width: number, height: number, private numberOfObjects: number) {
    super(width, height);
  }

  public async init(): Promise<void> {
    await super.init();

    for (let i = 0; i < this.numberOfObjects; i++) {
      const bunny = new PIXI.Sprite(this.app.loader.resources.bunny.texture);
      bunny.x = Math.random() * this.app.renderer.screen.width;
      bunny.y = Math.random() * this.app.renderer.screen.height;
      this.container1.addChild(bunny);
      this.container2.addChild(bunny);
    }

    this.app.stage.addChild(this.container1);
  }

  protected eachFrameCallback(): void {
    const containerToAdd = this.hasContainer1 ? this.container2 : this.container1;
    const containerToRemove = this.hasContainer1 ? this.container1 : this.container2;

    this.app.stage.removeChild(containerToRemove);
    this.app.stage.addChild(containerToAdd);

    if (this.hasContainer1) {
      this.container1 = new PIXI.Container();
    } else {
      this.container2 = new PIXI.Container();
    }

    for (let i = 0; i < this.numberOfObjects; i++) {
      const bunny = new PIXI.Sprite(this.app.loader.resources.bunny.texture);
      bunny.x = Math.random() * this.app.renderer.screen.width;
      bunny.y = Math.random() * this.app.renderer.screen.height;
      if (this.hasContainer1) {
        this.container1.addChild(bunny);
      } else {
        this.container2.addChild(bunny);
      }
    }

    this.hasContainer1 = !this.hasContainer1;
  }
}
