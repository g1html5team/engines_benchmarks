import 'dart:async';
import 'dart:html';
import 'dart:math' as math;
import 'package:js/js.dart';
import 'package:pixi/pixi.dart';
import 'package:pixi_dart_benchmark/benchmarks/common.dart';
import 'package:pixi_dart_benchmark/benchmarks/custom/atlasses/interfaces/pixi.dart';
import 'package:pixi_dart_benchmark/interfaces/common.dart';
import 'package:pixi_dart_benchmark/interfaces/pixi.dart';
import 'package:pixi_dart_benchmark/runs/atlasses/atlas_facade.dart';

class RenderTextureAsset {
  final String path;
  final Interface interface;
  Texture texture;

  RenderTextureAsset(this.path, this.interface);

  load() async {
    var image = new ImageElement(src: path);
    await image.onLoad.first;
    this.texture = interface.createBitmapDataFromImageElement(image);
  }
}

class BenchmarkAtlassesAssets {
  final PixiInterface interface;
  final List<RenderTextureAsset> imgsNoAtlas =
      new List<RenderTextureAsset>(100);

  final List<Texture> imgsAtlas100 = new List<Texture>(99);
  final List<Texture> imgsAtlas50a = new List<Texture>(50);
  final List<Texture> imgsAtlas50b = new List<Texture>(50);

  final String _rDir100 = '../assets/atlasses/data100.json';
  final String _rDir50a = '../assets/atlasses/data50a.json';
  final String _rDir50b = '../assets/atlasses/data50b.json';

  BenchmarkAtlassesAssets(this.interface) {
    for (int i = 0; i < imgsNoAtlas.length; i++) {
      String number = '$i';
      if (number.length < 2) {
        number = '0$number';
      }
      imgsNoAtlas[i] = new RenderTextureAsset(
          '../assets/atlasses/img$number.png', interface);
    }
  }

  loadAssets() async {
    final List<Future> futures = [];
    for (int i = 0; i < imgsNoAtlas.length; i++) {
      futures.add(imgsNoAtlas[i].load());
    }
    await Future.wait(futures);
  }

  loadAtlas100() async {
    Completer completer = new Completer();
    completing(b, a) {
      completer.complete();
    }

    loadSprite(_rDir100, allowInterop(completing));
    await completer.future;

    for (int i = 0; i < imgsAtlas100.length; i++) {
      String strNumber = '$i';
      if (strNumber.length < 2) {
        strNumber = '0$strNumber';
      }
      Sprite sprite = getSprite(_rDir100, 'atlas100.img$strNumber');
      imgsAtlas100[i] = sprite.texture;
      // TODO: il y a surement une façon de faire sans instancier un sprite
    }
  }

  loadAtlas50a() async {
    Completer completer = new Completer();
    completing(b, a) {
      completer.complete();
    }

    loadSprite(_rDir50a, allowInterop(completing));
    await completer.future;

    for (int i = 0; i < imgsAtlas50a.length; i++) {
      String strNumber = '$i';
      if (strNumber.length < 2) {
        strNumber = '0$strNumber';
      }
      Sprite sprite = getSprite(_rDir50a, 'atlas50a.img${strNumber}a');
      imgsAtlas50a[i] = sprite.texture;
      // TODO: il y a surement une façon de faire sans instancier un sprite
    }
  }

  loadAtlas50b() async {
    Completer completer = new Completer();
    completing(b, a) {
      completer.complete();
    }

    loadSprite(_rDir50b, allowInterop(completing));
    await completer.future;

    for (int i = 0; i < imgsAtlas50a.length; i++) {
      String strNumber = '${50 + i}';
      Sprite sprite = getSprite(_rDir50b, 'atlas50b.img${strNumber}b');
      imgsAtlas50b[i] = sprite.texture;
      // TODO: il y a surement une façon de faire sans instancier un sprite
    }
  }
}

class PixiAtlasImagesNoAtlasWithAddChildBenchmark implements BenchmarkBase {
  final int canvasWidth;
  final int canvasHeight;
  final PixiAtlasInterface interface;
  final Container layout;
  final int nbOfObjects;
  math.Random rdm = new math.Random();
  BenchmarkAtlassesAssets assets;

