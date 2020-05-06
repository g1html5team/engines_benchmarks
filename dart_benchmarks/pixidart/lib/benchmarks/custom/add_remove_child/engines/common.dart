import 'dart:async';

import 'package:pixi_dart_benchmark/interfaces/common.dart';
import 'package:pixi_dart_benchmark/runs/add_remove_child.dart';

import '../../../common.dart';

class BenchmarkAddRemoveManager extends BenchmarkManager {
  BenchmarkAddRemoveManager(Interface interface, int canvasWidth,
      int canvasHeight, EachFrameFunction frameRendering, layout)
      : super(interface, canvasWidth, canvasHeight, frameRendering, layout);

  Future<Map> runSimpleAddBenchmark(int objects) async {
    SimpleAddBenchmark benchmark = new SimpleAddBenchmark(
        interface, objects, layout, canvasWidth, canvasHeight);
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }

  Future<Map> runSimpleAddRemoveBenchmark(int objects) async {
    SimpleAddRemoveBenchmark benchmark = new SimpleAddRemoveBenchmark(
        interface, objects, layout, canvasWidth, canvasHeight);
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }

  Future<Map> runAddRemoveContainerBenchmark(int objects) async {
    AddRemoveContainerBenchmark benchmark = new AddRemoveContainerBenchmark(
        interface, objects, layout, canvasWidth, canvasHeight);
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }
}
