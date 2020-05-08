import 'dart:async';

import 'package:stagexl_benchmark/benchmarks/common.dart';
import 'package:stagexl_benchmark/interfaces/common.dart';
import 'package:stagexl_benchmark/runs/filters.dart';

class BenchmarkFilterManager extends BenchmarkManager {
  BenchmarkFilterManager(Interface interface, int canvasWidth, int canvasHeight,
      EachFrameFunction frameRendering, layout)
      : super(interface, canvasWidth, canvasHeight, frameRendering, layout);

  Future<Map> runFilterBrightnessBenchmark(int objects) async {
    FilterBrightnessBenchmark benchmark = new FilterBrightnessBenchmark(
        interface, objects, layout, canvasWidth, canvasHeight);
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }

  Future<Map> runFilterHueBenchmark(int objects) async {
    FilterHueBenchmark benchmark = new FilterHueBenchmark(
        interface, objects, layout, canvasWidth, canvasHeight);
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }
}
