import '../../../canvas.css';
import * as PIXI from 'pixi.js';
import EggHead from '../assets/eggHead.png';
import FlowerTop from '../assets/flowerTop.png';

const app = new PIXI.Application();
document.body.appendChild(app.view);

let isEggHead = false;

// Create a texture from an image path
const flowerTopTexture = PIXI.Texture.from(FlowerTop);

// Create a second texture
const eggHeadTexture = PIXI.Texture.from(EggHead);

// Create a new Sprite using the texture
const dude = new PIXI.Sprite(flowerTopTexture);

// Center the sprites anchor point
dude.anchor.set(0.5);

// Move the sprite to the center of the screen
dude.x = app.screen.width / 2;
dude.y = app.screen.height / 2;

app.stage.addChild(dude);

// Make the sprite interactive
dude.interactive = true;
dude.buttonMode = true;

dude.on('pointertap', () => {
  isEggHead = !isEggHead;
  if (isEggHead) {
    dude.texture = eggHeadTexture;
  } else {
    dude.texture = flowerTopTexture;
  }
});

app.ticker.add(() => {
  // just for fun, let's rotate mr rabbit a little
  dude.rotation += 0.1;
});
