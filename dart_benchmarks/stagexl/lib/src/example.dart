import 'dart:async';
import 'dart:html' as html;
import 'package:stagexl/stagexl.dart';
import 'package:stagexl_spine/stagexl_spine.dart';

class Example {
  Future run() async {
    // configure StageXL default options

    StageXL.stageOptions.renderEngine = RenderEngine.WebGL;
    StageXL.stageOptions.backgroundColor = Color.DarkSlateGray;

    // init Stage and RenderLoop

    var canvas = html.querySelector('#stage');
    var stage = Stage(canvas, width: 600, height: 1000);
    var renderLoop = RenderLoop();
    renderLoop.addStage(stage);

    var resourceManager = ResourceManager();
    var format = TextureAtlasFormat.LIBGDX;
    resourceManager.addTextFile("coin", "images/coin.json");
    resourceManager.addTextureAtlas("coin", "images/coin.atlas", format);
    resourceManager.addBitmapData('logo', "images/logo.png");
    await resourceManager.load();

    // load image

    Bitmap logo = Bitmap(resourceManager.getBitmapData('logo'))..alignPivot(HorizontalAlign.Center, VerticalAlign.Center)..x = 300..y = 500;

    // load Spine skeleton

    var spineJson = resourceManager.getTextFile("coin");
    var textureAtlas = resourceManager.getTextureAtlas("coin");
    var attachmentLoader = TextureAtlasAttachmentLoader(textureAtlas);
    var skeletonLoader = SkeletonLoader(attachmentLoader);
    var skeletonData = skeletonLoader.readSkeletonData(spineJson);
    var animationStateData = AnimationStateData(skeletonData);

    // create the display object showing the skeleton animation

    var skeletonAnimation = SkeletonAnimation(skeletonData, animationStateData);
    skeletonAnimation.x = 300;
    skeletonAnimation.y = 600;
    skeletonAnimation.state.setAnimationByName(0, "rotate", true);

    stage.addChild(logo);
    stage.addChild(skeletonAnimation);
    stage.juggler.add(skeletonAnimation);
  }
}
