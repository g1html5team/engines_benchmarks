import * as PIXI from 'pixi.js';
import { ShaderType } from './shader_type';
import { AShadersBenchmark } from './a_shaders_benchmark';

export class ShadersStepByStepBenchmark extends AShadersBenchmark {
  private bunnies: PIXI.Sprite[] = [];
  private currentShaderType = ShaderType.Blur;
  private nextStepTime = 750;

  public constructor(width: number, height: number, numberOfObjects: number) {
    super(width, height, numberOfObjects, true);
  }

  protected eachFrameCallback(deltaTime: number, timeSinceStart: number): void {
    super.eachFrameCallback();

    if (timeSinceStart > this.nextStepTime) {
      this.nextStepTime += 750;

      if (this.bunnies.length >= this.numberOfObjects) {
        this.bunnies.forEach((bunny) => {
          this.container.removeChild(bunny);
        });

        this.bunnies = [];
      }

      for (let i = 0; i < this.numberOfObjects / 3; i++) {
        const bunny = new PIXI.Sprite(this.app.loader.resources.bunny.texture);
        this.container.addChild(bunny);
        bunny.x = 50 + Math.random() * (this.app.renderer.screen.width - 50);
        bunny.y = 50 + Math.random() * (this.app.renderer.screen.height - 50);
        bunny.rotation = Math.random() * Math.PI;
        bunny.anchor = new PIXI.Point(0.5, 0.5);

        let filter: PIXI.Filter;
        switch (this.currentShaderType) {
          case ShaderType.Blur:
            filter = new PIXI.filters.BlurFilter();
            this.currentShaderType = ShaderType.Glow;
            break;
          case ShaderType.Displacement:
            filter = new PIXI.filters.DisplacementFilter(this.movingBunny, 5.0);
            this.currentShaderType = ShaderType.Blur;
            break;
          default:
            filter = new PIXI.filters.NoiseFilter();
            this.currentShaderType = ShaderType.Displacement;
        }
        bunny.filters = [filter];
      }
    }
  }
}
