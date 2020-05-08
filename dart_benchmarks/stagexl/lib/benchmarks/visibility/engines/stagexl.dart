import 'dart:html';

import 'package:stagexl_benchmark/benchmarks/stagexl/common.dart';
import 'package:stagexl_benchmark/benchmarks/visibility/interfaces/stagexl.dart';
import 'package:stagexl_benchmark/interfaces/stagexl.dart';

import 'common.dart';
class StagexlBenchmarkVisibility extends StageXlBenchmark {
  StagexlInterface interface = new StagexlVisibilityInterface();
  StagexlBenchmarkVisibility(
      Element container, int canvasWidth, int canvasHeight, bool useWebGL)
      : super(container, canvasWidth, canvasHeight, useWebGL) {
    manager = new BenchmarkVisibilityManager(
        interface, canvasWidth, canvasHeight, frameRendering, layout);
  }
}
