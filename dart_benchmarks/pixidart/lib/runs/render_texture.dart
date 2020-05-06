import 'dart:async';
import 'dart:html';
import 'dart:math';

import 'package:pixi_dart_benchmark/benchmarks/common.dart';
import 'package:pixi_dart_benchmark/benchmarks/custom/render_texture/interfaces/common.dart';

class RenderTextureAsset {
  final String path;
  final RenderTextureInterface interface;
  var texture;

  RenderTextureAsset(this.path, this.interface);

  load() async {
    var image = new ImageElement(src: path);
    await image.onLoad.first;
    this.texture = interface.createBitmapDataFromImageElement(image);
  }
}

class RenderTextureBenchmark implements BenchmarkBase {
  final int canvasWidth;
  final int canvasHeight;
  final layout;
  final RenderTextureInterface interface;
  final Map<String, RenderTextureAsset> assets = {};

  var renderTexture;
  var renderTexture2;
  var currentRenderTexture;
  var outputBitmap;
  var container;
  bool isInitialize = false;

  Random random = new Random();

  num count;

  RenderTextureBenchmark(
      this.interface, this.layout, this.canvasWidth, this.canvasHeight) {
    assets["OBJ01"] = new RenderTextureAsset(
        "../assets/render_texture/spin_obj_01.png", interface);
    assets["OBJ02"] = new RenderTextureAsset(
        "../assets/render_texture/spin_obj_02.png", interface);
    assets["OBJ03"] = new RenderTextureAsset(
        "../assets/render_texture/spin_obj_03.png", interface);
    assets["OBJ04"] = new RenderTextureAsset(
        "../assets/render_texture/spin_obj_04.png", interface);
    assets["OBJ05"] = new RenderTextureAsset(
        "../assets/render_texture/spin_obj_05.png", interface);
    assets["OBJ06"] = new RenderTextureAsset(
        "../assets/render_texture/spin_obj_06.png", interface);
    assets["OBJ07"] = new RenderTextureAsset(
        "../assets/render_texture/spin_obj_07.png", interface);
    assets["OBJ08"] = new RenderTextureAsset(
        "../assets/render_texture/spin_obj_08.png", interface);
  }

  loadAssets() async {
    List<Future> futures = [];

    for (String key in assets.keys) {
      futures.add(assets[key].load());
    }

    await Future.wait(futures);
  }

  initialize() async {
    createRenderTexture();
    isInitialize = true;
  }

  createRenderTexture() {
    renderTexture = interface.create(canvasWidth, canvasHeight);
    renderTexture2 = interface.create(canvasWidth, canvasHeight);
    currentRenderTexture = renderTexture;

    outputBitmap = interface.createBitmap(renderTexture);
    interface.setX(outputBitmap, canvasWidth * 0.5);
    interface.setY(outputBitmap, canvasHeight * 0.5);
    interface.centerPivot(outputBitmap);
    interface.addChild(layout, outputBitmap);

    container = interface.createContainer();
    interface.setX(outputBitmap, canvasWidth * 0.5);
    interface.setY(outputBitmap, canvasHeight * 0.5);
    interface.addChild(layout, container);

    for (var i = 0; i < 20; i++) {
      Point point =
          new Point(random.nextInt(canvasWidth), random.nextInt(canvasHeight));
      String name = assets.keys.toList()[(i % assets.length - 1) + 1];
      interface.drawPixels(currentRenderTexture, assets[name].texture, point);
    }

    count = 0;
  }

  eachFrameFunction([num v]) {
    if (!isInitialize) return;

    for (var i = 0; i < 1; i++) {
      Point point =
          new Point(random.nextInt(canvasWidth), random.nextInt(canvasHeight));
      String name = assets.keys.toList()[(i % assets.length - 1) + 1];
      interface.drawPixels(currentRenderTexture, assets[name].texture, point);
    }
  }
}
