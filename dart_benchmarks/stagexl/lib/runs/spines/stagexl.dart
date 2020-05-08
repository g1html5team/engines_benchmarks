import 'dart:math' as math;
import 'package:stagexl/stagexl.dart';
import 'package:stagexl_benchmark/benchmarks/common.dart';
import 'package:stagexl_benchmark/benchmarks/custom/spines/interfaces/common.dart';
import 'package:stagexl_benchmark/benchmarks/custom/spines/interfaces/stagexl.dart';
import 'package:stagexl_benchmark/helpers/stagexl_objects.dart';
import 'package:stagexl_spine/stagexl_spine.dart';

class SpinesStageXLAssets {
  var tortueSkeletonData;
  var waveSkeletonData;
  var tortueAnimationStateData;
  var waveAnimationStateData;

  load() async {
    var resourceManager = ResourceManager();

    resourceManager.addTextFile("turtle", "../assets/shop_tortue.json");
    resourceManager.addTextureAtlas(
        "turtleAtlas", "../assets/test0.json", TextureAtlasFormat.JSONARRAY);
  resourceManager.addTextFile("wave", "../assets/spine/shop_mer_top.json");
  resourceManager.addTextureAtlas("waveAtlas", "../assets/test1.json");
    await resourceManager.load();

    // load Spine skeleton
//
    var spineJson = resourceManager.getTextFile("turtle");
    var textureAtlas = resourceManager.getTextureAtlas("turtleAtlas");
    var attachmentLoader = TextureAtlasAttachmentLoader(textureAtlas);
    var skeletonLoader = SkeletonLoader(attachmentLoader);
    tortueSkeletonData = skeletonLoader.readSkeletonData(spineJson);
    tortueAnimationStateData = AnimationStateData(tortueSkeletonData);


    var spineJsonW = resourceManager.getTextFile("wave");
    var textureAtlasW = resourceManager.getTextureAtlas("waveAtlas");
    var attachmentLoaderW = TextureAtlasAttachmentLoader(textureAtlasW);
    var skeletonLoaderW = SkeletonLoader(attachmentLoaderW);
    waveSkeletonData = skeletonLoaderW.readSkeletonData(spineJsonW);
    waveAnimationStateData = AnimationStateData(waveSkeletonData);


    // create the display object showing the skeleton animation

//  skeletonAnimation.x = 300;
//  skeletonAnimation.y = 600;
//  skeletonAnimation.state.setAnimationByName(0, "rotate", true);
  }
}

class StagexlSpinesBenchmark implements BenchmarkBase {
  final int canvasWidth;
  final int canvasHeight;
  final StagexlSpinesInterface interface;
  final FixedContainer layout;
  final int nbOfObjects;
  final int nbOfDeformObjects;
  math.Random rdm = new math.Random();
  SpinesStageXLAssets assets;
  SpriteContainer container = new SpriteContainer();
  List<SkeletonAnimation> _turtles = [];

  Stage juggler;
  StagexlSpinesBenchmark(
      this.interface,
      this.nbOfObjects,
      this.nbOfDeformObjects,
      this.layout,
      this.canvasWidth,
      this.canvasHeight,
      this.juggler);

  init() async {
    RenderLoop renderLoop = new RenderLoop();
    renderLoop.addStage(juggler);

    assets = SpinesStageXLAssets();
    await assets.load();
//
    for (int i = 0; i < nbOfDeformObjects; i++) {

      SkeletonAnimation wave = new SkeletonAnimation(
          assets.waveSkeletonData, assets.waveAnimationStateData);
      container.addChild(wave);
      wave.state.setAnimationByName(0, waveAnimationName, true);
      wave.x = -640 + i * ((-640) / nbOfDeformObjects);

      wave.y = -360 + i * ((-360) / nbOfDeformObjects);

      container.addChild(wave);

      juggler.juggler.add(wave);

    }
//

    for (int i = -1; ++i < nbOfObjects;) {
      SkeletonAnimation turtle = new SkeletonAnimation(
          assets.tortueSkeletonData, assets.tortueAnimationStateData);
      container.addChild(turtle);
      turtle.state.setAnimationByName(0, turtleAnimationName, true);
      turtle.x = rdm.nextInt(canvasWidth ~/ 2);
      turtle.y = rdm.nextInt(canvasHeight ~/ 2);

      _turtles.add(turtle);
      container.addChild(turtle);

      juggler.juggler.add(turtle);
    }
    layout.addChild(container);
  }

  eachFrameFunction([num v]) {}
}
