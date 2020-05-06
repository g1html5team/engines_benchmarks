import 'dart:async';
import 'dart:html';

import 'package:pixi_dart_benchmark/benchmarks/common.dart';
import 'package:pixi_dart_benchmark/benchmarks/custom/texture_switch/interfaces/pixi.dart';
import 'package:pixi_dart_benchmark/benchmarks/pixi/common.dart';
import 'package:pixi_dart_benchmark/interfaces/common.dart';
import 'package:pixi_dart_benchmark/interfaces/pixi.dart';
import 'package:pixi_dart_benchmark/runs/textures_switch/pixi.dart';

import 'common.dart';

class PixiBenchmarkTextureSwitch extends PixiBenchmark {
  PixiInterface interface;
  PixiBenchmarkTextureSwitch(
      Element container, int canvasWidth, int canvasHeight)
      : super(container, canvasWidth, canvasHeight) {
    interface = new PixiTextureSwitchInterface(app);
    manager = new PixiBenchmarkTextureSwitchManager(
        interface, canvasWidth, canvasHeight, frameRendering, layout);
  }
}

class PixiBenchmarkTextureSwitchManager extends IBenchmarkTextureSwitchManager {
  PixiBenchmarkTextureSwitchManager(Interface interface, int canvasWidth,
      int canvasHeight, EachFrameFunction frameRendering, layout)
      : super(interface, canvasWidth, canvasHeight, frameRendering, layout);

  Future<Map> runTextureSwitchBenchmark(int objects) async {
    PixiTextureSwitchBenchmark benchmark = new PixiTextureSwitchBenchmark(
        interface, objects, layout, canvasWidth, canvasHeight);
    await benchmark.init();
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }
}
