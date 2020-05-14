import { AZIndexBenchmark } from './a_zindex_benchmark';

export class ZIndexRandomChildrenBenchmark extends AZIndexBenchmark {
  public constructor(width: number, height: number, numberOfObjects: number) {
    super(width, height, numberOfObjects);
  }

  protected eachFrameCallback(): void {
    this.bunnies.forEach((bunny) => {
      this.container.addChildAt(bunny, Math.floor(Math.random() * this.numberOfObjects));
    });
  }
}
