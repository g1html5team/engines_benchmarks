import 'dart:async';

import 'package:pixi_dart_benchmark/benchmarks/common.dart';
import 'package:pixi_dart_benchmark/interfaces/common.dart';

class IBenchmarkSpinesManager extends BenchmarkManager {
  IBenchmarkSpinesManager(Interface interface, int canvasWidth,
      int canvasHeight, EachFrameFunction frameRendering, layout)
      : super(interface, canvasWidth, canvasHeight, frameRendering, layout);

  Future<Map> runSpinesBenchmark(int nbOfObjects, int nbOfDeformObjects) {
    return null;
  }
}
