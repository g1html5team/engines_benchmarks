import * as PIXI from 'pixi.js';
import { AFilterBenchmark } from './a_filter_benchmark';

export class FilterBrightnessBenchmark extends AFilterBenchmark {
  protected eachFrameCallback(): void {
    this.bunnies.forEach((bunny) => {
      const brightnessFilter = new PIXI.filters.ColorMatrixFilter();
      brightnessFilter.brightness(Math.random(), false);
      bunny.filters = [brightnessFilter];
    });
  }
}
