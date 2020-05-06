import 'dart:html';

import 'package:pixi_dart_benchmark/benchmarks/custom/gpu_slots/interfaces/pixi.dart';
import 'package:pixi_dart_benchmark/benchmarks/pixi/common.dart';
import 'package:pixi_dart_benchmark/interfaces/pixi.dart';

import 'common.dart';

class PixiBenchmarkGPUSlots extends PixiBenchmark {
  PixiInterface interface = new PixiGPUSlotsInterface();
  PixiBenchmarkGPUSlots(Element container, int canvasWidth, int canvasHeight)
      : super(container, canvasWidth, canvasHeight) {
    manager = new BenchmarkGPUSlotsManager(
        interface, canvasWidth, canvasHeight, frameRendering, layout);
  }
}
