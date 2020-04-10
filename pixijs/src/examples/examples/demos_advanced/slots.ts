import '../styles.css';
import * as PIXI from 'pixi.js';
import { Tween, TweenUtils } from './model/tween';
import { Slot } from './model/slot';

const app = new PIXI.Application({ backgroundColor: 0x1099bb });
document.body.appendChild(app.view);

const REEL_WIDTH = 160;
const SYMBOL_SIZE = 150;

const tweens: Tween[] = [];

// onAssetsLoaded handler builds the example.
function onAssetsLoaded(): void {
  const symbolsTextures = [
    PIXI.Texture.from('eggHead.png'),
    PIXI.Texture.from('flowerTop.png'),
    PIXI.Texture.from('helmlok.png'),
    PIXI.Texture.from('skully.png'),
  ];

  // Create the slot
  const slot: Slot = new Slot(symbolsTextures);
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
  bottom.addListener('pointerdown', () => {
    tweens.push(...slot.spin());
  });

  // Listen for animate update.
  app.ticker.add(() => {
    // Update the slots.
    for (let i = 0; i < slot.reels.length; i++) {
      const r = slot.reels[i];
      // Update blur filter y amount based on speed.
      // This would be better if calculated with time in mind also. Now blur depends on frame rate.
      r.blur.blurY = (r.position - r.previousPosition) * 8;
      r.previousPosition = r.position;

      // Update symbol positions on reel.
      for (let j = 0; j < r.symbols.length; j++) {
        const s = r.symbols[j];
        const prevy = s.y;
        s.y = ((r.position + j) % r.symbols.length) * SYMBOL_SIZE - SYMBOL_SIZE;
        if (s.y < 0 && prevy > SYMBOL_SIZE) {
          // Detect going over and swap a texture.
          // This should in proper product be determined from some logical reel.
          s.texture = symbolsTextures[Math.floor(Math.random() * symbolsTextures.length)];
          const scale = Math.min(SYMBOL_SIZE / s.texture.width, SYMBOL_SIZE / s.texture.height);
          s.scale.x = scale;
          s.scale.y = scale;
          s.x = Math.round((SYMBOL_SIZE - s.width) / 2);
        }
      }
    }
  });
}

app.loader.add('spritesheet', 'examples/examples/assets/spritesheet/monsters.json').load(onAssetsLoaded);

// Listen for animate update.
app.ticker.add(() => {
  const now = Date.now();
  const remove = [];
  for (let i = 0; i < tweens.length; i++) {
    const tween = tweens[i];
    const phase = Math.min(1, (now - tween.start) / tween.time);

    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    (tween.object as any)[tween.property] = TweenUtils.lerp(
      tween.propertyBeginValue,
      tween.target,
      tween.easing(phase),
    );
    if (tween.change) tween.change(tween);
    if (phase === 1) {
      // eslint-disable-next-line @typescript-eslint/no-explicit-any
      (tween.object as any)[tween.property] = tween.target;
      if (tween.complete) tween.complete(tween);
      remove.push(tween);
    }
  }
  for (let i = 0; i < remove.length; i++) {
    tweens.splice(tweens.indexOf(remove[i]), 1);
  }
});
