import '../../../canvas.css';
import * as PIXI from 'pixi.js';
import { Slot } from './model/slot';

const app = new PIXI.Application({ backgroundColor: 0x1099bb });
document.body.appendChild(app.view);

const REEL_WIDTH = 160;
const SYMBOL_SIZE = 150;

function onAssetsLoaded(): void {
  const symbolsTextures = [
    PIXI.Texture.from('eggHead.png'),
    PIXI.Texture.from('flowerTop.png'),
    PIXI.Texture.from('helmlok.png'),
    PIXI.Texture.from('skully.png'),
  ];

  // Create the slot
  const slot: Slot = new Slot(symbolsTextures, REEL_WIDTH, SYMBOL_SIZE, app.ticker);
  app.stage.addChild(slot);

  // Build top & bottom covers and position slot
  const margin = (app.screen.height - SYMBOL_SIZE * 3) / 2;
  slot.y = margin;
  slot.x = Math.round(app.screen.width - REEL_WIDTH * 5);

  const top = new PIXI.Graphics();
  top.beginFill(0, 1);
  top.drawRect(0, 0, app.screen.width, margin);

  const bottom = new PIXI.Graphics();
  bottom.beginFill(0, 1);
  bottom.drawRect(0, SYMBOL_SIZE * 3 + margin, app.screen.width, margin);

  // Add play text
  const style = new PIXI.TextStyle({
    fontFamily: 'Arial',
    fontSize: 36,
    fontStyle: 'italic',
    fontWeight: 'bold',
    fill: ['#ffffff', '#00ff99'], // gradient
    stroke: '#4a1850',
    strokeThickness: 5,
    dropShadow: true,
    dropShadowColor: '#000000',
    dropShadowBlur: 4,
    dropShadowAngle: Math.PI / 6,
    dropShadowDistance: 6,
    wordWrap: true,
    wordWrapWidth: 440,
  });

  const playText = new PIXI.Text('Spin the wheels!', style);
  playText.x = Math.round((bottom.width - playText.width) / 2);
  playText.y = app.screen.height - margin + Math.round((margin - playText.height) / 2);
  bottom.addChild(playText);

  // Add header text
  const headerText = new PIXI.Text('PIXI MONSTER SLOTS!', style);
  headerText.x = Math.round((top.width - headerText.width) / 2);
  headerText.y = Math.round((margin - headerText.height) / 2);
  top.addChild(headerText);

  app.stage.addChild(top);
  app.stage.addChild(bottom);

  // Set the interactivity
  bottom.interactive = true;
  bottom.buttonMode = true;
  bottom.addListener('pointerdown', () => slot.spin());
}

app.loader.add('spritesheet', 'examples/assets/spritesheet/monsters.json').load(onAssetsLoaded);
