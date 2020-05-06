import 'dart:html';
import 'package:pixi_dart_benchmark/benchmarks/custom/render_texture/interfaces/pixi.dart';
import 'package:pixi_dart_benchmark/benchmarks/pixi/common.dart';
import 'package:pixi_dart_benchmark/interfaces/pixi.dart';

import 'common.dart';

class PixiBenchmarkRenderTexture extends PixiBenchmark {
  PixiInterface interface;
  PixiBenchmarkRenderTexture(
      Element container, int canvasWidth, int canvasHeight)
      : super(container, canvasWidth, canvasHeight) {
    interface = new PixiRenderTextureInterface(app);
    manager = new BenchmarkRenderTextureManager(
        interface, canvasWidth, canvasHeight, frameRendering, layout);
  }
}
