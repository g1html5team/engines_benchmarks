import 'dart:html';

import 'package:stagexl_benchmark/benchmarks/custom/gpu_slots/interfaces/stagexl.dart';
import 'package:stagexl_benchmark/benchmarks/stagexl/common.dart';
import 'package:stagexl_benchmark/interfaces/stagexl.dart';

import 'common.dart';

class StagexlBenchmarkGPUSlots extends StageXlBenchmark {
  StagexlInterface interface = new StagexlGPUSlotsInterface();
  StagexlBenchmarkGPUSlots(
      Element container, int canvasWidth, int canvasHeight, bool useWebGL)
      : super(container, canvasWidth, canvasHeight) {
    manager = new BenchmarkGPUSlotsManager(
        interface, canvasWidth, canvasHeight, frameRendering, layout);
  }
}