  PixiAtlasImagesNoAtlasWithAddChildBenchmark(this.interface, this.nbOfObjects,
      this.layout, this.canvasWidth, this.canvasHeight);

  init() async {
    assets = new BenchmarkAtlassesAssets(interface);
    await assets.loadAssets();
  }

  eachFrameFunction([num v]) {
    interface.removeChildren(layout);
    for (int i = 0; i < nbOfObjects; i++) {
      Sprite sprite = interface.createBitmap(
          assets.imgsNoAtlas[rdm.nextInt(assets.imgsNoAtlas.length)].texture);
      interface.addChild(layout, sprite);
      interface.setX(sprite, rdm.nextInt(canvasWidth));
      interface.setY(sprite, rdm.nextInt(canvasHeight));
    }
  }
}

class PixiAtlasImagesNoAtlasWithOneBitmapBenchmark implements BenchmarkBase {
  final int canvasWidth;
  final int canvasHeight;
  final PixiAtlasInterface interface;
  final Container layout;
  final int nbOfObjects;
  math.Random rdm = new math.Random();
  BenchmarkAtlassesAssets assets;
  Sprite bitmap;

  PixiAtlasImagesNoAtlasWithOneBitmapBenchmark(this.interface, this.nbOfObjects,
      this.layout, this.canvasWidth, this.canvasHeight);

  init() async {
    assets = new BenchmarkAtlassesAssets(interface);
    await assets.loadAssets();
    bitmap = interface.createBitmap(assets.imgsNoAtlas[0].texture);
    interface.addChild(layout, bitmap);
  }

  eachFrameFunction([num v]) {
    for (int i = 0; i < nbOfObjects; i++) {
      interface.setBitmapData(bitmap,
          assets.imgsNoAtlas[rdm.nextInt(assets.imgsNoAtlas.length)].texture);
    }
  }
}

class PixiAtlasImagesNoAtlasWith100BitmapBenchmark implements BenchmarkBase {
  final int canvasWidth;
  final int canvasHeight;
  final PixiAtlasInterface interface;
  final Container layout;
  final int nbOfObjects;
  math.Random rdm = new math.Random();
  BenchmarkAtlassesAssets assets;
  final List<Sprite> bitmaps = new List<Sprite>(100);

  PixiAtlasImagesNoAtlasWith100BitmapBenchmark(this.interface, this.nbOfObjects,
      this.layout, this.canvasWidth, this.canvasHeight);

  init() async {
    assets = new BenchmarkAtlassesAssets(interface);
    await assets.loadAssets();
    for (int i = 0; i < bitmaps.length; i++) {
      bitmaps[i] = interface.createBitmap(assets.imgsNoAtlas[0].texture);
      int row = i ~/ 10 * (canvasWidth ~/ 10);
      int column = (i % 10) * (canvasWidth ~/ 10);
      interface.setX(bitmaps[i], column);
      interface.setY(bitmaps[i], row);
      interface.addChild(layout, bitmaps[i]);
    }
  }

  eachFrameFunction([num v]) {
    for (int i = 0; i < nbOfObjects; i++) {
      for (int j = 0; j < bitmaps.length; j++) {
        interface.setBitmapData(bitmaps[j],
            assets.imgsNoAtlas[rdm.nextInt(assets.imgsNoAtlas.length)].texture);
      }
    }
  }
}

class PixiAtlasImagesInAtlasWithAddChildBenchmark implements BenchmarkBase {
  final int canvasWidth;
  final int canvasHeight;
  final PixiAtlasInterface interface;
  final Container layout;
  final int nbOfObjects;
  math.Random rdm = new math.Random();
  BenchmarkAtlassesAssets assets;

  PixiAtlasImagesInAtlasWithAddChildBenchmark(this.interface, this.nbOfObjects,
      this.layout, this.canvasWidth, this.canvasHeight);

  init() async {
    assets = new BenchmarkAtlassesAssets(interface);
    await assets.loadAtlas100();
  }

