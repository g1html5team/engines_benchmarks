import 'dart:convert';
import 'dart:html';

import 'package:pixi_dart_benchmark/benchmarks/common.dart';
import 'package:pixi_dart_benchmark/benchmarks/custom/add_remove_child/engines/common.dart';
import 'package:pixi_dart_benchmark/benchmarks/custom/add_remove_child/engines/pixi.dart';

/// IDS
/// 1 = Add bitmap
/// 2 = Add & Remove Bitmap
/// 3 = Add & Remove SpriteContainer & Bitmap
main() async {
  Map<String, String> params = Uri.base.queryParameters;


  if (params == null || params.isEmpty) {
    params = new Map();
    params['engine'] = 'Pixi_Dart_2';
    params['nbObj'] = '300';
    params['id'] = '1';
    params['cw'] = '1280';
    params['ch'] = '720';
    params['target'] = Uri.base.toString();
  }


  GraphicEngineBenchmark benchmark = _getEngine(params, document.body);
  BenchmarkAddRemoveManager manager = benchmark.manager;
  Map result;

  assert(params['nbObj'] != null);
  if (params['id'] == '1') {
    result = await manager.runSimpleAddBenchmark(int.parse(params['nbObj']));
  } else if (params['id'] == '2') {
    result =
        await manager.runSimpleAddRemoveBenchmark(int.parse(params['nbObj']));
  } else if (params['id'] == '3') {
    result = await manager
        .runAddRemoveContainerBenchmark(int.parse(params['nbObj']));
  }
  window.parent.postMessage(json.encode(result), params["target"]);
}

GraphicEngineBenchmark _getEngine(
    Map<String, String> parameters, Element container) {
  int canvasWidth = int.parse(parameters['cw']);
  int canvasHeight = int.parse(parameters['ch']);

  return new PixiBenchmarkAddRemove(container, canvasWidth, canvasHeight);

}
