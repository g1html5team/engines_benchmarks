import * as PIXI from 'pixi.js';
import { AFilterBenchmark } from './a_filter_benchmark';

export class FilterHueBenchmark extends AFilterBenchmark {
  protected eachFrameCallback(): void {
    this.bunnies.forEach((bunny) => {
      const brightnessFilter = new PIXI.filters.ColorMatrixFilter();
      brightnessFilter.hue(Math.random() * 360, false);
      bunny.filters = [brightnessFilter];
    });
  }
}
