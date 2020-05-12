import 'dart:convert';
import 'dart:html';
import 'package:stagexl_benchmark/benchmarks/common.dart';
import 'package:stagexl_benchmark/benchmarks/custom/atlasses/engines/common.dart';
import 'package:stagexl_benchmark/benchmarks/custom/atlasses/engines/stagexl.dart';

/// IDS
/// 1 = Images not in an atlas (with add child)
/// 2 = Images not in an atlas (one bitmap already added to stage)
/// 3 = Images not in an atlas (100 bitmap already added to stage)
/// 4 = Images in an atlas (with add child)
/// 5 = Images in an atlas (one bitmap already added to stage)
/// 6 = Images in an atlas (100 bitmap already added to stage)
/// 7 = Images in 2 different atlas (with add child)
/// 8 = Images in 2 different atlas (one bitmap already added to stage)
/// 9 = Images in 2 different atlas (100 bitmap already added to stage)
/// 10 = Images in 3 different atlas (with add child)
/// 11 = Images in 3 different atlas (one bitmap already added to stage)
/// 12 = Images in 3 different atlas (100 bitmap already added to stage)
main() async {
  Map<String, String> params = Uri.base.queryParameters;
  if (params == null || params.isEmpty) {
    params = new Map();
    params['engine'] = 'pixi';
    params['nbObj'] = '1';
    params['id'] = '12';
    params['cw'] = '1280';
    params['ch'] = '720';
  }

  GraphicEngineBenchmark benchmark = _getEngine(params, document.body);
  IBenchmarkAtlasManager manager = benchmark.manager;
  Map result;

  assert(params['nbObj'] != null);

  if (params['id'] == '1') {
    result = await manager
        .runAtlasImagesNoAtlasWithAddChildBenchmark(int.parse(params['nbObj']));
  } else if (params['id'] == '2') {
    result = await manager.runAtlasImagesNoAtlasWithOneBitmapBenchmark(
        int.parse(params['nbObj']));
  } else if (params['id'] == '3') {
    result = await manager.runAtlasImagesNoAtlasWith100BitmapBenchmark(
        int.parse(params['nbObj']));
  } else if (params['id'] == '4') {
    result = await manager
        .runAtlasImagesInAtlasWithAddChildBenchmark(int.parse(params['nbObj']));
  } else if (params['id'] == '5') {
    result = await manager.runAtlasImagesInAtlasWithOneBitmapBenchmark(
        int.parse(params['nbObj']));
  } else if (params['id'] == '6') {
    result = await manager.runAtlasImagesInAtlasWith100BitmapBenchmark(
        int.parse(params['nbObj']));
  } else if (params['id'] == '7') {
    result =
        await manager.runAtlasImagesFrom2DifferentAtlasWithAddChildBenchmark(
            int.parse(params['nbObj']));
  } else if (params['id'] == '8') {
    result =
        await manager.runAtlasImagesFrom2DifferentAtlasWithOneBitmapBenchmark(
            int.parse(params['nbObj']));
  } else if (params['id'] == '9') {
    result =
        await manager.runAtlasImagesFrom2DifferentAtlasWith100BitmapBenchmark(
            int.parse(params['nbObj']));
  } else if (params['id'] == '10') {
    result =
        await manager.runAtlasImagesFrom3DifferentAtlasWithAddChildBenchmark(
            int.parse(params['nbObj']));
  } else if (params['id'] == '11') {
    result =
        await manager.runAtlasImagesFrom3DifferentAtlasWithOneBitmapBenchmark(
            int.parse(params['nbObj']));
  } else if (params['id'] == '12') {
    result =
        await manager.runAtlasImagesFrom3DifferentAtlasWith100BitmapBenchmark(
            int.parse(params['nbObj']));
  }

  window.parent.postMessage(json.encode(result), params["target"]);
}

GraphicEngineBenchmark _getEngine(
    Map<String, String> parameters, Element container) {
  int canvasWidth = int.parse(parameters['cw']);
  int canvasHeight = int.parse(parameters['ch']);

    return new StagexlBenchmarkAtlas(
        container, canvasWidth, canvasHeight, false);

}
