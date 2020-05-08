import 'dart:html';

import 'package:stagexl_benchmark/benchmarks/custom/shader/interfaces/stagexl.dart';
import 'package:stagexl_benchmark/benchmarks/stagexl/common.dart';
import 'package:stagexl_benchmark/interfaces/stagexl.dart';

import 'common.dart';

class StagexlBenchmarkShader extends StageXlBenchmark {
  StagexlInterface interface = new StagexlShaderInterface();
  StagexlBenchmarkShader(
      Element container, int canvasWidth, int canvasHeight, bool useWebGL)
      : super(container, canvasWidth, canvasHeight, useWebGL) {
    manager = new BenchmarkShaderManager(
        interface, canvasWidth, canvasHeight, frameRendering, layout);
  }
}