  eachFrameFunction([num v]) {
    interface.removeChildren(layout);
    for (int i = 0; i < nbOfObjects; i++) {
      Sprite sprite = interface.createBitmap(
          assets.imgsAtlas100[rdm.nextInt(assets.imgsAtlas100.length)]);
      interface.addChild(layout, sprite);
      interface.setX(sprite, rdm.nextInt(canvasWidth));
      interface.setY(sprite, rdm.nextInt(canvasHeight));
    }
  }
}

class PixiAtlasImagesInAtlasWithOneBitmapBenchmark implements BenchmarkBase {
  final int canvasWidth;
  final int canvasHeight;
  final PixiAtlasInterface interface;
  final Container layout;
  final int nbOfObjects;
  math.Random rdm = new math.Random();
  BenchmarkAtlassesAssets assets;
  Sprite bitmap;

  PixiAtlasImagesInAtlasWithOneBitmapBenchmark(this.interface, this.nbOfObjects,
      this.layout, this.canvasWidth, this.canvasHeight);

  init() async {
    assets = new BenchmarkAtlassesAssets(interface);
    await assets.loadAtlas100();
    bitmap = interface.createBitmap(assets.imgsAtlas100[0]);
    interface.addChild(layout, bitmap);
  }

  eachFrameFunction([num v]) {
    for (int i = 0; i < nbOfObjects; i++) {
      interface.setBitmapData(
          bitmap, assets.imgsAtlas100[rdm.nextInt(assets.imgsAtlas100.length)]);
    }
  }
}

class PixiAtlasImagesInAtlasWith100BitmapBenchmark implements BenchmarkBase {
  final int canvasWidth;
  final int canvasHeight;
  final PixiAtlasInterface interface;
  final Container layout;
  final int nbOfObjects;
  math.Random rdm = new math.Random();
  BenchmarkAtlassesAssets assets;
  final List<Sprite> bitmaps = new List<Sprite>(100);

  PixiAtlasImagesInAtlasWith100BitmapBenchmark(this.interface, this.nbOfObjects,
      this.layout, this.canvasWidth, this.canvasHeight);

  init() async {
    assets = new BenchmarkAtlassesAssets(interface);
    await assets.loadAtlas100();
    for (int i = 0; i < bitmaps.length; i++) {
      bitmaps[i] = interface.createBitmap(assets.imgsAtlas100[0]);
      int row = i ~/ 10 * (canvasWidth ~/ 10);
      int column = (i % 10) * (canvasWidth ~/ 10);
      interface.setX(bitmaps[i], column);
      interface.setY(bitmaps[i], row);
      interface.addChild(layout, bitmaps[i]);
    }
  }

  eachFrameFunction([num v]) {
    for (int i = 0; i < nbOfObjects; i++) {
      for (int j = 0; j < bitmaps.length; j++) {
        interface.setBitmapData(bitmaps[j],
            assets.imgsAtlas100[rdm.nextInt(assets.imgsAtlas100.length)]);
      }
    }
  }
}

class PixiAtlasImagesFrom2DifferentAtlasWithAddChildBenchmark
    implements BenchmarkBase {
  final int canvasWidth;
  final int canvasHeight;
  final PixiAtlasInterface interface;
  final Container layout;
  final int nbOfObjects;
  math.Random rdm = new math.Random();
  BenchmarkAtlassesAssets assets;

  PixiAtlasImagesFrom2DifferentAtlasWithAddChildBenchmark(this.interface,
      this.nbOfObjects, this.layout, this.canvasWidth, this.canvasHeight);

  init() async {
    assets = new BenchmarkAtlassesAssets(interface);
    await assets.loadAtlas50a();
    await assets.loadAtlas50b();
  }

  bool isFirst = true;
  eachFrameFunction([num v]) {
    interface.removeChildren(layout);
    for (int i = 0; i < nbOfObjects; i++) {
      Sprite sprite = interface.createBitmap(isFirst
          ? assets.imgsAtlas50a[rdm.nextInt(assets.imgsAtlas50a.length)]
          : assets.imgsAtlas50b[rdm.nextInt(assets.imgsAtlas50b.length)]);
      interface.addChild(layout, sprite);
      interface.setX(sprite, rdm.nextInt(canvasWidth));
      interface.setY(sprite, rdm.nextInt(canvasHeight));
      isFirst = !isFirst;
    }
  }
}

