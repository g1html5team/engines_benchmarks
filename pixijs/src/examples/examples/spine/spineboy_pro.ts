import '../../../canvas.css';
import '../../../utils/global_pixi';
import 'pixi-spine';

const app = new PIXI.Application();
document.body.appendChild(app.view);

function onAssetsLoaded(loader: PIXI.Loader, res: Partial<Record<string, PIXI.LoaderResource>>): void {
  // create a spine boy
  const spineBoyPro = new PIXI.spine.Spine(res.spineboypro.spineData);

  // set the position
  spineBoyPro.x = app.screen.width / 2;
  spineBoyPro.y = app.screen.height;

  spineBoyPro.scale.set(0.5);

  app.stage.addChild(spineBoyPro);

  const singleAnimations = ['aim', 'death', 'jump', 'portal'];
  const loopAnimations = ['hoverboard', 'idle', 'run', 'shoot', 'walk'];
  const allAnimations = [].concat(singleAnimations, loopAnimations);

  let lastAnimation = '';

  // Press the screen to play a random animation
  app.stage.on('pointerdown', () => {
    let animation = '';
    do {
      animation = allAnimations[Math.floor(Math.random() * allAnimations.length)];
    } while (animation === lastAnimation);

    spineBoyPro.state.setAnimation(0, animation, loopAnimations.includes(animation));

    lastAnimation = animation;
  });
}

// load spine data
app.loader.add('spineboypro', 'examples/assets/spine/spineboy-pro.json').load(onAssetsLoaded);

app.stage.interactive = true;
