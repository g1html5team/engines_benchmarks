import 'dart:async';

import 'package:pixi_dart_benchmark/benchmarks/common.dart';
import 'package:pixi_dart_benchmark/interfaces/common.dart';
import 'package:pixi_dart_benchmark/runs/flipbook.dart';


class BenchmarkFlipbookManager extends BenchmarkManager {
  BenchmarkFlipbookManager(Interface interface, int canvasWidth,
      int canvasHeight, EachFrameFunction frameRendering, layout)
      : super(interface, canvasWidth, canvasHeight, frameRendering, layout);

  Future<Map> runFlipbookBenchmark() async {
    FlipbookBenchmark benchmark =
        new FlipbookBenchmark(interface, layout, canvasWidth, canvasHeight);
    await benchmark.initialize();
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }
}
