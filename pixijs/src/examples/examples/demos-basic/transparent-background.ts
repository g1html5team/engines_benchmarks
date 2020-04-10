import '../styles.css';
import * as PIXI from 'pixi.js';
import Bunny from '../assets/bunny.png';

const app = new PIXI.Application({ transparent: true });

document.body.appendChild(app.view);

// create a new Sprite from an image path.
const bunny = PIXI.Sprite.from(Bunny);

// center the sprite's anchor point
bunny.anchor.set(0.5);

// move the sprite to the center of the screen
bunny.x = app.screen.width / 2;
bunny.y = app.screen.height / 2;

app.stage.addChild(bunny);

app.ticker.add(() => {
  // just for fun, let's rotate mr rabbit a little
  bunny.rotation += 0.1;
});
