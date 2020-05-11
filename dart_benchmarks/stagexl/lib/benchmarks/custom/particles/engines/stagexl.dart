import 'dart:html';

import 'package:stagexl_benchmark/benchmarks/custom/particles/interfaces/stagexl.dart';
import 'package:stagexl_benchmark/benchmarks/stagexl/common.dart';
import 'package:stagexl_benchmark/interfaces/stagexl.dart';

import 'common.dart';

class StagexlBenchmarkParticles extends StageXlBenchmark {
  StagexlInterface interface = new StagexlParticlesInterface();
  StagexlBenchmarkParticles(
      Element container, int canvasWidth, int canvasHeight, bool useWebGL)
      : super(container, canvasWidth, canvasHeight, useWebGL) {
    manager = new BenchmarkParticlesManager(
        interface, canvasWidth, canvasHeight, frameRendering, layout);
  }
}
