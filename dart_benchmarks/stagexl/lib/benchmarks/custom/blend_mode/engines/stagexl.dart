import 'dart:html';

import 'package:stagexl_benchmark/benchmarks/custom/blend_mode/interfaces/stagexl.dart';
import 'package:stagexl_benchmark/benchmarks/stagexl/common.dart';
import 'package:stagexl_benchmark/interfaces/stagexl.dart';

import 'common.dart';

class StagexlBenchmarkBlendMode extends StageXlBenchmark {
  StagexlInterface interface = new StagexlBlendModeInterface();
  StagexlBenchmarkBlendMode(
      Element container, int canvasWidth, int canvasHeight, bool useWebGL)
      : super(container, canvasWidth, canvasHeight) {
    manager = new BenchmarkBlendModeManager(
        interface, canvasWidth, canvasHeight, frameRendering, layout);
  }
}
