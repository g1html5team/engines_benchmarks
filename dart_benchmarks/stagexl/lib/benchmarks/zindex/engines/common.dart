import 'dart:async';

import 'package:stagexl_benchmark/interfaces/common.dart';
import 'package:stagexl_benchmark/runs/zindex.dart';

import '../../common.dart';

class BenchmarkZIndexManager extends BenchmarkManager {
  BenchmarkZIndexManager(Interface interface, int canvasWidth, int canvasHeight,
      EachFrameFunction frameRendering, layout)
      : super(interface, canvasWidth, canvasHeight, frameRendering, layout);

  Future<Map> runZIndexOneChildBenchmark(int objects) async {
    ZIndexOneChildBenchmark benchmark = new ZIndexOneChildBenchmark(
        interface, objects, layout, canvasWidth, canvasHeight);
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }

  Future<Map> runZIndexAllChildBenchmark(int objects) async {
    ZIndexRandomChildrenBenchmark benchmark = new ZIndexRandomChildrenBenchmark(
        interface, objects, layout, canvasWidth, canvasHeight);
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }

  Future<Map> runZIndexAllChildMultipleTextureBenchmark(int objects) async {
    ZIndexRandomChildrenMultipleTextureBenchmark benchmark =
        new ZIndexRandomChildrenMultipleTextureBenchmark(
            interface, objects, layout, canvasWidth, canvasHeight);
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }
}
