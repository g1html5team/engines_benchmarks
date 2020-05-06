import 'dart:async';

import 'package:pixi_dart_benchmark/benchmarks/common.dart';
import 'package:pixi_dart_benchmark/interfaces/common.dart';

class IBenchmarkAtlasManager extends BenchmarkManager {
  IBenchmarkAtlasManager(Interface interface, int canvasWidth, int canvasHeight,
      EachFrameFunction frameRendering, layout)
      : super(interface, canvasWidth, canvasHeight, frameRendering, layout);

  Future<Map> runAtlasImagesNoAtlasWithAddChildBenchmark(int objects) {
    return null;
  }

  Future<Map> runAtlasImagesNoAtlasWithOneBitmapBenchmark(int objects) {
    return null;
  }

  Future<Map> runAtlasImagesNoAtlasWith100BitmapBenchmark(int objects) {
    return null;
  }

  Future<Map> runAtlasImagesInAtlasWithAddChildBenchmark(int objects) {
    return null;
  }

  Future<Map> runAtlasImagesInAtlasWithOneBitmapBenchmark(int objects) {
    return null;
  }

  Future<Map> runAtlasImagesInAtlasWith100BitmapBenchmark(int objects) {
    return null;
  }

  Future<Map> runAtlasImagesFrom2DifferentAtlasWithAddChildBenchmark(
      int objects) {
    return null;
  }

  Future<Map> runAtlasImagesFrom2DifferentAtlasWithOneBitmapBenchmark(
      int objects) {
    return null;
  }

  Future<Map> runAtlasImagesFrom2DifferentAtlasWith100BitmapBenchmark(
      int objects) {
    return null;
  }

  Future<Map> runAtlasImagesFrom3DifferentAtlasWithAddChildBenchmark(
      int objects) {
    return null;
  }

  Future<Map> runAtlasImagesFrom3DifferentAtlasWithOneBitmapBenchmark(
      int objects) {
    return null;
  }

  Future<Map> runAtlasImagesFrom3DifferentAtlasWith100BitmapBenchmark(
      int objects) {
    return null;
  }
}
