import 'dart:html';
import 'dart:math';
import 'package:stagexl_benchmark/benchmarks/common.dart';
import 'package:stagexl_benchmark/benchmarks/custom/filters/interfaces/common.dart';

class FilterBrightnessBenchmark implements BenchmarkBase {
  final int canvasWidth;
  final int canvasHeight;
  final FilterInterface interface;
  final layout;
  final int nbOfObjects;
  List _bunnies = [];
  Random rdm = new Random();

  FilterBrightnessBenchmark(this.interface, this.nbOfObjects, this.layout,
      this.canvasWidth, this.canvasHeight) {
    var container = interface.createContainer();
    var data = interface.createBitmapData(querySelector('#bunny'), 'bunny.png');
    for (int i = -1; ++i < nbOfObjects;) {
      var bunny = interface.createBitmap(data);
      interface.addChild(container, bunny);
      interface.setX(bunny, rdm.nextInt(canvasWidth));
      interface.setY(bunny, rdm.nextInt(canvasHeight));
      interface.setRotation(bunny, rdm.nextDouble() * pi);
      interface.centerPivot(bunny);
      _bunnies.add(bunny);
    }

    interface.addChild(layout, container);
  }

  eachFrameFunction([num v]) {
    for (var bunny in _bunnies) {
      interface.setBrightness(bunny, rdm.nextDouble());
    }
  }
}

class FilterHueBenchmark implements BenchmarkBase {
  final int canvasWidth;
  final int canvasHeight;
  final FilterInterface interface;
  final layout;
  final int nbOfObjects;
  List _bunnies = [];
  Random rdm = new Random();

  FilterHueBenchmark(this.interface, this.nbOfObjects, this.layout,
      this.canvasWidth, this.canvasHeight) {
    var container = interface.createContainer();
    var data = interface.createBitmapData(querySelector('#bunny'), 'bunny.png');
    for (int i = -1; ++i < nbOfObjects;) {
      var bunny = interface.createBitmap(data);
      interface.addChild(container, bunny);
      interface.setX(bunny, rdm.nextInt(canvasWidth));
      interface.setY(bunny, rdm.nextInt(canvasHeight));
      interface.setRotation(bunny, rdm.nextDouble() * pi);
      interface.centerPivot(bunny);
      _bunnies.add(bunny);
    }

    interface.addChild(layout, container);
  }

  eachFrameFunction([num v]) {
    for (var bunny in _bunnies) {
      interface.setHue(bunny, rdm.nextDouble());
    }
  }
}
