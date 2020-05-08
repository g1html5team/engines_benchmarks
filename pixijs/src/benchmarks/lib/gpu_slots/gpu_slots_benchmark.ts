import * as PIXI from 'pixi.js';
import { Benchmark } from '../benchmark';

export class GPUSlotsBenchmark extends Benchmark {
  private container: PIXI.Container = new PIXI.Container();
  private characters: PIXI.Sprite[] = [];

  public constructor(width: number, height: number, private numberOfObjects: number) {
    super(width, height);
    for (let i = 0; i < 8; i++) {
      for (let j = 0; j < 3; j++) {
        this.assetsToLoad.set(`character_${i + 1}_${j + 1}`, `../assets/characters/character_${i + 1}_${j + 1}.png`);
      }
    }
  }

  public async init(): Promise<void> {
    await super.init();

    Object.keys(this.app.loader.resources).forEach((resourceKey) => {
      const character = new PIXI.Sprite(this.app.loader.resources[resourceKey].texture);
      this.container.addChild(character);
      character.x = Math.random() * this.app.renderer.screen.width;
      character.y = Math.random() * this.app.renderer.screen.height;
      character.anchor = new PIXI.Point(0.5, 0.5);
      this.characters.push(character);
    });

    this.app.stage.addChild(this.container);
  }

  protected eachFrameCallback(): void {
    this.characters.forEach((character) => {
      character.x = Math.random() * this.app.renderer.screen.width;
      character.y = Math.random() * this.app.renderer.screen.height;
    });
  }
}
