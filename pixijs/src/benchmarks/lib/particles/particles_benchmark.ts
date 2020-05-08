import * as PIXI from 'pixi.js';
import { Benchmark } from '../benchmark';

export class ParticlesBenchmark extends Benchmark {
  private particles: PIXI.Container[] = [];

  public constructor(width: number, height: number, private numberOfObjects: number) {
    super(width, height);
    this.assetsToLoad.set('bunny', '../assets/bunny.png');
  }

  public async init(): Promise<void> {
    await super.init();

    const container = new PIXI.Container();

    for (let i = 0; i < this.numberOfObjects; i++) {
      const particle = ParticlesBenchmark.createParticle();
      container.addChild(particle);
      particle.x = Math.random() * this.app.renderer.screen.width;
      particle.y = Math.random() * this.app.renderer.screen.height;
      this.particles.push(particle);
    }

    this.app.stage.addChild(container);
  }

  private static createParticle(): PIXI.Container {
    const radius = 20;
    const container = new PIXI.Container();
    const points = new PIXI.Graphics();

    points.beginFill(0xffff0b, 1);
    for (let i = -20; i <= 20; i++) {
      points.drawCircle(i, Math.sqrt(radius * radius - i * i), 2);
    }
    points.endFill();
    container.addChild(points);

    return container;
  }

  protected eachFrameCallback(): void {
    this.particles.forEach(() => {
      // TODO (sch) former benchmark does nothing
    });
  }
}
