import 'dart:async';

import 'package:pixi_dart_benchmark/benchmarks/common.dart';
import 'package:pixi_dart_benchmark/interfaces/common.dart';
import 'package:pixi_dart_benchmark/runs/shape/arc.dart';
import 'package:pixi_dart_benchmark/runs/shape/bezier.dart';
import 'package:pixi_dart_benchmark/runs/shape/line.dart';
import 'package:pixi_dart_benchmark/runs/shape/quadratic.dart';
import 'package:pixi_dart_benchmark/runs/shape/rect.dart';

class BenchmarkShapeManager extends BenchmarkManager {
  BenchmarkShapeManager(Interface interface, int canvasWidth, int canvasHeight,
      EachFrameFunction frameRendering, layout)
      : super(interface, canvasWidth, canvasHeight, frameRendering, layout);

  Future<Map> runShapeRectBenchmark(int objects) async {
    ShapeRectBenchmark benchmark = new ShapeRectBenchmark(
        interface, objects, layout, canvasWidth, canvasHeight);
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }

  Future<Map> runShapeBezierBenchmark(int objects) async {
    ShapeBezierBenchmark benchmark = new ShapeBezierBenchmark(
        interface, objects, layout, canvasWidth, canvasHeight);
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }

  Future<Map> runShapeQuadraticBenchmark(int objects) async {
    ShapeQuadraticBenchmark benchmark = new ShapeQuadraticBenchmark(
        interface, objects, layout, canvasWidth, canvasHeight);
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }

  Future<Map> runShapeLineBenchmark(int objects) async {
    ShapeLineBenchmark benchmark = new ShapeLineBenchmark(
        interface, objects, layout, canvasWidth, canvasHeight);
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }

  Future<Map> runShapeArcBenchmark(int objects) async {
    ShapeArcBenchmark benchmark = new ShapeArcBenchmark(
        interface, objects, layout, canvasWidth, canvasHeight);
    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
    BenchmarkResult result = await runner.run();
    return processResult(result);
  }
}
