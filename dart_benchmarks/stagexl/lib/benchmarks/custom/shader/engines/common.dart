import 'dart:async';

import 'package:stagexl_benchmark/benchmarks/custom/shader/interfaces/common.dart';
import 'package:stagexl_benchmark/interfaces/common.dart';
import 'package:stagexl_benchmark/runs/shaders/shaders.dart';

import '../../../common.dart';

class BenchmarkShaderManager extends BenchmarkManager {
  BenchmarkShaderManager(Interface interface, int canvasWidth, int canvasHeight,
      EachFrameFunction frameRendering, layout)
      : super(interface, canvasWidth, canvasHeight, frameRendering, layout);

  Future<Map> runShaderAllTypeAtOnceBenchmark(int objects) async {
    ShaderAllTypeAtOnceBenchmark benchmark = new ShaderAllTypeAtOnceBenchmark(
        interface, objects, layout, canvasWidth, canvasHeight);
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }

  Future<Map> runShaderStepByStepBenchmark(int objects) async {
    ShaderStepByStepBenchmark benchmark = new ShaderStepByStepBenchmark(
        interface, objects, layout, canvasWidth, canvasHeight);
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }

  Future<Map> runShaderByTypeBenchmark(
      int objects, ShaderType shaderType) async {
    ShaderByTypeBenchmark benchmark = new ShaderByTypeBenchmark(
        interface, objects, shaderType, layout, canvasWidth, canvasHeight);
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }
}
