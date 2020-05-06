import 'dart:async';

import 'package:pixi_dart_benchmark/benchmarks/common.dart';
import 'package:pixi_dart_benchmark/interfaces/common.dart';
import 'package:pixi_dart_benchmark/runs/visibility.dart';

class BenchmarkVisibilityManager extends BenchmarkManager {
  BenchmarkVisibilityManager(Interface interface, int canvasWidth,
      int canvasHeight, EachFrameFunction frameRendering, layout)
      : super(interface, canvasWidth, canvasHeight, frameRendering, layout);

  Future<Map> runOutOfScene(int objects) async {
    OutOfSceneBenchmark benchmark = new OutOfSceneBenchmark(
        interface, objects, layout, canvasWidth, canvasHeight);
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }

  Future<Map> runVisibilityFalse(int objects) async {
    VisibleFalseBenchmark benchmark = new VisibleFalseBenchmark(
        interface, objects, layout, canvasWidth, canvasHeight);
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }

  Future<Map> runAlpha0(int objects) async {
    Alpha0Benchmark benchmark = new Alpha0Benchmark(
        interface, objects, layout, canvasWidth, canvasHeight);
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }

  Future<Map> runMoveOutside(int objects) async {
    MoveOutsideBenchmark benchmark = new MoveOutsideBenchmark(
        interface, objects, layout, canvasWidth, canvasHeight);
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }

  Future<Map> runScale0(int objects) async {
    Scale0Benchmark benchmark = new Scale0Benchmark(
        interface, objects, layout, canvasWidth, canvasHeight);
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }
}
