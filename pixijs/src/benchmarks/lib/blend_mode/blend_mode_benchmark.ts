import * as PIXI from 'pixi.js';
import { Benchmark } from '../benchmark';

export class BlendModeBenchmark extends Benchmark {
  private bunnies: PIXI.Sprite[] = [];

  public constructor(
    width: number,
    height: number,
    private numberOfObjects: number,
    private blendMode?: PIXI.BLEND_MODES,
  ) {
    super(width, height);
    this.assetsToLoad.set('bunny', '../assets/bunny.png');
    this.assetsToLoad.set('backgroundFields', '../assets/background_fields.jpg');
    this.assetsToLoad.set('backgroundForest', '../assets/background_forest.jpg');
  }

  public async init(): Promise<void> {
    await super.init();

    const container = new PIXI.Container();

    const backgroundFields = new PIXI.Sprite(this.app.loader.resources.backgroundFields.texture);
    backgroundFields.blendMode = this.blendMode ?? Math.floor(Math.random() * 32);
    container.addChild(backgroundFields);

    const backgroundForest = new PIXI.Sprite(this.app.loader.resources.backgroundForest.texture);
    backgroundFields.blendMode = this.blendMode ?? Math.floor(Math.random() * 32);
    container.addChild(backgroundForest);

    for (let i = 0; i < this.numberOfObjects; i++) {
      const bunny = new PIXI.Sprite(this.app.loader.resources.bunny.texture);
      container.addChild(bunny);
      bunny.x = Math.random() * this.app.renderer.screen.width;
      bunny.y = Math.random() * this.app.renderer.screen.height;
      bunny.rotation = Math.random() * Math.PI;
      bunny.anchor = new PIXI.Point(0.5);

      bunny.blendMode = this.blendMode ?? Math.floor(Math.random() * 32);

      this.bunnies.push(bunny);
    }

    const backgroundForest2 = new PIXI.Sprite(this.app.loader.resources.backgroundForest.texture);
    backgroundForest2.blendMode = this.blendMode ?? Math.floor(Math.random() * 32);
    container.addChild(backgroundForest2);

    this.app.stage.addChild(container);
  }

  protected eachFrameCallback(): void {
    this.bunnies.forEach((bunny) => {
      bunny.x = Math.random() * this.app.renderer.screen.width;
      bunny.y = Math.random() * this.app.renderer.screen.height;
    });
  }
}
