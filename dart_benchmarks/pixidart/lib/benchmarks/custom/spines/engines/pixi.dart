import 'dart:async';
import 'dart:html';

import 'package:pixi_dart_benchmark/benchmarks/common.dart';
import 'package:pixi_dart_benchmark/benchmarks/custom/spines/interfaces/pixi.dart';
import 'package:pixi_dart_benchmark/benchmarks/pixi/common.dart';
import 'package:pixi_dart_benchmark/interfaces/common.dart';
import 'package:pixi_dart_benchmark/interfaces/pixi.dart';
import 'package:pixi_dart_benchmark/runs/spines/pixi.dart';

import 'common.dart';

class PixiBenchmarkSpines extends PixiBenchmark {
  PixiInterface interface = new PixiSpinesInterface();
  PixiBenchmarkSpines(Element container, int canvasWidth, int canvasHeight)
      : super(container, canvasWidth, canvasHeight) {
    manager = new PixiBenchmarkSpinesManager(
        interface, canvasWidth, canvasHeight, frameRendering, layout);
  }
}

class PixiBenchmarkSpinesManager extends IBenchmarkSpinesManager {
  PixiBenchmarkSpinesManager(Interface interface, int canvasWidth,
      int canvasHeight, EachFrameFunction frameRendering, layout)
      : super(interface, canvasWidth, canvasHeight, frameRendering, layout);

  Future<Map> runSpinesBenchmark(int objects, int deformObj) async {
    PixiSpinesBenchmark benchmark = new PixiSpinesBenchmark(
        interface, objects, deformObj, layout, canvasWidth, canvasHeight);
    await benchmark.init();
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }
}
