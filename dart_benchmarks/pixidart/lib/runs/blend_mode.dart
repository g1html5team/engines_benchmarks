import 'dart:html';
import 'dart:math';

import 'package:pixi_dart_benchmark/benchmarks/common.dart';
import 'package:pixi_dart_benchmark/benchmarks/custom/blend_mode/interfaces/common.dart';

class BlendModeBenchmark implements BenchmarkBase {
  final int canvasWidth;
  final int canvasHeight;
  final BlendModeInterface interface;
  final layout;
  final int nbOfObjects;
  List _bunnies = [];
  Random rdm = new Random();

  var background1;
  var background2;
  var background3;

  /// if [BlendModeType] == null => random
  BlendModeBenchmark(this.interface, this.nbOfObjects, this.layout,
      this.canvasWidth, this.canvasHeight, BlendModeType blendModeType) {
    var container = interface.createContainer();

    var backgroundData1 = interface.createBitmapData(
        querySelector('#background_b'), '../assets/background_b.jpg');
    background1 = interface.createBitmap(backgroundData1);
    interface.setBlendMode(
        background1,
        blendModeType != null
            ? blendModeType
            : BlendModeType.all[rdm.nextInt(BlendModeType.all.length)]);
    interface.addChild(container, background1);

    var bunnyData =
    interface.createBitmapData(querySelector('#bunny'), '../assets/bunny.png');

    //Add another big blended images over
    var backgroundData2 = interface.createBitmapData(
        querySelector('#background_a'), '../assets/background_a.jpg');
    background2 = interface.createBitmap(backgroundData2);
    interface.setBlendMode(
        background2,
        blendModeType != null
            ? blendModeType
            : BlendModeType.all[rdm.nextInt(BlendModeType.all.length)]);
    interface.addChild(container, background2);

    for (int i = -1; ++i < nbOfObjects;) {
      var bunny = interface.createBitmap(bunnyData);
      interface.addChild(container, bunny);
      interface.setX(bunny, rdm.nextInt(canvasWidth));
      interface.setY(bunny, rdm.nextInt(canvasHeight));
      interface.setRotation(bunny, rdm.nextDouble() * pi);
      interface.centerPivot(bunny);

      interface.setBlendMode(
          bunny,
          blendModeType != null
              ? blendModeType
              : BlendModeType.all[rdm.nextInt(BlendModeType.all.length)]);

      _bunnies.add(bunny);
    }

    //Add another big blended images over all
    var backgroundData3 = interface.createBitmapData(
        querySelector('#background_b'), '../assets/background_b.jpg');
    background3 = interface.createBitmap(backgroundData3);
    interface.setBlendMode(
        background3,
        blendModeType != null
            ? blendModeType
            : BlendModeType.all[rdm.nextInt(BlendModeType.all.length)]);
    interface.addChild(container, background3);

    interface.addChild(layout, container);
  }

  eachFrameFunction([num v]) {
    for (var bunny in _bunnies) {
      interface.setX(bunny, rdm.nextInt(canvasWidth));
      interface.setY(bunny, rdm.nextInt(canvasHeight));
    }
  }
}
