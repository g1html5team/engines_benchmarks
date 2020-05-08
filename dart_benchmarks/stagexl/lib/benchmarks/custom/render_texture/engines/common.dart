import 'dart:async';

import 'package:stagexl_benchmark/interfaces/common.dart';
import 'package:stagexl_benchmark/runs/render_texture.dart';

import '../../../common.dart';

class BenchmarkRenderTextureManager extends BenchmarkManager {
  BenchmarkRenderTextureManager(Interface interface, int canvasWidth,
      int canvasHeight, EachFrameFunction frameRendering, layout)
      : super(interface, canvasWidth, canvasHeight, frameRendering, layout);

  Future<Map> createTexture() async {
    RenderTextureBenchmark benchmark = new RenderTextureBenchmark(
        interface, layout, canvasWidth, canvasHeight);
    await benchmark.loadAssets();
    await benchmark.initialize();
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();

    return processResult(result);
  }
}
