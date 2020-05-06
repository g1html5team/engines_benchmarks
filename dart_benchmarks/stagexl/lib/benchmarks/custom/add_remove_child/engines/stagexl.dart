import 'dart:html';

import 'package:stagexl_benchmark/benchmarks/custom/add_remove_child/interfaces/stagexl.dart';
import 'package:stagexl_benchmark/benchmarks/stagexl/common.dart';
import 'package:stagexl_benchmark/interfaces/stagexl.dart';

import 'common.dart';

class StagexlBenchmarkAddRemove extends StageXlBenchmark {
  StagexlInterface interface = new StagexlAddRemoveInterface();
  StagexlBenchmarkAddRemove(
      Element container, int canvasWidth, int canvasHeight)
      : super(container, canvasWidth, canvasHeight) {
    manager = new BenchmarkAddRemoveManager(
        interface, canvasWidth, canvasHeight, frameRendering, layout);
  }
}
