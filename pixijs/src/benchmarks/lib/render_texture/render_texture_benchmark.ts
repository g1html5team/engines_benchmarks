import * as PIXI from 'pixi.js';
import { Benchmark } from '../benchmark';

export class RenderTextureBenchmark extends Benchmark {
  private textures: PIXI.Texture[];
  private currentRenderTexture: PIXI.RenderTexture;

  public constructor(width: number, height: number) {
    super(width, height);
  }

  public async init(): Promise<void> {
    await super.init();

    const promises: Promise<PIXI.Texture>[] = [];
    for (let i = 0; i < 8; i++) {
      const imageName = `spin_obj_0${i + 1}.png`;
      promises.push(RenderTextureBenchmark.getTextureFromImage(`../assets/render_texture/${imageName}`));
    }

    this.textures = await Promise.all(promises);

    const renderTexture1 = PIXI.RenderTexture.create({
      width: this.app.renderer.screen.width,
      height: this.app.renderer.screen.height,
    });

    const renderTexture2 = PIXI.RenderTexture.create({
      width: this.app.renderer.screen.width,
      height: this.app.renderer.screen.height,
    });

    this.currentRenderTexture = renderTexture1;

    const outputBitmap = new PIXI.Sprite(renderTexture1);
    outputBitmap.anchor = new PIXI.Point(0.5, 0.5);
    outputBitmap.x = this.app.renderer.screen.width * 0.5;
    outputBitmap.y = this.app.renderer.screen.height * 0.5;
    this.app.stage.addChild(outputBitmap);

    // TODO (sch) what's the use of this container?
    const container = new PIXI.Container();
    this.app.stage.addChild(container);

    for (let i = 0; i < 20; i++) {
      const point = new PIXI.Point(
        Math.random() * this.app.renderer.screen.width,
        Math.random() * this.app.renderer.screen.height,
      );
      const imageTexture = this.textures[i % this.textures.length];
      this.drawPixels(this.currentRenderTexture, imageTexture, point);
    }
  }

  private static getTextureFromImage(imgSrc: string): Promise<PIXI.Texture> {
    const image = new Image();
    image.src = imgSrc;

    return new Promise((resolve) => {
      image.onload = (): void => {
        resolve(new PIXI.Texture(new PIXI.BaseTexture(image)));
      };
    });
  }

  private drawPixels(renderTexture: PIXI.RenderTexture, texture: PIXI.Texture, point: PIXI.Point): void {
    const sprite = new PIXI.Sprite(texture);
    sprite.x = point.x;
    sprite.y = point.y;

    this.app.renderer.render(sprite, renderTexture, false);
  }

  protected eachFrameCallback(): void {
    const point = new PIXI.Point(
      Math.random() * this.app.renderer.screen.width,
      Math.random() * this.app.renderer.screen.height,
    );

    // TODO (sch) in former benchmark --> loop of 1 iteration => why?
    // TODO (sch) why never change currentRenderTexture?
    const imageTexture = this.textures[Math.floor(Math.random() * this.textures.length)];
    this.drawPixels(this.currentRenderTexture, imageTexture, point);
  }
}
