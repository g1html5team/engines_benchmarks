import { AVisibilityBenchmark } from './a_visibility_benchmark';

export class OutOfSceneBenchmark extends AVisibilityBenchmark {
  // eslint-disable-next-line class-methods-use-this
  protected eachFrameCallback(deltaTime: number, timeSinceStart: number): void {
    if (timeSinceStart > 2000) {
      this.bunnies.forEach((bunny) => {
        bunny.x =
          -200 +
          Math.floor(Math.random() * 10) +
          Math.floor(Math.random() * 2) * (this.app.renderer.screen.width + 400);
        bunny.y =
          -200 +
          Math.floor(Math.random() * 10) +
          Math.floor(Math.random() * 2) +
          (this.app.renderer.screen.height + 400);
        bunny.rotation = 1;
      });
    }
  }
}
