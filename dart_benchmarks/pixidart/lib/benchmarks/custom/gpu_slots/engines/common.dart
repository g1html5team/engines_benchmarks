import 'dart:async';

import 'package:pixi_dart_benchmark/interfaces/common.dart';
import 'package:pixi_dart_benchmark/runs/gpu_slots.dart';

import '../../../common.dart';

class BenchmarkGPUSlotsManager extends BenchmarkManager {
  BenchmarkGPUSlotsManager(Interface interface, int canvasWidth,
      int canvasHeight, EachFrameFunction frameRendering, layout)
      : super(interface, canvasWidth, canvasHeight, frameRendering, layout);

  Future<Map> runGPUSlotsOverflowBenchmark(int objects) async {
    GPUSlotsOverflowBenchmark benchmark = new GPUSlotsOverflowBenchmark(
        interface, objects, layout, canvasWidth, canvasHeight);
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }
}
