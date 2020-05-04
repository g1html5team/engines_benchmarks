import '../../../canvas.css';
import * as PIXI from 'pixi.js';

const app = new PIXI.Application();
document.body.appendChild(app.view);

// Holder to store aliens
const aliens: PIXI.Sprite[] = [];
const alienFrames = ['eggHead.png', 'flowerTop.png', 'helmlok.png', 'skully.png'];

let count = 0;

// Create an empty container
const alienContainer = new PIXI.Container();
alienContainer.x = 400;
alienContainer.y = 300;

function onAssetsLoaded(): void {
  // Add a bunch of aliens with textures from image paths
  for (let i = 0; i < 100; i++) {
    const frameName = alienFrames[i % 4];

    // Create an alien using the frame name..
    const alien = PIXI.Sprite.from(frameName);
    alien.tint = Math.random() * 0xffffff;

    /*
     * Fun fact for the day :)
     * Another way of doing the above would be
     * let texture = PIXI.Texture.from(frameName);
     * let alien = new PIXI.Sprite(texture);
     */
    alien.x = Math.random() * 800 - 400;
    alien.y = Math.random() * 600 - 300;
    alien.anchor.x = 0.5;
    alien.anchor.y = 0.5;
    aliens.push(alien);
    alienContainer.addChild(alien);
  }
  app.start();
}

function onClick(): void {
  alienContainer.cacheAsBitmap = !alienContainer.cacheAsBitmap;

  // Feel free to play with what's below
  // let sprite = new PIXI.Sprite(alienContainer.generateTexture());
  // app.stage.addChild(sprite);
  // sprite.x = Math.random() * 800;
  // sprite.y = Math.random() * 600;
}

app.stop();

// Load resources
app.loader.add('spritesheet', 'examples/examples/assets/spritesheet/monsters.json').load(onAssetsLoaded);

// Make the stage interactive
app.stage.interactive = true;
app.stage.addChild(alienContainer);

// Combines both mouse click + touch tap
app.stage.on('pointertap', onClick);

app.ticker.add(() => {
  // Let's rotate the aliens a little bit
  for (let i = 0; i < 100; i++) {
    const alien = aliens[i];
    alien.rotation += 0.1;
  }

  count += 0.01;

  alienContainer.scale.x = Math.sin(count);
  alienContainer.scale.y = Math.sin(count);
  alienContainer.rotation += 0.01;
});
