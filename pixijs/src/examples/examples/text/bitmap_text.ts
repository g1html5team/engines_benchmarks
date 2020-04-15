import '../styles.css';
import * as PIXI from 'pixi.js';

const app = new PIXI.Application({ backgroundColor: 0x1099bb });
document.body.appendChild(app.view);

function onAssetsLoaded(): void {
  const bitmapFontText = new PIXI.BitmapText('bitmap fonts are supported!\nWoo yay!', {
    font: { name: 'Desyrel', size: 55 },
    align: 'left',
  });

  bitmapFontText.x = 50;
  bitmapFontText.y = 200;

  app.stage.addChild(bitmapFontText);
}

app.loader.add('desyrel', 'examples/examples/assets/bitmap_font/desyrel.xml').load(onAssetsLoaded);
