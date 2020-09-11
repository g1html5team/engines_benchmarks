import '../../../canvas.css';
import * as PIXI from 'pixi.js-legacy';
import Bunny from '../assets/bunny.png';

const app = new PIXI.Application({
  width: 800,
  height: 600,
  backgroundColor: 0x1099bb,
  forceCanvas: true,
});

document.body.appendChild(app.view);

const text = new PIXI.Text(
  app.renderer.type === PIXI.RENDERER_TYPE.CANVAS
    ? 'Using canvas'
    : `Using WegGL ${(app.renderer.context as PIXI.systems.ContextSystem).webGLVersion}`,
);
app.stage.addChild(text);

const container = new PIXI.Container();

app.stage.addChild(container);

// Create a new texture
const texture = PIXI.Texture.from(Bunny);

// Create a 5x5 grid of bunnies
for (let i = 0; i < 25; i++) {
  const bunny = new PIXI.Sprite(texture);
  bunny.anchor.set(0.5);
  bunny.x = (i % 5) * 40;
  bunny.y = Math.floor(i / 5) * 40;
  container.addChild(bunny);
}

// Move container to the center
container.x = app.screen.width / 2;
container.y = app.screen.height / 2;

// Center bunny sprite in local container coordinates
container.pivot.x = container.width / 2;
container.pivot.y = container.height / 2;

// Listen for animate update
app.ticker.add((delta) => {
  // rotate the container!
  // use delta to create frame-independent transform
  container.rotation -= 0.01 * delta;
});