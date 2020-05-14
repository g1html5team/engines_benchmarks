import { AVisibilityBenchmark } from './a_visibility_benchmark';

export class AlphaBenchmark extends AVisibilityBenchmark {
  // eslint-disable-next-line class-methods-use-this
  protected eachFrameCallback(deltaTime: number, lastTime: number): void {
    if (lastTime > 2000) {
      this.bunnies.forEach((bunny) => {
        bunny.x = Math.random() * this.app.renderer.screen.width;
        bunny.y = Math.random() * this.app.renderer.screen.height;
        bunny.alpha = 0;
      });
    }
  }
}