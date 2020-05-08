import 'dart:math' as math;
import 'package:stagexl/stagexl.dart';
import 'package:stagexl_benchmark/benchmarks/common.dart';
import 'package:stagexl_benchmark/benchmarks/custom/atlasses/interfaces/stagexl.dart';
import 'package:stagexl_benchmark/helpers/stagexl_objects.dart';


class BenchmarkAtlassesAssets

{
  List<BitmapData> imgsNoAtlas = new List<BitmapData>(100);
  List<BitmapData> imgsAtlas100 = new List<BitmapData>(99);
  List<BitmapData> imgsAtlas50a = new List<BitmapData>(49);
  List<BitmapData> imgsAtlas50b = new List<BitmapData>(49);

  final String _rDir100 = '../assets/atlasses/data100.json';
  final String _rDir50a = '../assets/atlasses/data50a.json';
  final String _rDir50b = '../assets/atlasses/data50b.json';
  ResourceManager resourceManager = ResourceManager();

  Future loadAssets() async
  {


  for(int i = 0; i < imgsNoAtlas.length; i++) {
    String number = "$i";
    if (number.length < 2) {
      number = "0$i";
    }

    resourceManager.addBitmapData("bmp$i", "../assets/atlasses/img$number.png");
  }

  resourceManager.addTextureAtlas("atlas100", _rDir100);
  resourceManager.addTextureAtlas("atlas50a", _rDir50a);
  resourceManager.addTextureAtlas("atlas50b", _rDir50b);


   await resourceManager.load();

  for(int i = 0; i < imgsNoAtlas.length; i++) {
   imgsNoAtlas[i] = resourceManager.getBitmapData("bmp$i");
  }

  imgsAtlas100 = resourceManager.getTextureAtlas("atlas100").getBitmapDatas('');
  imgsAtlas50a = resourceManager.getTextureAtlas("atlas50a").getBitmapDatas('');
  imgsAtlas50b = resourceManager.getTextureAtlas("atlas50b").getBitmapDatas('');

  }




}

class StagexlAtlasImagesNoAtlasWithAddChildBenchmark implements BenchmarkBase {
  final int canvasWidth;
  final int canvasHeight;
  final StagexlAtlasInterface interface;
  final FixedContainer layout;
  final int nbOfObjects;
  math.Random rdm = new math.Random();
  BenchmarkAtlassesAssets assets;

  StagexlAtlasImagesNoAtlasWithAddChildBenchmark(this.interface,
      this.nbOfObjects, this.layout, this.canvasWidth, this.canvasHeight);

  init() async {

    assets = BenchmarkAtlassesAssets();
    await assets.loadAssets();
  }

  eachFrameFunction([num v]) {
    interface.removeChildren(layout);
    for (int i = 0; i < nbOfObjects; i++) {
      Bitmap bitmap = interface.createBitmap(
          assets.imgsNoAtlas[rdm.nextInt(assets.imgsNoAtlas.length)]);
      interface.addChild(layout, bitmap);
      interface.setX(bitmap, rdm.nextInt(canvasWidth));
      interface.setY(bitmap, rdm.nextInt(canvasHeight));
    }
  }
}

class StagexlAtlasImagesNoAtlasWithOneBitmapBenchmark implements BenchmarkBase {
  final int canvasWidth;
  final int canvasHeight;
  final StagexlAtlasInterface interface;
  final FixedContainer layout;
  final int nbOfObjects;
  math.Random rdm = new math.Random();
  BenchmarkAtlassesAssets assets;
  final Bitmap bitmap = new Bitmap(null);

  StagexlAtlasImagesNoAtlasWithOneBitmapBenchmark(this.interface,
      this.nbOfObjects, this.layout, this.canvasWidth, this.canvasHeight);

  init() async {

    assets = BenchmarkAtlassesAssets();
    await assets.loadAssets();
    interface.addChild(layout, bitmap);
  }

  eachFrameFunction([num v]) {
    for (int i = 0; i < nbOfObjects; i++) {
      interface.setBitmapData(
          bitmap, assets.imgsNoAtlas[rdm.nextInt(assets.imgsNoAtlas.length)]);
    }
  }
}

class StagexlAtlasImagesNoAtlasWith100BitmapBenchmark implements BenchmarkBase {
  final int canvasWidth;
  final int canvasHeight;
  final StagexlAtlasInterface interface;
  final FixedContainer layout;
  final int nbOfObjects;
  math.Random rdm = new math.Random();
  BenchmarkAtlassesAssets assets;
  final List<Bitmap> bitmaps = new List<Bitmap>(100);

  StagexlAtlasImagesNoAtlasWith100BitmapBenchmark(this.interface,
      this.nbOfObjects, this.layout, this.canvasWidth, this.canvasHeight);

