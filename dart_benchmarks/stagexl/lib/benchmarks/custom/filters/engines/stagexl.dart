import 'dart:html';
import 'package:stagexl_benchmark/benchmarks/custom/filters/interfaces/stagexl.dart';
import 'package:stagexl_benchmark/benchmarks/stagexl/common.dart';
import 'package:stagexl_benchmark/interfaces/stagexl.dart';

import 'common.dart';

class StagexlBenchmarkFilter extends StageXlBenchmark {
  StagexlInterface interface = new StagexlFilterInterface();
  StagexlBenchmarkFilter(
      Element container, int canvasWidth, int canvasHeight, bool useWebGL)
      : super(container, canvasWidth, canvasHeight) {
    manager = new BenchmarkFilterManager(
        interface, canvasWidth, canvasHeight, frameRendering, layout);
  }
}
