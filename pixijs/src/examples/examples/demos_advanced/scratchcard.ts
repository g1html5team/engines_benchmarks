import '../styles.css';
import * as PIXI from 'pixi.js';
import BgGrass from '../assets/bg_grass.jpg';
import BgRotate from '../assets/bg_rotate.jpg';

const app = new PIXI.Application();
document.body.appendChild(app.view);
const { stage } = app;

// Prepare circle texture, that will be our brush
const brush = new PIXI.Graphics();
brush.beginFill(0xffffff);
brush.drawCircle(0, 0, 50);
brush.endFill();

function onAssetsLoaded(loader: PIXI.Loader, resources: Partial<Record<string, PIXI.LoaderResource>>): void {
  const background = new PIXI.Sprite(resources.grassBackground.texture);
  stage.addChild(background);
  background.width = app.screen.width;
  background.height = app.screen.height;

  const imageToReveal = new PIXI.Sprite(resources.rotateBackground.texture);
  stage.addChild(imageToReveal);
  imageToReveal.width = app.screen.width;
  imageToReveal.height = app.screen.height;

  const renderTexture = PIXI.RenderTexture.create({ width: app.screen.width, height: app.screen.height });

  const renderTextureSprite = new PIXI.Sprite(renderTexture);
  stage.addChild(renderTextureSprite);
  imageToReveal.mask = renderTextureSprite;

  let dragging = false;

  function pointerMove(event: PIXI.interaction.InteractionEvent): void {
    if (dragging) {
      brush.position.copyFrom(event.data.global);
      app.renderer.render(brush, renderTexture, false, null, false);
    }
  }

  function pointerDown(event: PIXI.interaction.InteractionEvent): void {
    dragging = true;
    pointerMove(event);
  }

  function pointerUp(): void {
    dragging = false;
  }

  app.stage.interactive = true;
  app.stage.on('pointerdown', pointerDown);
  app.stage.on('pointerup', pointerUp);
  app.stage.on('pointermove', pointerMove);
}

app.loader.add('grassBackground', BgGrass);
app.loader.add('rotateBackground', BgRotate);
app.loader.load(onAssetsLoaded);
