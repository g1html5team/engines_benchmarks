import 'dart:math';

import 'package:pixi_dart_benchmark/benchmarks/common.dart';
import 'package:pixi_dart_benchmark/benchmarks/custom/shape/interfaces/common.dart';

class ShapeRectBenchmark implements BenchmarkBase {
  final int canvasWidth;
  final int canvasHeight;
  final ShapeInterface interface;
  final layout;
  final int nbOfObjects;
  Random rdm = new Random();

  ShapeRectBenchmark(this.interface, this.nbOfObjects, this.layout,
      this.canvasWidth, this.canvasHeight) {
    for (int i = -1; ++i < nbOfObjects;) {
      var shape = interface.createShape(40, 40);
      interface.beginPath(shape, 0xffffff00);
      interface.rect(shape, 0, 0, 35.0, 35.0);
      interface.fillColor(shape, 0xffffff00);
      interface.closePath(shape);
      shape
        ..x = (i % 30) * 40.0
        ..y = (i / 30).floor() * 40.0;
      interface.addChild(layout, shape);
    }
  }

  eachFrameFunction([num v]) {
    //
  }
}
