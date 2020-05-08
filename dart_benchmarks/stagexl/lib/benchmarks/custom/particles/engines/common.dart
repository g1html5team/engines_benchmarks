import 'dart:async';

import 'package:stagexl/stagexl.dart';
import 'package:stagexl_benchmark/interfaces/common.dart';
import 'package:stagexl_benchmark/runs/particles.dart';

import '../../../common.dart';

class BenchmarkParticlesManager extends BenchmarkManager {
  BenchmarkParticlesManager(Interface interface, int canvasWidth,
      int canvasHeight, EachFrameFunction frameRendering, layout, this.juggler)
      : super(interface, canvasWidth, canvasHeight, frameRendering, layout);

  Future<Map> runParticles1Benchmark(int objects) async {
    Particles1Benchmark benchmark = new Particles1Benchmark(
        interface, objects, layout, canvasWidth, canvasHeight);
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }

  Juggler juggler;

  Future<Map> runParticles2Benchmark(int objects) async {
    Particles2Benchmark benchmark = new Particles2Benchmark(
        interface, objects, layout, canvasWidth, canvasHeight, juggler);
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }
}