  init() async {
    assets = BenchmarkAtlassesAssets();
    await assets.loadAssets();

    for (int i = 0; i < bitmaps.length; i++) {
      bitmaps[i] = interface.createBitmap(assets.imgsNoAtlas[0]);
      int row = i ~/ 10 * (canvasWidth ~/ 10);
      int column = i % 10 * (canvasWidth ~/ 10);
      interface.setX(bitmaps[i], column);
      interface.setY(bitmaps[i], row);
      interface.addChild(layout, bitmaps[i]);
    }
  }

  eachFrameFunction([num v]) {
    for (int i = 0; i < nbOfObjects; i++) {
      for (int j = 0; j < bitmaps.length; j++) {
        interface.setBitmapData(bitmaps[j],
            assets.imgsNoAtlas[rdm.nextInt(assets.imgsNoAtlas.length)]);
      }
    }
  }
}
//
class StagexlAtlasImagesInAtlasWithAddChildBenchmark implements BenchmarkBase {
  final int canvasWidth;
  final int canvasHeight;
  final StagexlAtlasInterface interface;
  final FixedContainer layout;
  final int nbOfObjects;
  math.Random rdm = new math.Random();
  BenchmarkAtlassesAssets assets;

  StagexlAtlasImagesInAtlasWithAddChildBenchmark(this.interface,
      this.nbOfObjects, this.layout, this.canvasWidth, this.canvasHeight);

  init() async {
    assets = BenchmarkAtlassesAssets();
    await assets.loadAssets();
  }

  eachFrameFunction([num v]) {
    interface.removeChildren(layout);
    for (int i = 0; i < nbOfObjects; i++) {
      Bitmap bitmap = interface.createBitmap(
          assets.imgsAtlas100[rdm.nextInt(assets.imgsAtlas100.length)]);
      interface.addChild(layout, bitmap);
      interface.setX(bitmap, rdm.nextInt(canvasWidth));
      interface.setY(bitmap, rdm.nextInt(canvasHeight));
    }
  }
}

class StagexlAtlasImagesInAtlasWithOneBitmapBenchmark implements BenchmarkBase {
  final int canvasWidth;
  final int canvasHeight;
  final StagexlAtlasInterface interface;
  final FixedContainer layout;
  final int nbOfObjects;
  math.Random rdm = new math.Random();
  BenchmarkAtlassesAssets assets;
  Bitmap bitmap;

  StagexlAtlasImagesInAtlasWithOneBitmapBenchmark(this.interface,
      this.nbOfObjects, this.layout, this.canvasWidth, this.canvasHeight);

  init() async {
    assets = BenchmarkAtlassesAssets();
    await assets.loadAssets();
    bitmap = interface.createBitmap(assets.imgsNoAtlas[0]);
    interface.addChild(layout, bitmap);
  }

  eachFrameFunction([num v]) {
    for (int i = 0; i < nbOfObjects; i++) {
      interface.setBitmapData(
          bitmap, assets.imgsAtlas100[rdm.nextInt(assets.imgsAtlas100.length)]);
    }
  }
}

class StagexlAtlasImagesInAtlasWith100BitmapBenchmark implements BenchmarkBase {
  final int canvasWidth;
  final int canvasHeight;
  final StagexlAtlasInterface interface;
  final FixedContainer layout;
  final int nbOfObjects;
  math.Random rdm = new math.Random();
  BenchmarkAtlassesAssets assets;
  final List<Bitmap> bitmaps = new List<Bitmap>(100);

  StagexlAtlasImagesInAtlasWith100BitmapBenchmark(this.interface,
      this.nbOfObjects, this.layout, this.canvasWidth, this.canvasHeight);

