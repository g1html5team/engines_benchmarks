import 'dart:html';

import 'package:pixi_dart_benchmark/benchmarks/custom/visibility/interfaces/pixi.dart';
import 'package:pixi_dart_benchmark/benchmarks/pixi/common.dart';
import 'package:pixi_dart_benchmark/interfaces/pixi.dart';

import 'common.dart';

class PixiBenchmarkVisibility extends PixiBenchmark {
  PixiInterface interface = new PixiVisibilityInterface();
  PixiBenchmarkVisibility(Element container, int canvasWidth, int canvasHeight)
      : super(container, canvasWidth, canvasHeight) {
    manager = new BenchmarkVisibilityManager(
        interface, canvasWidth, canvasHeight, frameRendering, layout);
  }
}
