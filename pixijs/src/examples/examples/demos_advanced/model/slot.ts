import * as PIXI from 'pixi.js';
import { Tween, TweenUtils } from './tween';
import { Reel } from './reel';

export class Slot extends PIXI.Container {
  private isSpinning = false;
  private tweens: Tween<Reel>[] = [];

  public reels: Reel[] = [];

  public constructor(symbolsTextures: PIXI.Texture[], reelWidth: number, symbolSize: number, ticker: PIXI.Ticker) {
    super();

    // Build the reels
    for (let i = 0; i < 5; i++) {
      const reelContainer = new PIXI.Container();
      reelContainer.x = i * reelWidth;
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
        const symbol = new PIXI.Sprite(symbolsTextures[Math.floor(Math.random() * symbolsTextures.length)]);
        // Scale the symbol to fit symbol area.
        symbol.y = j * symbolSize;
        const scale = Math.min(symbolSize / symbol.width, symbolSize / symbol.height);
        symbol.scale.x = scale;
        symbol.scale.y = scale;
        symbol.x = Math.round((symbolSize - symbol.width) / 2);
        reel.symbols.push(symbol);
        reelContainer.addChild(symbol);
      }
      this.reels.push(reel);
    }

    // Execute the tweens within the ticker
    ticker.add(() => {
      const now = Date.now();
      const toRemove: Tween<Reel>[] = [];

      for (let i = 0; i < this.tweens.length; i++) {
        const tween = this.tweens[i];
        const progression = Math.min(1, (now - tween.start) / tween.time);

        if (typeof tween.object[tween.property] === 'number') {
          (tween.object[tween.property] as number) = TweenUtils.lerp(
            tween.propertyBeginValue,
            tween.target,
            tween.easing(progression),
          );
        }

        if (tween.onchange) {
          tween.onchange(tween);
        }

        if (progression === 1) {
          if (typeof tween.object[tween.property] === 'number') {
            (tween.object[tween.property] as number) = tween.target;
          }

          if (tween.oncomplete) {
            tween.oncomplete(tween);
          }

          toRemove.push(tween);
        }
      }

      for (let i = 0; i < toRemove.length; i++) {
        this.tweens.splice(this.tweens.indexOf(toRemove[i]), 1);
      }
    });

    // Update the slot reels within the ticker
    ticker.add(() => {
      for (let i = 0; i < this.reels.length; i++) {
        const reel = this.reels[i];
        // Update blur filter y amount based on speed.
        // This would be better if calculated with time in mind also. Now blur depends on frame rate.
        reel.blur.blurY = (reel.position - reel.previousPosition) * 8;
        reel.previousPosition = reel.position;

        // Update symbol positions on reel.
        for (let j = 0; j < reel.symbols.length; j++) {
          const symbol = reel.symbols[j];

          const previousY = symbol.y;
          symbol.y = ((reel.position + j) % reel.symbols.length) * symbolSize - symbolSize;

          if (symbol.y < 0 && previousY > symbolSize) {
            // Detect going over and swap a texture.
            // This should in proper product be determined from some logical reel.
            symbol.texture = symbolsTextures[Math.floor(Math.random() * symbolsTextures.length)];
            const scale = Math.min(symbolSize / symbol.texture.width, symbolSize / symbol.texture.height);
            symbol.scale.x = scale;
            symbol.scale.y = scale;
            symbol.x = Math.round((symbolSize - symbol.width) / 2);
          }
        }
      }
    });
  }

  public spin(): void {
    if (this.isSpinning) {
      return;
    }

    this.isSpinning = true;

    this.reels.forEach((reel, index) => {
      const extra = Math.floor(Math.random() * 3);

      const tween: Tween<Reel> = {
        object: reel,
        property: 'position',
        propertyBeginValue: reel.position,
        target: reel.position + 10 + index * 5 + extra,
        time: 2500 + index * 600 + extra * 600,
        easing: TweenUtils.backout(0.5),
        onchange: null,
        oncomplete:
          index === this.reels.length - 1
            ? (): void => {
                this.isSpinning = false;
              }
            : null,
        start: Date.now(),
      };

      this.tweens.push(tween);
    });
  }
}
