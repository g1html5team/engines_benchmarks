import '../../../canvas.css';
import * as PIXI from 'pixi.js';
import BgRotate from '../assets/bg_rotate.jpg';
import BgSceneRotate from '../assets/bg_scene_rotate.jpg';
import LightRotate1 from '../assets/light_rotate_1.png';
import LightRotate2 from '../assets/light_rotate_2.png';
import Panda from '../assets/panda.png';

const app = new PIXI.Application({ antialias: true });
document.body.appendChild(app.view);

app.stage.interactive = true;

const bg = PIXI.Sprite.from(BgRotate);

bg.anchor.set(0.5);

bg.x = app.screen.width / 2;
bg.y = app.screen.height / 2;

app.stage.addChild(bg);

const container = new PIXI.Container();
container.x = app.screen.width / 2;
container.y = app.screen.height / 2;

// add a bunch of sprites
const bgFront = PIXI.Sprite.from(BgSceneRotate);
bgFront.anchor.set(0.5);

const light1 = PIXI.Sprite.from(LightRotate1);
light1.anchor.set(0.5);

const light2 = PIXI.Sprite.from(LightRotate2);
light2.anchor.set(0.5);

const panda = PIXI.Sprite.from(Panda);
panda.anchor.set(0.5);

container.addChild(bgFront, light2, light1, panda);

app.stage.addChild(container);

// Let's create a moving shape
const movingShape = new PIXI.Graphics();
app.stage.addChild(movingShape);
movingShape.x = app.screen.width / 2;
movingShape.y = app.screen.height / 2;
movingShape.lineStyle(0);

container.mask = movingShape;

let count = 0;

app.stage.on('pointertap', () => {
  if (!container.mask) {
    container.mask = movingShape;
  } else {
    container.mask = null;
  }
});

const help = new PIXI.Text('Click or tap to turn masking on / off.', {
  fontFamily: 'Arial',
  fontSize: 12,
  fontWeight: 'bold',
  fill: 'white',
});
help.y = app.screen.height - 26;
help.x = 10;
app.stage.addChild(help);

app.ticker.add(() => {
  bg.rotation += 0.01;
  bgFront.rotation -= 0.01;

  light1.rotation += 0.02;
  light2.rotation += 0.01;

  panda.scale.x = 1 + Math.sin(count) * 0.04;
  panda.scale.y = 1 + Math.cos(count) * 0.04;

  count += 0.1;

  movingShape.clear();

  movingShape.beginFill(0x8bc5ff, 0.4);
  movingShape.moveTo(-120 + Math.sin(count) * 20, -100 + Math.cos(count) * 20);
  movingShape.lineTo(120 + Math.cos(count) * 20, -100 + Math.sin(count) * 20);
  movingShape.lineTo(120 + Math.sin(count) * 20, 100 + Math.cos(count) * 20);
  movingShape.lineTo(-120 + Math.cos(count) * 20, 100 + Math.sin(count) * 20);
  movingShape.rotation = count * 0.1;
});
