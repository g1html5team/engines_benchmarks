import 'dart:async';
import 'package:pixi_dart_benchmark/benchmarks/common.dart';
import 'package:pixi_dart_benchmark/benchmarks/custom/blend_mode/interfaces/common.dart';
import 'package:pixi_dart_benchmark/interfaces/common.dart';
import 'package:pixi_dart_benchmark/runs/blend_mode.dart';

class BenchmarkBlendModeManager extends BenchmarkManager {
  BenchmarkBlendModeManager(Interface interface, int canvasWidth,
      int canvasHeight, EachFrameFunction frameRendering, layout)
      : super(interface, canvasWidth, canvasHeight, frameRendering, layout);

  Future<Map> runBlendModeNormalBenchmark(int objects) async {
    BlendModeBenchmark benchmark = new BlendModeBenchmark(interface, objects,
        layout, canvasWidth, canvasHeight, BlendModeType.normal);
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }

  Future<Map> runBlendModeAddBenchmark(int objects) async {
    BlendModeBenchmark benchmark = new BlendModeBenchmark(interface, objects,
        layout, canvasWidth, canvasHeight, BlendModeType.add);
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }

  Future<Map> runBlendModeMultiplyBenchmark(int objects) async {
    BlendModeBenchmark benchmark = new BlendModeBenchmark(interface, objects,
        layout, canvasWidth, canvasHeight, BlendModeType.multiply);
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }

  Future<Map> runBlendModeOverlayBenchmark(int objects) async {
    BlendModeBenchmark benchmark = new BlendModeBenchmark(interface, objects,
        layout, canvasWidth, canvasHeight, BlendModeType.overlay);
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }

  Future<Map> runBlendModeScreenBenchmark(int objects) async {
    BlendModeBenchmark benchmark = new BlendModeBenchmark(interface, objects,
        layout, canvasWidth, canvasHeight, BlendModeType.screen);
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }

  Future<Map> runBlendModeRandomBenchmark(int objects) async {
    BlendModeBenchmark benchmark = new BlendModeBenchmark(
        interface, objects, layout, canvasWidth, canvasHeight, null);
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }
}
