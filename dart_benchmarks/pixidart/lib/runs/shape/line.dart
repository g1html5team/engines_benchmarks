import 'dart:math';

import 'package:pixi_dart_benchmark/benchmarks/common.dart';
import 'package:pixi_dart_benchmark/benchmarks/custom/shape/interfaces/common.dart';

class ShapeLineBenchmark implements BenchmarkBase {
  final int canvasWidth;
  final int canvasHeight;
  final ShapeInterface interface;
  final layout;
  final int nbOfObjects;
  Random rdm = new Random();

  ShapeLineBenchmark(this.interface, this.nbOfObjects, this.layout,
      this.canvasWidth, this.canvasHeight) {
    for (int i = -1; ++i < nbOfObjects;) {
      var shape = interface.createShape(150, 150);
      interface.beginPath(shape, 0xff0000ff);
      interface.moveTo(shape, 62, 101);
      interface.lineTo(shape, 10, 60);
      interface.lineTo(shape, 61, 58);
      interface.lineTo(shape, 90, 8);
      interface.lineTo(shape, 119, 60);
      interface.lineTo(shape, 171, 61);
      interface.lineTo(shape, 120, 100);
      interface.lineTo(shape, 59, 100);
      interface.fillColor(shape, 0xff0000ff);
      interface.closePath(shape);
      shape
        ..x = (i % 10) * 100.0
        ..y = (i / 10).floor() * 80.0;
      interface.addChild(layout, shape);
    }
  }

  eachFrameFunction([num v]) {}
}
