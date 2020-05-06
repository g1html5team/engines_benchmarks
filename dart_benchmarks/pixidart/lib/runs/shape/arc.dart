import 'dart:math';

import 'package:pixi_dart_benchmark/benchmarks/common.dart';
import 'package:pixi_dart_benchmark/benchmarks/custom/shape/interfaces/common.dart';
class ShapeArcBenchmark implements BenchmarkBase {
  final int canvasWidth;
  final int canvasHeight;
  final ShapeInterface interface;
  final layout;
  final int nbOfObjects;
  Random rdm = new Random();

  ShapeArcBenchmark(this.interface, this.nbOfObjects, this.layout,
      this.canvasWidth, this.canvasHeight) {
    for (int i = -1; ++i < nbOfObjects;) {
      var shape = interface.createShape(150, 150);
      interface.beginPath(shape, 0xffffff00);
      interface.arc(shape, 50, 50, 50, 0.25 * pi, 1.25 * pi, false);
      interface.fillColor(shape, 0xffffff00);
      interface.closePath(shape);
      shape
        ..x = (i % 10) * 100.0
        ..y = (i / 10).floor() * 80.0;
      interface.addChild(layout, shape);
    }
  }

  eachFrameFunction([num v]) {}
}
