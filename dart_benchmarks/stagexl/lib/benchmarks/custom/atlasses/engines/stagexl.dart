import 'dart:async';
import 'dart:html';

import 'package:stagexl_benchmark/benchmarks/common.dart';
import 'package:stagexl_benchmark/benchmarks/custom/atlasses/interfaces/stagexl.dart';
import 'package:stagexl_benchmark/benchmarks/stagexl/common.dart';
import 'package:stagexl_benchmark/interfaces/common.dart';
import 'package:stagexl_benchmark/interfaces/stagexl.dart';
import 'package:stagexl_benchmark/runs/atlasses/stagexl.dart';

import 'common.dart';

class StagexlBenchmarkAtlas extends StageXlBenchmark {
  StagexlInterface interface = new StagexlAtlasInterface();
  StagexlBenchmarkAtlas(
      Element container, int canvasWidth, int canvasHeight, bool useWebGL)
      : super(container, canvasWidth, canvasHeight) {
    manager = new StagexlBenchmarkAtlasManager(
        interface, canvasWidth, canvasHeight, frameRendering, layout);
  }
}

class StagexlBenchmarkAtlasManager extends IBenchmarkAtlasManager {
  StagexlBenchmarkAtlasManager(Interface interface, int canvasWidth,
      int canvasHeight, EachFrameFunction frameRendering, layout)
      : super(interface, canvasWidth, canvasHeight, frameRendering, layout);
  Future<Map> runAtlasImagesNoAtlasWithAddChildBenchmark(int objects) async {
    StagexlAtlasImagesNoAtlasWithAddChildBenchmark benchmark =
        new StagexlAtlasImagesNoAtlasWithAddChildBenchmark(
            interface, objects, layout, canvasWidth, canvasHeight);
    await benchmark.init();
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }

  Future<Map> runAtlasImagesNoAtlasWithOneBitmapBenchmark(int objects) async {
    StagexlAtlasImagesNoAtlasWithOneBitmapBenchmark benchmark =
        new StagexlAtlasImagesNoAtlasWithOneBitmapBenchmark(
            interface, objects, layout, canvasWidth, canvasHeight);
    await benchmark.init();
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }

  Future<Map> runAtlasImagesNoAtlasWith100BitmapBenchmark(int objects) async {
    StagexlAtlasImagesNoAtlasWith100BitmapBenchmark benchmark =
        new StagexlAtlasImagesNoAtlasWith100BitmapBenchmark(
            interface, objects, layout, canvasWidth, canvasHeight);
    await benchmark.init();
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }

  Future<Map> runAtlasImagesInAtlasWithAddChildBenchmark(int objects) async {
    StagexlAtlasImagesInAtlasWithAddChildBenchmark benchmark =
        new StagexlAtlasImagesInAtlasWithAddChildBenchmark(
            interface, objects, layout, canvasWidth, canvasHeight);
    await benchmark.init();
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }

  Future<Map> runAtlasImagesInAtlasWithOneBitmapBenchmark(int objects) async {
    StagexlAtlasImagesInAtlasWithOneBitmapBenchmark benchmark =
        new StagexlAtlasImagesInAtlasWithOneBitmapBenchmark(
            interface, objects, layout, canvasWidth, canvasHeight);
    await benchmark.init();
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }

  Future<Map> runAtlasImagesInAtlasWith100BitmapBenchmark(int objects) async {
    StagexlAtlasImagesInAtlasWith100BitmapBenchmark benchmark =
        new StagexlAtlasImagesInAtlasWith100BitmapBenchmark(
            interface, objects, layout, canvasWidth, canvasHeight);
    await benchmark.init();
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }

  Future<Map> runAtlasImagesFrom2DifferentAtlasWithAddChildBenchmark(
      int objects) async {
    StagexlAtlasImagesFrom2DifferentAtlasWithAddChildBenchmark benchmark =
        new StagexlAtlasImagesFrom2DifferentAtlasWithAddChildBenchmark(
            interface, objects, layout, canvasWidth, canvasHeight);
    await benchmark.init();
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }

  Future<Map> runAtlasImagesFrom2DifferentAtlasWithOneBitmapBenchmark(
      int objects) async {
    StagexlAtlasImagesFrom2DifferentAtlasWithOneBitmapBenchmark benchmark =
        new StagexlAtlasImagesFrom2DifferentAtlasWithOneBitmapBenchmark(
            interface, objects, layout, canvasWidth, canvasHeight);
    await benchmark.init();
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }

  Future<Map> runAtlasImagesFrom2DifferentAtlasWith100BitmapBenchmark(
      int objects) async {
    StagexlAtlasImagesFrom2DifferentAtlasWith100BitmapBenchmark benchmark =
        new StagexlAtlasImagesFrom2DifferentAtlasWith100BitmapBenchmark(
            interface, objects, layout, canvasWidth, canvasHeight);
    await benchmark.init();
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }

  Future<Map> runAtlasImagesFrom3DifferentAtlasWithAddChildBenchmark(
      int objects) async {
    StagexlAtlasImagesFrom3DifferentAtlasWithAddChildBenchmark benchmark =
        new StagexlAtlasImagesFrom3DifferentAtlasWithAddChildBenchmark(
            interface, objects, layout, canvasWidth, canvasHeight);
    await benchmark.init();
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }

  Future<Map> runAtlasImagesFrom3DifferentAtlasWithOneBitmapBenchmark(
      int objects) async {
    StagexlAtlasImagesFrom3DifferentAtlasWithOneBitmapBenchmark benchmark =
        new StagexlAtlasImagesFrom3DifferentAtlasWithOneBitmapBenchmark(
            interface, objects, layout, canvasWidth, canvasHeight);
    await benchmark.init();
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }

  Future<Map> runAtlasImagesFrom3DifferentAtlasWith100BitmapBenchmark(
      int objects) async {
    StagexlAtlasImagesFrom3DifferentAtlasWith100BitmapBenchmark benchmark =
        new StagexlAtlasImagesFrom3DifferentAtlasWith100BitmapBenchmark(
            interface, objects, layout, canvasWidth, canvasHeight);
    await benchmark.init();
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }
}
