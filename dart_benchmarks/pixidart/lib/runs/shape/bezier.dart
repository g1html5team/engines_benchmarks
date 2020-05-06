import 'dart:math';

import 'package:pixi_dart_benchmark/benchmarks/common.dart';
import 'package:pixi_dart_benchmark/benchmarks/custom/shape/interfaces/common.dart';

class ShapeBezierBenchmark implements BenchmarkBase {
  final int canvasWidth;
  final int canvasHeight;
  final ShapeInterface interface;
  final layout;
  final int nbOfObjects;
  Random rdm = new Random();

  ShapeBezierBenchmark(this.interface, this.nbOfObjects, this.layout,
      this.canvasWidth, this.canvasHeight) {
    for (int i = -1; ++i < nbOfObjects;) {
      var shape = interface.createShape(150, 150);
      interface.beginPath(shape, 0xffff0000);
      interface.moveTo(shape, 4, 25);
      interface.bezierCurveTo(shape, 5, -6, 47, 3, 48, 33);
      interface.bezierCurveTo(shape, 48, 4, 95, -6, 95, 27);
      interface.bezierCurveTo(shape, 93, 47, 60, 45, 48, 82);
      interface.bezierCurveTo(shape, 38, 46, 5, 49, 4, 25);
      interface.fillColor(shape, 0xffff0000);
      interface.closePath(shape);
      shape
        ..x = (i % 10) * 100.0
        ..y = (i / 10).floor() * 80.0;
      interface.addChild(layout, shape);
    }
  }

  eachFrameFunction([num v]) {}
}
