import 'dart:html';

import 'package:pixi_dart_benchmark/benchmarks/custom/blend_mode/interfaces/pixi.dart';
import 'package:pixi_dart_benchmark/benchmarks/pixi/common.dart';
import 'package:pixi_dart_benchmark/interfaces/pixi.dart';

import 'common.dart';

class PixiBenchmarkBlendMode extends PixiBenchmark {
  PixiInterface interface = new PixiBlendModeInterface();
  PixiBenchmarkBlendMode(Element container, int canvasWidth, int canvasHeight)
      : super(container, canvasWidth, canvasHeight) {
    manager = new BenchmarkBlendModeManager(
        interface, canvasWidth, canvasHeight, frameRendering, layout);
  }
}
