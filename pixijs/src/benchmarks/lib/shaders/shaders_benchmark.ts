import * as PIXI from 'pixi.js';
import { ShaderType } from './shader_type';
import { AShadersBenchmark } from './a_shaders_benchmark';

export class ShadersBenchmark extends AShadersBenchmark {
  public constructor(width: number, height: number, numberOfObjects: number, private shaderType: ShaderType) {
    super(width, height, numberOfObjects, shaderType === ShaderType.Displacement);
  }

  public async init(): Promise<void> {
    await super.init();

    for (let i = 0; i < this.numberOfObjects; i++) {
      const bunny = new PIXI.Sprite(this.app.loader.resources.bunny.texture);
      this.container.addChild(bunny);
      bunny.x = 50 + Math.random() * (this.app.renderer.screen.width - 50);
      bunny.y = 50 + Math.random() * (this.app.renderer.screen.height - 50);
      bunny.rotation = Math.random() * Math.PI;
      bunny.anchor = new PIXI.Point(0.5, 0.5);

      let filter: PIXI.Filter;
      switch (this.shaderType) {
        case ShaderType.Blur:
          filter = new PIXI.filters.BlurFilter();
          break;
        case ShaderType.Displacement:
          filter = new PIXI.filters.DisplacementFilter(this.movingBunny, 5.0);
          break;
        default:
          filter = new PIXI.filters.NoiseFilter();
      }
      bunny.filters = [filter];
    }
  }
}
