import 'dart:html';

import 'package:stagexl_benchmark/benchmarks/custom/render_texture/interfaces/stagexl.dart';
import 'package:stagexl_benchmark/benchmarks/stagexl/common.dart';
import 'package:stagexl_benchmark/interfaces/stagexl.dart';

import 'common.dart';

class StagexlBenchmarkRenderTexture extends StageXlBenchmark {
  StagexlInterface interface = new StagexlRenderTextureInterface();
  StagexlBenchmarkRenderTexture(
      Element container, int canvasWidth, int canvasHeight, bool useWebGL)
      : super(container, canvasWidth, canvasHeight, useWebGL) {
    manager = new BenchmarkRenderTextureManager(
        interface, canvasWidth, canvasHeight, frameRendering, layout);
  }
}