class PixiAtlasImagesFrom2DifferentAtlasWithOneBitmapBenchmark
    implements BenchmarkBase {
  final int canvasWidth;
  final int canvasHeight;
  final PixiAtlasInterface interface;
  final Container layout;
  final int nbOfObjects;
  math.Random rdm = new math.Random();
  BenchmarkAtlassesAssets assets;
  Sprite bitmap;

  PixiAtlasImagesFrom2DifferentAtlasWithOneBitmapBenchmark(this.interface,
      this.nbOfObjects, this.layout, this.canvasWidth, this.canvasHeight);

  init() async {
    assets = new BenchmarkAtlassesAssets(interface);
    await assets.loadAtlas50a();
    await assets.loadAtlas50b();
    bitmap = interface.createBitmap(assets.imgsAtlas50a[0]);
    interface.addChild(layout, bitmap);
  }

  bool isFirst = true;
  eachFrameFunction([num v]) {
    for (int i = 0; i < nbOfObjects; i++) {
      interface.setBitmapData(
          bitmap,
          isFirst
              ? assets.imgsAtlas50a[rdm.nextInt(assets.imgsAtlas50a.length)]
              : assets.imgsAtlas50b[rdm.nextInt(assets.imgsAtlas50b.length)]);
      isFirst = !isFirst;
    }
  }
}

class PixiAtlasImagesFrom2DifferentAtlasWith100BitmapBenchmark
    implements BenchmarkBase {
  final int canvasWidth;
  final int canvasHeight;
  final PixiAtlasInterface interface;
  final Container layout;
  final int nbOfObjects;
  math.Random rdm = new math.Random();
  BenchmarkAtlassesAssets assets;
  final List<Sprite> bitmaps = new List<Sprite>(100);

  PixiAtlasImagesFrom2DifferentAtlasWith100BitmapBenchmark(this.interface,
      this.nbOfObjects, this.layout, this.canvasWidth, this.canvasHeight);

  init() async {
    assets = new BenchmarkAtlassesAssets(interface);
    await assets.loadAtlas50a();
    await assets.loadAtlas50b();
    for (int i = 0; i < bitmaps.length; i++) {
      bitmaps[i] = interface.createBitmap(assets.imgsAtlas50a[0]);
      int row = i ~/ 10 * (canvasWidth ~/ 10);
      int column = (i % 10) * (canvasWidth ~/ 10);
      interface.setX(bitmaps[i], column);
      interface.setY(bitmaps[i], row);
      interface.addChild(layout, bitmaps[i]);
    }
  }

  bool isFirst = true;
  eachFrameFunction([num v]) {
    for (int i = 0; i < nbOfObjects; i++) {
      for (int j = 0; j < bitmaps.length; j++) {
        interface.setBitmapData(
            bitmaps[j],
            isFirst
                ? assets.imgsAtlas50a[rdm.nextInt(assets.imgsAtlas50a.length)]
                : assets.imgsAtlas50b[rdm.nextInt(assets.imgsAtlas50b.length)]);
        isFirst = !isFirst;
      }
    }
  }
}

class PixiAtlasImagesFrom3DifferentAtlasWithAddChildBenchmark
    implements BenchmarkBase {
  final int canvasWidth;
  final int canvasHeight;
  final PixiAtlasInterface interface;
  final Container layout;
  final int nbOfObjects;
  math.Random rdm = new math.Random();
  BenchmarkAtlassesAssets assets;

  PixiAtlasImagesFrom3DifferentAtlasWithAddChildBenchmark(this.interface,
      this.nbOfObjects, this.layout, this.canvasWidth, this.canvasHeight);

  init() async {
    assets = new BenchmarkAtlassesAssets(interface);
    await assets.loadAtlas50a();
    await assets.loadAtlas50b();
    await assets.loadAtlas100();
  }

  int atlasToUse = 0;
  eachFrameFunction([num v]) {
    interface.removeChildren(layout);
    for (int i = 0; i < nbOfObjects; i++) {
      Sprite sprite = interface.createBitmap(atlasToUse == 0
          ? assets.imgsAtlas50a[rdm.nextInt(assets.imgsAtlas50a.length)]
          : (atlasToUse == 1
              ? assets.imgsAtlas50b[rdm.nextInt(assets.imgsAtlas50b.length)]
              : assets.imgsAtlas100[rdm.nextInt(assets.imgsAtlas100.length)]));
      interface.addChild(layout, sprite);
      interface.setX(sprite, rdm.nextInt(canvasWidth));
      interface.setY(sprite, rdm.nextInt(canvasHeight));
      atlasToUse++;
      if (atlasToUse > 2) {
        atlasToUse = 0;
      }
    }
  }
}

