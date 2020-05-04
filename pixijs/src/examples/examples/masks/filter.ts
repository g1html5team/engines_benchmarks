import '../../../canvas.css';
import * as PIXI from 'pixi.js';
import BgGrass from '../assets/bg_grass.jpg';

const app = new PIXI.Application();
document.body.appendChild(app.view);

// Inner radius of the circle
const radius = 100;

// The blur amount
const blurSize = 32;

function setup(loader: PIXI.Loader, resources: Partial<Record<string, PIXI.LoaderResource>>): void {
  const background = new PIXI.Sprite(resources.grass.texture);
  app.stage.addChild(background);
  background.width = app.screen.width;
  background.height = app.screen.height;

  const circle = new PIXI.Graphics()
    .beginFill(0xff0000)
    .drawCircle(radius + blurSize, radius + blurSize, radius)
    .endFill();
  circle.filters = [new PIXI.filters.BlurFilter(blurSize)];

  const bounds = new PIXI.Rectangle(0, 0, (radius + blurSize) * 2, (radius + blurSize) * 2);
  const texture = app.renderer.generateTexture(circle, PIXI.SCALE_MODES.NEAREST, 1, bounds);
  const focus = new PIXI.Sprite(texture);

  app.stage.addChild(focus);
  background.mask = focus;

  function pointerMove(event: PIXI.interaction.InteractionEvent): void {
    focus.position.x = event.data.global.x - focus.width / 2;
    focus.position.y = event.data.global.y - focus.height / 2;
  }

  app.stage.interactive = true;
  app.stage.on('mousemove', pointerMove);
}

app.loader.add('grass', BgGrass);
app.loader.load(setup);
