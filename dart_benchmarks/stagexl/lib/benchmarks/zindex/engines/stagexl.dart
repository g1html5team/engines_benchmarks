import 'dart:html';

import 'package:stagexl_benchmark/benchmarks/stagexl/common.dart';

import 'common.dart';

class StagexlBenchmarkZIndex extends StageXlBenchmark {
  StagexlBenchmarkZIndex(
      Element container, int canvasWidth, int canvasHeight, bool useWebGL)
      : super(container, canvasWidth, canvasHeight, useWebGL) {
    manager = new BenchmarkZIndexManager(
        interface, canvasWidth, canvasHeight, frameRendering, layout);
  }
}
