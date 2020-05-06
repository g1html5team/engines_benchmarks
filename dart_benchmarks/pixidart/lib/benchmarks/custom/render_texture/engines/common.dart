import 'dart:async';

import 'package:pixi_dart_benchmark/benchmarks/common.dart';
import 'package:pixi_dart_benchmark/interfaces/common.dart';
import 'package:pixi_dart_benchmark/runs/render_texture.dart';

class BenchmarkRenderTextureManager extends BenchmarkManager {
  BenchmarkRenderTextureManager(Interface interface, int canvasWidth,
      int canvasHeight, EachFrameFunction frameRendering, layout)
      : super(interface, canvasWidth, canvasHeight, frameRendering, layout);

  Future<Map> createTexture() async {
    print("createTexture");
    RenderTextureBenchmark benchmark = new RenderTextureBenchmark(
        interface, layout, canvasWidth, canvasHeight);
    print("loadAssets");
    await benchmark.loadAssets();
    print("initialize");
    await benchmark.initialize();
    print("runner");
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    print("run");
    BenchmarkResult result = await runner.run();

    return processResult(result);
  }
}
