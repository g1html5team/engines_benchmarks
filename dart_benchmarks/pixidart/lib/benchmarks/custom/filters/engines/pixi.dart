import 'dart:html';

import 'package:pixi_dart_benchmark/benchmarks/custom/filters/interfaces/pixi.dart';
import 'package:pixi_dart_benchmark/benchmarks/pixi/common.dart';
import 'package:pixi_dart_benchmark/interfaces/pixi.dart';

import 'common.dart';

class PixiBenchmarkFilter extends PixiBenchmark {
  PixiInterface interface = new PixiFilterInterface();
  PixiBenchmarkFilter(Element container, int canvasWidth, int canvasHeight)
      : super(container, canvasWidth, canvasHeight) {
    manager = new BenchmarkFilterManager(
        interface, canvasWidth, canvasHeight, frameRendering, layout);
  }
}
