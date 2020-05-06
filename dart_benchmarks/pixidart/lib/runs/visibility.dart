import 'dart:html';
import 'dart:math';

import 'package:pixi_dart_benchmark/benchmarks/common.dart';
import 'package:pixi_dart_benchmark/benchmarks/custom/visibility/interfaces/common.dart';

class VisibilityBenchmark implements BenchmarkBase {
  final int canvasWidth;
  final int canvasHeight;
  final VisibilityInterface interface;
  final layout;
  final int nbOfObjects;
  Random rdm = new Random();

  VisibilityBenchmark(this.interface, this.nbOfObjects, this.layout,
      this.canvasWidth, this.canvasHeight);

  createBunnies(data, nbOfObjects, container, list, interface, layout,
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

class OutOfSceneBenchmark extends VisibilityBenchmark implements BenchmarkBase {
  List _bunnies = [];
  Random rdm = new Random();

  OutOfSceneBenchmark(interface, nbOfObjects, layout, canvasWidth, canvasHeight)
      : super(interface, nbOfObjects, layout, canvasWidth, canvasHeight) {
    var container = interface.createContainer();
    var data = interface.createBitmapData(querySelector('#bunny'), 'bunny.png');
    createBunnies(data, nbOfObjects, container, _bunnies, interface, layout,
        canvasWidth, canvasHeight);

    interface.addChild(layout, container);
  }

  eachFrameFunction([num v]) {
    if (v > 2000) {
      for (var bunny in _bunnies) {
        interface.setX(bunny,
            -200 + rdm.nextInt(10) + (rdm.nextInt(2)) * (canvasWidth + 400));
        interface.setY(bunny,
            -200 + rdm.nextInt(10) + (rdm.nextInt(2)) * (canvasHeight + 400));
        interface.setRotation(bunny, 1);
      }
    }
  }
}

class VisibleFalseBenchmark extends VisibilityBenchmark
    implements BenchmarkBase {
  List _bunnies = [];
  Random rdm = new Random();

  VisibleFalseBenchmark(
      interface, nbOfObjects, layout, canvasWidth, canvasHeight)
      : super(interface, nbOfObjects, layout, canvasWidth, canvasHeight) {
    var container = interface.createContainer();
    var data = interface.createBitmapData(querySelector('#bunny'), 'bunny.png');
    createBunnies(data, nbOfObjects, container, _bunnies, interface, layout,
        canvasWidth, canvasHeight);

    interface.addChild(layout, container);
  }

  eachFrameFunction([num v]) {
    if (v > 2000) {
      for (var bunny in _bunnies) {
        interface.setX(bunny, rdm.nextInt(canvasWidth));
        interface.setY(bunny, rdm.nextInt(canvasHeight));
        interface.setVisible(bunny, false);
      }
    }
  }
}

class Alpha0Benchmark extends VisibilityBenchmark implements BenchmarkBase {
  List _bunnies = [];
  Random rdm = new Random();

  Alpha0Benchmark(interface, nbOfObjects, layout, canvasWidth, canvasHeight)
      : super(interface, nbOfObjects, layout, canvasWidth, canvasHeight) {
    var container = interface.createContainer();
    var data = interface.createBitmapData(querySelector('#bunny'), 'bunny.png');
    createBunnies(data, nbOfObjects, container, _bunnies, interface, layout,
        canvasWidth, canvasHeight);

    interface.addChild(layout, container);
  }

  eachFrameFunction([num v]) {
    if (v > 2000) {
      for (var bunny in _bunnies) {
        interface.setX(bunny, rdm.nextInt(canvasWidth));
        interface.setY(bunny, rdm.nextInt(canvasHeight));
        interface.setAlpha(bunny, 0);
      }
    }
  }
}

class MoveOutsideBenchmark extends VisibilityBenchmark
    implements BenchmarkBase {
  List _bunnies = [];
  Random rdm = new Random();

  MoveOutsideBenchmark(
      interface, nbOfObjects, layout, canvasWidth, canvasHeight)
      : super(interface, nbOfObjects, layout, canvasWidth, canvasHeight) {
    var container = interface.createContainer();
    var data = interface.createBitmapData(querySelector('#bunny'), 'bunny.png');
    createBunnies(data, nbOfObjects, container, _bunnies, interface, layout,
        canvasWidth, canvasHeight);

    interface.addChild(layout, container);
  }

  eachFrameFunction([num v]) {
    if (v > 2000) {
      for (var bunny in _bunnies) {
        interface.setX(bunny, rdm.nextInt(-canvasWidth + canvasWidth * 3));
        interface.setY(bunny, rdm.nextInt(-canvasHeight + canvasHeight * 3));
      }
    }
  }
}

class Scale0Benchmark extends VisibilityBenchmark implements BenchmarkBase {
  List _bunnies = [];
  Random rdm = new Random();

  Scale0Benchmark(interface, nbOfObjects, layout, canvasWidth, canvasHeight)
      : super(interface, nbOfObjects, layout, canvasWidth, canvasHeight) {
    var container = interface.createContainer();
    var data = interface.createBitmapData(querySelector('#bunny'), 'bunny.png');
    createBunnies(data, nbOfObjects, container, _bunnies, interface, layout,
        canvasWidth, canvasHeight);

    interface.addChild(layout, container);
  }

  eachFrameFunction([num v]) {
    if (v > 2000) {
      for (var bunny in _bunnies) {
        interface.setX(bunny, rdm.nextInt(canvasWidth));
        interface.setY(bunny, rdm.nextInt(canvasHeight));
        interface.setScale(bunny, 0);
      }
    }
  }
}
