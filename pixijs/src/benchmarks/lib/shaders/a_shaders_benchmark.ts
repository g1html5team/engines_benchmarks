import * as PIXI from 'pixi.js';
import { Benchmark } from '../benchmark';

export class AShadersBenchmark extends Benchmark {
  protected movingBunny: PIXI.Sprite;
  private movingBunnyDirection = new PIXI.Point(1, 0.5);
  protected container = new PIXI.Container();

  public constructor(
    width: number,
    height: number,
    protected numberOfObjects: number,
    private withDisplacement: boolean,
  ) {
    super(width, height);
    this.assetsToLoad.set('bunny', '../assets/bunny.png');
    this.assetsToLoad.set('background_fields', '../assets/background_fields.jpg');
  }

  public async init(): Promise<void> {
    await super.init();

    const background = new PIXI.Sprite(this.app.loader.resources.background_fields.texture);
    this.app.stage.addChild(background);

    if (this.withDisplacement) {
      this.movingBunny = new PIXI.Sprite(this.app.loader.resources.bunny.texture);
      this.container.addChild(this.movingBunny);
      this.movingBunny.anchor = new PIXI.Point(0.5, 0.5);
      this.movingBunny.alpha = 0.25;
      this.movingBunny.x = 25;
      this.movingBunny.y = 75;
    }

    this.app.stage.addChild(this.container);
  }

  protected eachFrameCallback(deltaTime?: number, timeSinceStart?: number): void {
    if (this.withDisplacement) {
      if (this.movingBunny.x > this.app.renderer.screen.width) {
        this.movingBunnyDirection.set(-1 * Math.random(), this.movingBunnyDirection.y);
      } else if (this.movingBunny.x < 0) {
        this.movingBunnyDirection.set(Math.random(), this.movingBunnyDirection.y);
      }
      if (this.movingBunny.y > this.app.renderer.screen.height) {
        this.movingBunnyDirection.set(this.movingBunnyDirection.x * Math.random(), -1 * Math.random());
      } else if (this.movingBunny.y < 0) {
        this.movingBunnyDirection.set(this.movingBunnyDirection.x * Math.random(), Math.random());
      }

      this.movingBunny.x += this.movingBunnyDirection.x * 100;
      this.movingBunny.y += this.movingBunnyDirection.y * 100;
    }
  }
}