class PixiAtlasImagesFrom3DifferentAtlasWithOneBitmapBenchmark
    implements BenchmarkBase {
  final int canvasWidth;
  final int canvasHeight;
  final PixiAtlasInterface interface;
  final Container layout;
  final int nbOfObjects;
  math.Random rdm = new math.Random();
  BenchmarkAtlassesAssets assets;
  Sprite bitmap;

  PixiAtlasImagesFrom3DifferentAtlasWithOneBitmapBenchmark(this.interface,
      this.nbOfObjects, this.layout, this.canvasWidth, this.canvasHeight);

  init() async {
    assets = new BenchmarkAtlassesAssets(interface);
    await assets.loadAtlas50a();
    await assets.loadAtlas50b();
    await assets.loadAtlas100();
    bitmap = interface.createBitmap(assets.imgsAtlas50a[0]);
    interface.addChild(layout, bitmap);
  }

  int atlasToUse = 0;
  eachFrameFunction([num v]) {
    for (int i = 0; i < nbOfObjects; i++) {
      interface.setBitmapData(
          bitmap,
          atlasToUse == 0
              ? assets.imgsAtlas50a[rdm.nextInt(assets.imgsAtlas50a.length)]
              : (atlasToUse == 1
                  ? assets.imgsAtlas50b[rdm.nextInt(assets.imgsAtlas50b.length)]
                  : assets
                      .imgsAtlas100[rdm.nextInt(assets.imgsAtlas100.length)]));
      atlasToUse++;
      if (atlasToUse > 2) {
        atlasToUse = 0;
      }
    }
  }
}

class PixiAtlasImagesFrom3DifferentAtlasWith100BitmapBenchmark
    implements BenchmarkBase {
  final int canvasWidth;
  final int canvasHeight;
  final PixiAtlasInterface interface;
  final Container layout;
  final int nbOfObjects;
  math.Random rdm = new math.Random();
  BenchmarkAtlassesAssets assets;
  final List<Sprite> bitmaps = new List<Sprite>(100);

  PixiAtlasImagesFrom3DifferentAtlasWith100BitmapBenchmark(this.interface,
      this.nbOfObjects, this.layout, this.canvasWidth, this.canvasHeight);

  init() async {
    assets = new BenchmarkAtlassesAssets(interface);
    await assets.loadAtlas100();
    await assets.loadAtlas50a();
    await assets.loadAtlas50b();
    for (int i = 0; i < bitmaps.length; i++) {
      bitmaps[i] = interface.createBitmap(assets.imgsAtlas50a[0]);
      int row = i ~/ 10 * (canvasWidth ~/ 10);
      int column = (i % 10) * (canvasWidth ~/ 10);
      interface.setX(bitmaps[i], column);
      interface.setY(bitmaps[i], row);
      interface.addChild(layout, bitmaps[i]);
    }
  }

  int atlasToUse = 0;
  eachFrameFunction([num v]) {
    for (int i = 0; i < nbOfObjects; i++) {
      for (int j = 0; j < bitmaps.length; j++) {
        interface.setBitmapData(
            bitmaps[j],
            atlasToUse == 0
                ? assets.imgsAtlas50a[rdm.nextInt(assets.imgsAtlas50a.length)]
                : (atlasToUse == 1
                    ? assets
                        .imgsAtlas50b[rdm.nextInt(assets.imgsAtlas50b.length)]
                    : assets.imgsAtlas100[
                        rdm.nextInt(assets.imgsAtlas100.length)]));
        atlasToUse++;
        if (atlasToUse > 2) {
          atlasToUse = 0;
        }
      }
    }
  }
}
