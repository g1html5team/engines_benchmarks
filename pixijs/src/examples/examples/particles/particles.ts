import '../../../canvas.css';
import * as PIXI from 'pixi.js';
import * as particles from 'pixi-particles';

const app = new PIXI.Application({
  width: 800,
  height: 600,
  backgroundColor: 0x1099bb,
  resolution: 1,
});

document.body.appendChild(app.view);

const container = new PIXI.Container();
container.x = app.renderer.screen.width / 2;
container.y = app.renderer.screen.width / 2;

app.stage.addChild(container);

// Create a new texture
app.loader.add('particle', 'examples/assets/particle.png');
app.loader.load(() => {
  const emitter = new particles.Emitter(container, [app.loader.resources.particle.texture], {
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
  emitter.emit = true;

  app.ticker.start();
});
