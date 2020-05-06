import 'dart:html';

import 'package:pixi_dart_benchmark/benchmarks/custom/flipbook/engines/common.dart';
import 'package:pixi_dart_benchmark/benchmarks/custom/flipbook/interfaces/pixi.dart';
import 'package:pixi_dart_benchmark/benchmarks/pixi/common.dart';
import 'package:pixi_dart_benchmark/interfaces/pixi.dart';



class PixiBenchmarkFlipbook extends PixiBenchmark {
  PixiInterface interface = new PixiFlipbookInterface();
  PixiBenchmarkFlipbook(Element container, int canvasWidth, int canvasHeight)
      : super(container, canvasWidth, canvasHeight) {
    manager = new BenchmarkFlipbookManager(
        interface, canvasWidth, canvasHeight, frameRendering, layout);
  }
}
