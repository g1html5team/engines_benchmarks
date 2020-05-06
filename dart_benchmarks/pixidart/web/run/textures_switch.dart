import 'dart:convert';
import 'dart:html';

import 'package:pixi_dart_benchmark/benchmarks/common.dart';
import 'package:pixi_dart_benchmark/benchmarks/custom/texture_switch/engines/common.dart';
import 'package:pixi_dart_benchmark/benchmarks/custom/texture_switch/engines/pixi.dart';

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
  IBenchmarkTextureSwitchManager manager = benchmark.manager;
  Map result;

  assert(params['nbObj'] != null);

  result = await manager.runTextureSwitchBenchmark(int.parse(params['nbObj']));

  window.parent.postMessage(json.encode(result), params["target"]);
}

GraphicEngineBenchmark _getEngine(
    Map<String, String> parameters, Element container) {
  int canvasWidth = int.parse(parameters['cw']);
  int canvasHeight = int.parse(parameters['ch']);

    return new PixiBenchmarkTextureSwitch(container, canvasWidth, canvasHeight);

}
