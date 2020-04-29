import '../../../canvas.css';
import * as PIXI from 'pixi.js';
import Bunny from '../assets/bunny.png';

const app = new PIXI.Application({ backgroundColor: 0x1099bb });
document.body.appendChild(app.view);

// Create a new Sprite from an image path
const bunny = PIXI.Sprite.from(Bunny);

// Center the sprite's anchor point
bunny.anchor.set(0.5);

// Move the sprite to the center of the screen
bunny.x = app.screen.width / 2;
bunny.y = app.screen.height / 2;

app.stage.addChild(bunny);

// Listen for animate update
app.ticker.add((delta) => {
  // just for fun, let's rotate mr rabbit a little
  // delta is 1 if running at 100% performance
  // creates frame-independent transformation
  bunny.rotation += 0.1 * delta;
});
