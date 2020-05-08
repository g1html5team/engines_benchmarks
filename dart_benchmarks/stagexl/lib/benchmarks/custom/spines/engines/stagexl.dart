import 'dart:async';
import 'dart:html';

import 'package:stagexl/stagexl.dart';
import 'package:stagexl_benchmark/benchmarks/custom/spines/interfaces/stagexl.dart';
import 'package:stagexl_benchmark/benchmarks/stagexl/common.dart';
import 'package:stagexl_benchmark/interfaces/common.dart';
import 'package:stagexl_benchmark/interfaces/stagexl.dart';
import 'package:stagexl_benchmark/runs/spines/stagexl.dart';

import '../../../common.dart';
import 'common.dart';

class StagexlBenchmarkSpines extends StageXlBenchmark {
  StagexlInterface interface = new StagexlSpinesInterface();
  StagexlBenchmarkSpines(
      Element container, int canvasWidth, int canvasHeight, bool useWebGL)
      : super(container, canvasWidth, canvasHeight, useWebGL) {
    manager = new StagexlBenchmarkSpinesManager(
        interface, canvasWidth, canvasHeight, frameRendering, layout, app);
  }
}

class StagexlBenchmarkSpinesManager extends IBenchmarkSpinesManager {
  StagexlBenchmarkSpinesManager(Interface interface, int canvasWidth,
      int canvasHeight, EachFrameFunction frameRendering, layout, this.juggler)
      : super(interface, canvasWidth, canvasHeight, frameRendering, layout);

  Stage juggler;

  Future<Map> runSpinesBenchmark(int objects, int nbDeform) async {
    StagexlSpinesBenchmark benchmark = new StagexlSpinesBenchmark(
        interface, objects, nbDeform, layout, canvasWidth, canvasHeight, juggler);
    await benchmark.init();
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }
}
