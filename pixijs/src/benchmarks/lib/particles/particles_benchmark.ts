import * as PIXI from 'pixi.js';
import * as particles from 'pixi-particles';
import { Benchmark } from '../benchmark';

export class ParticlesBenchmark extends Benchmark {
  private container = new PIXI.Container();
  private emitter: particles.Emitter;

  public constructor(width: number, height: number, private numberOfObjects: number) {
    super(width, height);
    this.assetsToLoad.set('particle', '../assets/particles/particle.png');
  }

  public async init(): Promise<void> {
    await super.init();

    this.container.x = Math.random() * this.app.renderer.screen.width;
    this.container.y = Math.random() * this.app.renderer.screen.height;

    this.emitter = new particles.Emitter(this.container, [this.app.loader.resources.particle.texture], {
      alpha: {
        list: [
          {
            value: 1,
            time: 0,
          },
          {
            value: 0,
            time: 1,
          },
        ],
        isStepped: false,
      },
      scale: {
        list: [
          {
            value: 1,
            time: 0,
          },
          {
            value: 2,
            time: 1,
          },
        ],
        isStepped: false,
      },
      color: {
        list: [
          {
            value: 'fb1010',
            time: 0,
          },
          {
            value: 'f5b830',
            time: 1,
          },
        ],
        isStepped: false,
      },
      speed: {
        list: [
          {
            value: 200,
            time: 0,
          },
          {
            value: 100,
            time: 1,
          },
        ],
        isStepped: false,
      },
      startRotation: {
        min: 0,
        max: 360,
      },
      rotationSpeed: {
        min: 0,
        max: 0,
      },
      rotationAcceleration: 20,
      lifetime: {
        min: 0.5,
        max: 0.9,
      },
      acceleration: {
        x: 10,
        y: 10,
      },
      frequency: 0.008,
      spawnChance: 1,
      particlesPerWave: 1,
      emitterLifetime: -1,
      maxParticles: 1000,
      pos: {
        x: 0,
        y: 0,
      },
      addAtBack: false,
      spawnType: 'circle',
      spawnCircle: {
        x: 0,
        y: 0,
        r: 5,
      },
      autoUpdate: true,
    });
    this.emitter.emit = true;

    this.app.stage.addChild(this.container);
  }

  // eslint-disable-next-line class-methods-use-this
  protected eachFrameCallback(): void {}
}
