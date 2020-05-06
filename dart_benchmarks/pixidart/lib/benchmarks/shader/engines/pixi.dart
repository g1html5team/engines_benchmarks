import 'dart:html';

import 'package:pixi_dart_benchmark/benchmarks/pixi/common.dart';
import 'package:pixi_dart_benchmark/benchmarks/shader/interfaces/pixi.dart';
import 'package:pixi_dart_benchmark/interfaces/pixi.dart';

import 'common.dart';

class PixiBenchmarkShader extends PixiBenchmark {
  PixiInterface interface = new PixiShaderInterface();
  PixiBenchmarkShader(Element container, int canvasWidth, int canvasHeight)
      : super(container, canvasWidth, canvasHeight) {
    manager = new BenchmarkShaderManager(
        interface, canvasWidth, canvasHeight, frameRendering, layout);
  }
}
