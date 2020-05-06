import 'dart:async';
import 'dart:html';

import 'package:pixi_dart_benchmark/benchmarks/common.dart';
import 'package:pixi_dart_benchmark/benchmarks/custom/atlasses/engines/common.dart';
import 'package:pixi_dart_benchmark/benchmarks/custom/atlasses/interfaces/pixi.dart';
import 'package:pixi_dart_benchmark/benchmarks/pixi/common.dart';
import 'package:pixi_dart_benchmark/interfaces/common.dart';
import 'package:pixi_dart_benchmark/interfaces/pixi.dart';
import 'package:pixi_dart_benchmark/runs/atlasses/pixi.dart';

class PixiBenchmarkAtlas extends PixiBenchmark {
  PixiInterface interface = new PixiAtlasInterface();
  PixiBenchmarkAtlas(Element container, int canvasWidth, int canvasHeight)
      : super(container, canvasWidth, canvasHeight) {
    manager = new PixiBenchmarkAtlasManager(
        interface, canvasWidth, canvasHeight, frameRendering, layout);
  }
}

class PixiBenchmarkAtlasManager extends IBenchmarkAtlasManager {
  PixiBenchmarkAtlasManager(Interface interface, int canvasWidth,
      int canvasHeight, EachFrameFunction frameRendering, layout)
      : super(interface, canvasWidth, canvasHeight, frameRendering, layout);

  Future<Map> runAtlasImagesNoAtlasWithAddChildBenchmark(int objects) async {
    PixiAtlasImagesNoAtlasWithAddChildBenchmark benchmark =
        new PixiAtlasImagesNoAtlasWithAddChildBenchmark(
            interface, objects, layout, canvasWidth, canvasHeight);
    await benchmark.init();
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }

  Future<Map> runAtlasImagesNoAtlasWithOneBitmapBenchmark(int objects) async {
    PixiAtlasImagesNoAtlasWithOneBitmapBenchmark benchmark =
        new PixiAtlasImagesNoAtlasWithOneBitmapBenchmark(
            interface, objects, layout, canvasWidth, canvasHeight);
    await benchmark.init();
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }

  Future<Map> runAtlasImagesNoAtlasWith100BitmapBenchmark(int objects) async {
    PixiAtlasImagesNoAtlasWith100BitmapBenchmark benchmark =
        new PixiAtlasImagesNoAtlasWith100BitmapBenchmark(
            interface, objects, layout, canvasWidth, canvasHeight);
    await benchmark.init();
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }

  Future<Map> runAtlasImagesInAtlasWithAddChildBenchmark(int objects) async {
    PixiAtlasImagesInAtlasWithAddChildBenchmark benchmark =
        new PixiAtlasImagesInAtlasWithAddChildBenchmark(
            interface, objects, layout, canvasWidth, canvasHeight);
    await benchmark.init();
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }

  Future<Map> runAtlasImagesInAtlasWithOneBitmapBenchmark(int objects) async {
    PixiAtlasImagesInAtlasWithOneBitmapBenchmark benchmark =
        new PixiAtlasImagesInAtlasWithOneBitmapBenchmark(
            interface, objects, layout, canvasWidth, canvasHeight);
    await benchmark.init();
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }

  Future<Map> runAtlasImagesInAtlasWith100BitmapBenchmark(int objects) async {
    PixiAtlasImagesInAtlasWith100BitmapBenchmark benchmark =
        new PixiAtlasImagesInAtlasWith100BitmapBenchmark(
            interface, objects, layout, canvasWidth, canvasHeight);
    await benchmark.init();
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }

  Future<Map> runAtlasImagesFrom2DifferentAtlasWithAddChildBenchmark(
      int objects) async {
    PixiAtlasImagesFrom2DifferentAtlasWithAddChildBenchmark benchmark =
        new PixiAtlasImagesFrom2DifferentAtlasWithAddChildBenchmark(
            interface, objects, layout, canvasWidth, canvasHeight);
    await benchmark.init();
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }

  Future<Map> runAtlasImagesFrom2DifferentAtlasWithOneBitmapBenchmark(
      int objects) async {
    PixiAtlasImagesFrom2DifferentAtlasWithOneBitmapBenchmark benchmark =
        new PixiAtlasImagesFrom2DifferentAtlasWithOneBitmapBenchmark(
            interface, objects, layout, canvasWidth, canvasHeight);
    await benchmark.init();
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }

  Future<Map> runAtlasImagesFrom2DifferentAtlasWith100BitmapBenchmark(
      int objects) async {
    PixiAtlasImagesFrom2DifferentAtlasWith100BitmapBenchmark benchmark =
        new PixiAtlasImagesFrom2DifferentAtlasWith100BitmapBenchmark(
            interface, objects, layout, canvasWidth, canvasHeight);
    await benchmark.init();
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }

  Future<Map> runAtlasImagesFrom3DifferentAtlasWithAddChildBenchmark(
      int objects) async {
    PixiAtlasImagesFrom3DifferentAtlasWithAddChildBenchmark benchmark =
        new PixiAtlasImagesFrom3DifferentAtlasWithAddChildBenchmark(
            interface, objects, layout, canvasWidth, canvasHeight);
    await benchmark.init();
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }

  Future<Map> runAtlasImagesFrom3DifferentAtlasWithOneBitmapBenchmark(
      int objects) async {
    PixiAtlasImagesFrom3DifferentAtlasWithOneBitmapBenchmark benchmark =
        new PixiAtlasImagesFrom3DifferentAtlasWithOneBitmapBenchmark(
            interface, objects, layout, canvasWidth, canvasHeight);
    await benchmark.init();
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }

  Future<Map> runAtlasImagesFrom3DifferentAtlasWith100BitmapBenchmark(
      int objects) async {
    PixiAtlasImagesFrom3DifferentAtlasWith100BitmapBenchmark benchmark =
        new PixiAtlasImagesFrom3DifferentAtlasWith100BitmapBenchmark(
            interface, objects, layout, canvasWidth, canvasHeight);
    await benchmark.init();
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }
}
