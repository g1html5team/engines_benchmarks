import * as PIXI from 'pixi.js';
import { Tween, TweenUtils } from './tween';
import { Reel } from './reel';

export class Slot extends PIXI.Container {
  private readonly REEL_WIDTH = 160;
  private readonly SYMBOL_SIZE = 150;

  private isSpinning = false;
  public reels: Reel[] = [];

  public constructor(symbolTextures: PIXI.Texture[]) {
    super();

    // Build the reels
    for (let i = 0; i < 5; i++) {
      const reelContainer = new PIXI.Container();
      reelContainer.x = i * this.REEL_WIDTH;
      this.addChild(reelContainer);

      const reel: Reel = {
        container: reelContainer,
        symbols: [],
        position: 0,
        previousPosition: 0,
        blur: new PIXI.filters.BlurFilter(),
      };

      reel.blur.blurX = 0;
      reel.blur.blurY = 0;
      reelContainer.filters = [reel.blur];

      // Build the symbols
      for (let j = 0; j < 4; j++) {
        const symbol = new PIXI.Sprite(symbolTextures[Math.floor(Math.random() * symbolTextures.length)]);
        // Scale the symbol to fit symbol area.
        symbol.y = j * this.SYMBOL_SIZE;
        const scale = Math.min(this.SYMBOL_SIZE / symbol.width, this.SYMBOL_SIZE / symbol.height);
        symbol.scale.x = scale;
        symbol.scale.y = scale;
        symbol.x = Math.round((this.SYMBOL_SIZE - symbol.width) / 2);
        reel.symbols.push(symbol);
        reelContainer.addChild(symbol);
      }
      this.reels.push(reel);
    }
  }

  public spin(): Tween[] {
    if (this.isSpinning) {
      return [];
    }
    this.isSpinning = true;

    const tweens: Tween[] = [];

    this.reels.forEach((reel, index) => {
      const extra = Math.floor(Math.random() * 3);
      const target = reel.position + 10 + index * 5 + extra;
      const time = 2500 + index * 600 + extra * 600;
      const tween = TweenUtils.tweenTo(
        reel,
        'position',
        target,
        time,
        TweenUtils.backout(0.5),
        null,
        index === this.reels.length - 1
          ? (): void => {
              this.isSpinning = false;
            }
          : null,
      );

      tweens.push(tween);
    });

    return tweens;
  }
}
