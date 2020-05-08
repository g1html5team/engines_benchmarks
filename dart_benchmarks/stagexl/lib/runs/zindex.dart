import 'dart:html';
import 'dart:math';

import 'package:stagexl_benchmark/benchmarks/common.dart';
import 'package:stagexl_benchmark/interfaces/common.dart';

class ZIndexBenchmark implements BenchmarkBase {
  final int canvasWidth;
  final int canvasHeight;
  final Interface interface;
  final layout;
  final int nbOfObjects;
  Random rdm = new Random();

  ZIndexBenchmark(this.interface, this.nbOfObjects, this.layout,
      this.canvasWidth, this.canvasHeight);

  createBunnies(data, nbOfObjects, container, list, Interface interface, layout,
      canvasWidth, canvasHeight) {
    Random rdm = new Random();

    for (int i = -1; ++i < nbOfObjects;) {
      var bunny = interface.createBitmap(data);
      interface.addChild(container, bunny);
      interface.setX(bunny, (canvasWidth / 2) + rdm.nextInt(300) - 150);
      interface.setY(bunny, (canvasHeight / 2) + rdm.nextInt(300) - 150);
      interface.setRotation(bunny, rdm.nextDouble() * pi);
      //interface.setAlpha(bunny, 1);
      interface.centerPivot(bunny);
      list.add(bunny);
    }
  }

  eachFrameFunction([num v]) {}
}

class ZIndexOneChildBenchmark extends ZIndexBenchmark implements BenchmarkBase {
  List _bunnies = [];
  dynamic bigBunnies;
  dynamic container;
  int index = 1;

  ZIndexOneChildBenchmark(
      Interface interface, nbOfObjects, layout, canvasWidth, canvasHeight)
      : super(interface, nbOfObjects, layout, canvasWidth, canvasHeight) {
    container = interface.createContainer();
    var dataBunnies =
        interface.createBitmapData(querySelector('#bunny'), 'bunny.png');
    createBunnies(dataBunnies, nbOfObjects, container, _bunnies, interface,
        layout, canvasWidth, canvasHeight);

    var data =
        interface.createBitmapData(querySelector('#bunnyRed'), 'bunny_red.png');
    bigBunnies = interface.createBitmap(data);
    interface.setScale(bigBunnies, 3);
    interface.setX(bigBunnies, (canvasWidth / 2));
    interface.setY(bigBunnies, (canvasHeight / 2));
    interface.setRotation(bigBunnies, 90 * pi);
    interface.centerPivot(bigBunnies);
    //interface.addChildAt(container, bigBunnies, index);

    interface.addChild(layout, container);
  }

  eachFrameFunction([num v]) {
    interface.addChildAt(container, bigBunnies, rdm.nextInt(nbOfObjects));
  }
}

class ZIndexRandomChildrenBenchmark extends ZIndexBenchmark
    implements BenchmarkBase {
  List _bunnies = [];
  dynamic container;
  int index = 1;

  ZIndexRandomChildrenBenchmark(
      Interface interface, nbOfObjects, layout, canvasWidth, canvasHeight)
      : super(interface, nbOfObjects, layout, canvasWidth, canvasHeight) {
    container = interface.createContainer();
    var dataBunnies =
        interface.createBitmapData(querySelector('#bunny'), 'bunny.png');
    createBunnies(dataBunnies, nbOfObjects, container, _bunnies, interface,
        layout, canvasWidth, canvasHeight);

    interface.addChild(layout, container);
  }

  eachFrameFunction([num v]) {
    for (var bunny in _bunnies) {
      interface.addChildAt(container, bunny, rdm.nextInt(nbOfObjects));
    }
  }
}

class ZIndexRandomChildrenMultipleTextureBenchmark extends ZIndexBenchmark
    implements BenchmarkBase {
  List _bunnies = [];
  dynamic container;
  int index = 1;
  Random rdm = new Random();

  ZIndexRandomChildrenMultipleTextureBenchmark(
      Interface interface, nbOfObjects, layout, canvasWidth, canvasHeight)
      : super(interface, nbOfObjects, layout, canvasWidth, canvasHeight) {
    container = interface.createContainer();
    var dataBunnies =
        interface.createBitmapData(querySelector('#bunny'), 'bunny.png');
    createBunnies(dataBunnies, nbOfObjects / 2, container, _bunnies, interface,
        layout, canvasWidth, canvasHeight);

    var dataBunniesRed =
        interface.createBitmapData(querySelector('#bunnyRed'), 'bunny_red.png');
    createBunnies(dataBunniesRed, nbOfObjects / 2, container, _bunnies,
        interface, layout, canvasWidth, canvasHeight);

    interface.addChild(layout, container);
  }

  eachFrameFunction([num v]) {
    for (var bunny in _bunnies) {
      interface.addChildAt(container, bunny, rdm.nextInt(nbOfObjects));
    }
  }
}
