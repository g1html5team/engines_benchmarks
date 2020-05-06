import 'dart:html';

import 'package:pixi_dart_benchmark/benchmarks/custom/add_remove_child/interfaces/pixi.dart';
import 'package:pixi_dart_benchmark/benchmarks/pixi/common.dart';
import 'package:pixi_dart_benchmark/interfaces/pixi.dart';

import 'common.dart';

class PixiBenchmarkAddRemove extends PixiBenchmark {
  PixiInterface interface = new PixiAddRemoveInterface();
  PixiBenchmarkAddRemove(Element container, int canvasWidth, int canvasHeight)
      : super(container, canvasWidth, canvasHeight) {
    manager = new BenchmarkAddRemoveManager(
        interface, canvasWidth, canvasHeight, frameRendering, layout);
  }
}
