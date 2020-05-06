import 'dart:html';

import 'package:pixi_dart_benchmark/benchmarks/custom/shape/engines/common.dart';
import 'package:pixi_dart_benchmark/benchmarks/custom/shape/interfaces/pixi.dart';
import 'package:pixi_dart_benchmark/benchmarks/pixi/common.dart';
import 'package:pixi_dart_benchmark/interfaces/pixi.dart';

class PixiBenchmarkShape extends PixiBenchmark {
  PixiInterface interface = new PixiShapeInterface();
  PixiBenchmarkShape(Element container, int canvasWidth, int canvasHeight)
      : super(container, canvasWidth, canvasHeight) {
    manager = new BenchmarkShapeManager(
        interface, canvasWidth, canvasHeight, frameRendering, layout);
  }
}
