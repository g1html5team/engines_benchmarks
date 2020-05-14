import { Benchmark } from '../benchmark';
import '../../../utils/global_pixi';
import 'pixi-spine';

export class SpineBenchmark extends Benchmark {
  public constructor(
    width: number,
    height: number,
    private numberOfObjects: number,
    private numberOfDeformObjects: number,
  ) {
    super(width, height);
    this.assetsToLoad.set('carapace', '../assets/spine/carapace.png');
    this.assetsToLoad.set('carapaceBack', '../assets/spine/carapace_back.png');
    this.assetsToLoad.set('head', '../assets/spine/head.png');
    this.assetsToLoad.set('mer', '../assets/spine/mer.png');
    this.assetsToLoad.set('merTop', '../assets/spine/mer_top.png');
    this.assetsToLoad.set('neck', '../assets/spine/neck.png');
    this.assetsToLoad.set('patteFull', '../assets/spine/patte_full.png');
    this.assetsToLoad.set('phylaTortue', '../assets/spine/phyla_tortue.png');
    this.assetsToLoad.set('sable', '../assets/spine/sable.jpg');
    this.assetsToLoad.set('sand', '../assets/spine/sand.png');
    this.assetsToLoad.set('shadow', '../assets/spine/shadow.png');
    this.assetsToLoad.set('shadow2', '../assets/spine/shadow2.png');
    this.assetsToLoad.set('tracesEau', '../assets/spine/traces_eau.png');
  }

  public async init(): Promise<void> {
    await super.init();

    const seaAtlas = new PIXI.spine.core.TextureAtlas();
    seaAtlas.addTexture('game5/game5/mer_top', this.app.loader.resources.merTop.texture);

    const turtleAtlas = new PIXI.spine.core.TextureAtlas();
    turtleAtlas.addTexture('images/game5/game5/carapace', this.app.loader.resources.carapace.texture);
    turtleAtlas.addTexture('images/game5/game5/carapace_back', this.app.loader.resources.carapaceBack.texture);
    turtleAtlas.addTexture('images/game5/game5/head', this.app.loader.resources.head.texture);
    turtleAtlas.addTexture('images/game5/game5/neck', this.app.loader.resources.neck.texture);
    turtleAtlas.addTexture('images/game5/game5/patte_full', this.app.loader.resources.patteFull.texture);
    turtleAtlas.addTexture('images/game5/game5/phyla_tortue', this.app.loader.resources.phylaTortue.texture);
    turtleAtlas.addTexture('images/game5/game5/sand', this.app.loader.resources.sand.texture);
    turtleAtlas.addTexture('images/game5/game5/shadow', this.app.loader.resources.shadow.texture);
    turtleAtlas.addTexture('images/game5/game5/shadow2', this.app.loader.resources.shadow2.texture);

    const loader = new PIXI.Loader();
    loader.add('turtle', '../assets/spine/shop_tortue.json', { metadata: { spineAtlas: turtleAtlas } });
    loader.add('sea', '../assets/spine/shop_mer_top.json', { metadata: { spineAtlas: seaAtlas } });

    await new Promise((resolve) => {
      loader.load(() => resolve());
    });

    const container = new PIXI.Container();
    for (let i = 0; i < this.numberOfDeformObjects; i++) {
      const wave = new PIXI.spine.Spine(loader.resources.sea.spineData);
      container.addChild(wave);
      wave.x = -640 + i * (-640 / this.numberOfDeformObjects);
      wave.y = -360 + i * (-360 / this.numberOfDeformObjects);
      wave.state.setAnimation(0, 'animationWaterLoop', true);
    }

    for (let i = 0; i < this.numberOfObjects; i++) {
      const turtle = new PIXI.spine.Spine(loader.resources.turtle.spineData);
      container.addChild(turtle);
      turtle.x = Math.random() * (this.app.renderer.screen.width / 2);
      turtle.y = Math.random() * (this.app.renderer.screen.height / 2);
      turtle.state.setAnimation(0, 'animationTortueLoop', true);
    }

    this.app.stage.addChild(container);
  }

  // eslint-disable-next-line class-methods-use-this
  protected eachFrameCallback(): void {}
}