  init() async {
    assets = BenchmarkAtlassesAssets();
     await assets.loadAssets();
    for (int i = 0; i < bitmaps.length; i++) {
      bitmaps[i] = interface.createBitmap(assets.imgsAtlas100[0]);
      int row = i ~/ 10 * (canvasWidth ~/ 10);
      int column = i % 10 * (canvasWidth ~/ 10);
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

class StagexlAtlasImagesFrom2DifferentAtlasWithAddChildBenchmark
    implements BenchmarkBase {
  final int canvasWidth;
  final int canvasHeight;
  final StagexlAtlasInterface interface;
  final FixedContainer layout;
  final int nbOfObjects;
  math.Random rdm = new math.Random();
  BenchmarkAtlassesAssets assets;

  StagexlAtlasImagesFrom2DifferentAtlasWithAddChildBenchmark(this.interface,
      this.nbOfObjects, this.layout, this.canvasWidth, this.canvasHeight);

  init() async {
    assets = BenchmarkAtlassesAssets();
    await assets.loadAssets();
  }

  bool isFirst = true;
  eachFrameFunction([num v]) {
    interface.removeChildren(layout);
    for (int i = 0; i < nbOfObjects; i++) {
      Bitmap bitmap = interface.createBitmap(isFirst
          ? assets.imgsAtlas50a[rdm.nextInt(assets.imgsAtlas50a.length)]
          : assets.imgsAtlas50b[rdm.nextInt(assets.imgsAtlas50b.length)]);
      interface.addChild(layout, bitmap);
      interface.setX(bitmap, rdm.nextInt(canvasWidth));
      interface.setY(bitmap, rdm.nextInt(canvasHeight));
      isFirst = !isFirst;
    }
  }
}

class StagexlAtlasImagesFrom2DifferentAtlasWithOneBitmapBenchmark
    implements BenchmarkBase {
  final int canvasWidth;
  final int canvasHeight;
  final StagexlAtlasInterface interface;
  final FixedContainer layout;
  final int nbOfObjects;
  math.Random rdm = new math.Random();
  BenchmarkAtlassesAssets assets;
  Bitmap bitmap;

  StagexlAtlasImagesFrom2DifferentAtlasWithOneBitmapBenchmark(this.interface,
      this.nbOfObjects, this.layout, this.canvasWidth, this.canvasHeight);

  init() async {
    assets = BenchmarkAtlassesAssets();
    await assets.loadAssets();
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

class StagexlAtlasImagesFrom2DifferentAtlasWith100BitmapBenchmark
    implements BenchmarkBase {
  final int canvasWidth;
  final int canvasHeight;
  final StagexlAtlasInterface interface;
  final FixedContainer layout;
  final int nbOfObjects;
  math.Random rdm = new math.Random();
  BenchmarkAtlassesAssets assets;
  final List<Bitmap> bitmaps = new List<Bitmap>(100);

  StagexlAtlasImagesFrom2DifferentAtlasWith100BitmapBenchmark(this.interface,
      this.nbOfObjects, this.layout, this.canvasWidth, this.canvasHeight);

  init() async {
    assets = BenchmarkAtlassesAssets();
    await assets.loadAssets();
    for (int i = 0; i < bitmaps.length; i++) {
      bitmaps[i] = interface.createBitmap(assets.imgsAtlas50a[0]);
      int row = i ~/ 10 * (canvasWidth ~/ 10);
      int column = i % 10 * (canvasWidth ~/ 10);
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

class StagexlAtlasImagesFrom3DifferentAtlasWithAddChildBenchmark
    implements BenchmarkBase {
  final int canvasWidth;
  final int canvasHeight;
  final StagexlAtlasInterface interface;
  final FixedContainer layout;
  final int nbOfObjects;
  math.Random rdm = new math.Random();
  BenchmarkAtlassesAssets assets;

  StagexlAtlasImagesFrom3DifferentAtlasWithAddChildBenchmark(this.interface,
      this.nbOfObjects, this.layout, this.canvasWidth, this.canvasHeight);

  init() async {
    assets = BenchmarkAtlassesAssets();
    await assets.loadAssets();
  }

  int atlasToUse = 0;
  eachFrameFunction([num v]) {
    interface.removeChildren(layout);
    for (int i = 0; i < nbOfObjects; i++) {
      Bitmap bitmap = interface.createBitmap(atlasToUse == 0
          ? assets.imgsAtlas50a[rdm.nextInt(assets.imgsAtlas50a.length)]
          : (atlasToUse == 1
              ? assets.imgsAtlas50b[rdm.nextInt(assets.imgsAtlas50b.length)]
              : assets.imgsAtlas100[rdm.nextInt(assets.imgsAtlas100.length)]));
      interface.addChild(layout, bitmap);
      interface.setX(bitmap, rdm.nextInt(canvasWidth));
      interface.setY(bitmap, rdm.nextInt(canvasHeight));
      atlasToUse++;
      if (atlasToUse > 2) {
        atlasToUse = 0;
      }
    }
  }
}

class StagexlAtlasImagesFrom3DifferentAtlasWithOneBitmapBenchmark
    implements BenchmarkBase {
  final int canvasWidth;
  final int canvasHeight;
  final StagexlAtlasInterface interface;
  final FixedContainer layout;
  final int nbOfObjects;
  math.Random rdm = new math.Random();
  BenchmarkAtlassesAssets assets;
  Bitmap bitmap;

  StagexlAtlasImagesFrom3DifferentAtlasWithOneBitmapBenchmark(this.interface,
      this.nbOfObjects, this.layout, this.canvasWidth, this.canvasHeight);

  init() async {
    assets = BenchmarkAtlassesAssets();
    await assets.loadAssets();
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

class StagexlAtlasImagesFrom3DifferentAtlasWith100BitmapBenchmark
    implements BenchmarkBase {
  final int canvasWidth;
  final int canvasHeight;
  final StagexlAtlasInterface interface;
  final FixedContainer layout;
  final int nbOfObjects;
  math.Random rdm = new math.Random();
  BenchmarkAtlassesAssets assets;
  final List<Bitmap> bitmaps = new List<Bitmap>(100);

  StagexlAtlasImagesFrom3DifferentAtlasWith100BitmapBenchmark(this.interface,
      this.nbOfObjects, this.layout, this.canvasWidth, this.canvasHeight);

  init() async {
//    await assetLoader.load(BenchmarkAtlassesAssets.loader);
//    assets = BenchmarkAtlassesAssets.loader.instance;
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
