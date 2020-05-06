import 'dart:convert';
import 'dart:html';

import 'package:pixi_dart_benchmark/benchmarks/common.dart';
import 'package:pixi_dart_benchmark/benchmarks/custom/visibility/engines/common.dart';
import 'package:pixi_dart_benchmark/benchmarks/custom/visibility/engines/pixi.dart';

main() async {
  Map<String, String> params = Uri.base.queryParameters;
  if (params == null || params.isEmpty) {
    params = new Map();
    params['engine'] = 'pixi';
    params['nbObj'] = '150';
    params['id'] = '4';
    params['cw'] = '1280';
    params['ch'] = '720';
  }

  GraphicEngineBenchmark benchmark = _getEngine(params, document.body);
  BenchmarkVisibilityManager manager = benchmark.manager;
  Map result;

  assert(params['nbObj'] != null);

  if (params['id'] == '1') {
    result = await manager.runOutOfScene(int.parse(params['nbObj']));
  } else if (params['id'] == '2') {
    result = await manager.runVisibilityFalse(int.parse(params['nbObj']));
  } else if (params['id'] == '3') {
    result = await manager.runAlpha0(int.parse(params['nbObj']));
  } else if (params['id'] == '4') {
    result = await manager.runMoveOutside(int.parse(params['nbObj']));
  } else if (params['id'] == '5') {
    result = await manager.runScale0(int.parse(params['nbObj']));
  }

  window.parent.postMessage(json.encode(result), params["target"]);
}

GraphicEngineBenchmark _getEngine(
    Map<String, String> parameters, Element container) {
  int canvasWidth = int.parse(parameters['cw']);
  int canvasHeight = int.parse(parameters['ch']);

    return new PixiBenchmarkVisibility(container, canvasWidth, canvasHeight);

}
