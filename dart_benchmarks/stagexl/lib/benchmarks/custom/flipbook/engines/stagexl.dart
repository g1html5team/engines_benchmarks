import 'dart:html';

import 'package:stagexl_benchmark/benchmarks/custom/flipbook/interfaces/stagexl.dart';
import 'package:stagexl_benchmark/benchmarks/stagexl/common.dart';
import 'package:stagexl_benchmark/interfaces/stagexl.dart';

import 'common.dart';

class StagexlBenchmarkFlipbook extends StageXlBenchmark {
  StagexlInterface interface = new StagexlFlipbookInterface();
  StagexlBenchmarkFlipbook(
      Element container, int canvasWidth, int canvasHeight, bool useWebGL)
      : super(container, canvasWidth, canvasHeight, useWebGL) {
    manager = new BenchmarkFlipbookManager(
        interface, canvasWidth, canvasHeight, frameRendering, layout);
  }
}
