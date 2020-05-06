import 'dart:convert';
import 'dart:html';

import 'package:pixi_dart_benchmark/benchmarks/common.dart';
import 'package:pixi_dart_benchmark/benchmarks/custom/filters/engines/common.dart';
import 'package:pixi_dart_benchmark/benchmarks/custom/filters/engines/pixi.dart';

/// IDS
/// 1 = Brightness
/// 2 = Hue
main() async {
  Map<String, String> params = Uri.base.queryParameters;
  if (params == null || params.isEmpty) {
    params = new Map();
    params['engine'] = 'pixi';
    params['nbObj'] = '150';
    params['id'] = '2';
    params['cw'] = '1280';
    params['ch'] = '720';
  }

  GraphicEngineBenchmark benchmark = _getEngine(params, document.body);
  BenchmarkFilterManager manager = benchmark.manager;
  Map result;

  if (params['id'] == '1') {
    result =
        await manager.runFilterBrightnessBenchmark(int.parse(params['nbObj']));
  } else if (params['id'] == '2') {
    result = await manager.runFilterHueBenchmark(int.parse(params['nbObj']));
  }

  window.parent.postMessage(json.encode(result), params["target"]);
}

GraphicEngineBenchmark _getEngine(
    Map<String, String> parameters, Element container) {
  int canvasWidth = int.parse(parameters['cw']);
  int canvasHeight = int.parse(parameters['ch']);

    return new PixiBenchmarkFilter(container, canvasWidth, canvasHeight);

}
