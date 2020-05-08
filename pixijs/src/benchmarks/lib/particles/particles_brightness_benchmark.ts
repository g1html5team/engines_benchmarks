import * as PIXI from 'pixi.js';
import { Benchmark } from '../benchmark';

export class ParticlesBrightnessBenchmark extends Benchmark {
  private bunnies: PIXI.Sprite[] = [];

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
      bunny.x = Math.random() * this.app.renderer.screen.width;
      bunny.y = Math.random() * this.app.renderer.screen.height;
      bunny.rotation = Math.random() * Math.PI;
      bunny.anchor = new PIXI.Point(0.5);
      this.bunnies.push(bunny);
    }

    this.app.stage.addChild(container);
  }

  protected eachFrameCallback(): void {
    this.bunnies.forEach((bunny) => {
      const brightnessFilter = new PIXI.filters.ColorMatrixFilter();
      brightnessFilter.brightness(Math.random() * 2, false);
      bunny.filters = [brightnessFilter];
    });
  }
}
