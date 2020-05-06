import 'dart:math';

import 'package:pixi_dart_benchmark/benchmarks/common.dart';
import 'package:pixi_dart_benchmark/benchmarks/custom/shape/interfaces/common.dart';

class ShapeQuadraticBenchmark implements BenchmarkBase {
  final int canvasWidth;
  final int canvasHeight;
  final ShapeInterface interface;
  final layout;
  final int nbOfObjects;
  Random rdm = new Random();

  ShapeQuadraticBenchmark(this.interface, this.nbOfObjects, this.layout,
      this.canvasWidth, this.canvasHeight) {
    for (int i = -1; ++i < nbOfObjects;) {
      var shape = interface.createShape(150, 150);
      interface.beginPath(shape, 0xff00ff00);
      interface.moveTo(shape, 83, 10);
      interface.quadraticCurveTo(shape, -2, -8, 7, 71);
      interface.quadraticCurveTo(shape, 87, 31, 43, 87);
      interface.quadraticCurveTo(shape, 139, 157, 93, 49);
      interface.quadraticCurveTo(shape, 32, 74, 83, 11);
      interface.fillColor(shape, 0xff00ff00);
      interface.closePath(shape);
      shape
        ..x = (i % 10) * 100.0
        ..y = (i / 10).floor() * 80.0;
      interface.addChild(layout, shape);
    }
  }

  eachFrameFunction([num v]) {}
}
