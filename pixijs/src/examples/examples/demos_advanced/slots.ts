import '../styles.css';
import * as PIXI from 'pixi.js';

const app = new PIXI.Application({ backgroundColor: 0x1099bb });
document.body.appendChild(app.view);

const REEL_WIDTH = 160;
const SYMBOL_SIZE = 150;

interface Reel {
  container: PIXI.Container;
  symbols: PIXI.Sprite[];
  position: number;
  previousPosition: number;
  blur: PIXI.filters.BlurFilter;
}

interface Tween {
  object: Reel;
  property: string;
  propertyBeginValue: number;
  target: number;
  easing: Function;
  time: number;
  change: Function;
  complete: Function;
  start: number;
}

// Basic lerp funtion.
function lerp(a1: number, a2: number, t: number): number {
  return a1 * (1 - t) + a2 * t;
}

// Backout function from tweenjs.
// https://github.com/CreateJS/TweenJS/blob/master/src/tweenjs/Ease.js
function backout(amount: number): Function {
  // eslint-disable-next-line no-param-reassign
  return (t: number): number => --t * t * ((amount + 1) * t + amount) + 1;
}

// Very simple tweening utility function. This should be replaced with a proper tweening library in a real product.
const tweening: Tween[] = [];
function tweenTo(
  object: Reel,
  property: string,
  target: number,
  time: number,
  easing: Function,
  onchange: Function,
  oncomplete: Function,
): Tween {
  const tween: Tween = {
    object,
    property,
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    propertyBeginValue: (object as any)[property],
    target,
    easing,
    time,
    change: onchange,
    complete: oncomplete,
    start: Date.now(),
  };

  tweening.push(tween);
  return tween;
}

// onAssetsLoaded handler builds the example.
function onAssetsLoaded(): void {
  let running = false;
  const reels: Reel[] = [];
  const reelContainer = new PIXI.Container();

  // Reels done handler.
  function reelsComplete(): void {
    running = false;
  }

  // Function to start playing.
  function startPlay(): void {
    if (running) return;
    running = true;

    for (let i = 0; i < reels.length; i++) {
      const r = reels[i];
      const extra = Math.floor(Math.random() * 3);
      const target = r.position + 10 + i * 5 + extra;
      const time = 2500 + i * 600 + extra * 600;
      tweenTo(r, 'position', target, time, backout(0.5), null, i === reels.length - 1 ? reelsComplete : null);
    }
  }

  // Create different slot symbols.
  const slotTextures = [
    PIXI.Texture.from('eggHead.png'),
    PIXI.Texture.from('flowerTop.png'),
    PIXI.Texture.from('helmlok.png'),
    PIXI.Texture.from('skully.png'),
  ];

  // Build the reels
  for (let i = 0; i < 5; i++) {
    const rc = new PIXI.Container();
    rc.x = i * REEL_WIDTH;
    reelContainer.addChild(rc);

    const reel: Reel = {
      container: rc,
      symbols: [],
      position: 0,
      previousPosition: 0,
      blur: new PIXI.filters.BlurFilter(),
    };

    reel.blur.blurX = 0;
    reel.blur.blurY = 0;
    rc.filters = [reel.blur];

    // Build the symbols
    for (let j = 0; j < 4; j++) {
      const symbol = new PIXI.Sprite(slotTextures[Math.floor(Math.random() * slotTextures.length)]);
      // Scale the symbol to fit symbol area.
      symbol.y = j * SYMBOL_SIZE;
      const scale = Math.min(SYMBOL_SIZE / symbol.width, SYMBOL_SIZE / symbol.height);
      symbol.scale.x = scale;
      symbol.scale.y = scale;
      symbol.x = Math.round((SYMBOL_SIZE - symbol.width) / 2);
      reel.symbols.push(symbol);
      rc.addChild(symbol);
    }
    reels.push(reel);
  }
  app.stage.addChild(reelContainer);

  // Build top & bottom covers and position reelContainer
  const margin = (app.screen.height - SYMBOL_SIZE * 3) / 2;
  reelContainer.y = margin;
  reelContainer.x = Math.round(app.screen.width - REEL_WIDTH * 5);
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

  // Set the interactivity.
  bottom.interactive = true;
  bottom.buttonMode = true;
  bottom.addListener('pointerdown', () => {
    startPlay();
  });

  // Listen for animate update.
  app.ticker.add(() => {
    // Update the slots.
    for (let i = 0; i < reels.length; i++) {
      const r = reels[i];
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
          s.texture = slotTextures[Math.floor(Math.random() * slotTextures.length)];
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
  for (let i = 0; i < tweening.length; i++) {
    const tween = tweening[i];
    const phase = Math.min(1, (now - tween.start) / tween.time);

    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    (tween.object as any)[tween.property] = lerp(tween.propertyBeginValue, tween.target, tween.easing(phase));
    if (tween.change) tween.change(tween);
    if (phase === 1) {
      // eslint-disable-next-line @typescript-eslint/no-explicit-any
      (tween.object as any)[tween.property] = tween.target;
      if (tween.complete) tween.complete(tween);
      remove.push(tween);
    }
  }
  for (let i = 0; i < remove.length; i++) {
    tweening.splice(tweening.indexOf(remove[i]), 1);
  }
});
