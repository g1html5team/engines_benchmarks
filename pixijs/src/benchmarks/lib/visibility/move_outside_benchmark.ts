import { AVisibilityBenchmark } from './a_visibility_benchmark';

export class MoveOutsideBenchmark extends AVisibilityBenchmark {
  // eslint-disable-next-line class-methods-use-this
  protected eachFrameCallback(deltaTime: number, timeSinceStart: number): void {
    if (timeSinceStart > 2000) {
      this.bunnies.forEach((bunny) => {
        // TODO (sch) probably not the expected behavior
        bunny.x = Math.random() * (2 * this.app.renderer.screen.width);
        bunny.y = Math.random() * (2 * this.app.renderer.screen.height);
      });
    }
  }
}
