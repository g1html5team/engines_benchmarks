import 'dart:html';

import 'package:pixi_dart_benchmark/benchmarks/pixi/common.dart';

import 'common.dart';

class PixiBenchmarkZIndex extends PixiBenchmark {
  PixiBenchmarkZIndex(Element container, int canvasWidth, int canvasHeight)
      : super(container, canvasWidth, canvasHeight) {
    manager = new BenchmarkZIndexManager(
        interface, canvasWidth, canvasHeight, frameRendering, layout);
  }
}
