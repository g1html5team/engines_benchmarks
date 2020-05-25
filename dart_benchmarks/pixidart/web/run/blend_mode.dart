import 'dart:convert';
import 'dart:html';
import 'package:pixi_dart_benchmark/benchmarks/common.dart';
import 'package:pixi_dart_benchmark/benchmarks/custom/blend_mode/engines/common.dart';
import 'package:pixi_dart_benchmark/benchmarks/custom/blend_mode/engines/pixi.dart';

/// IDS
List<int> ids = [
  1,

  ///- normal
  2,

  ///- add
  3,

  ///- multiply
  4,

  ///- overlay
  5,

  ///- screen
  6,

  ///- BlendModeRandom
];

main() async {
  Map<String, String> params = Uri.base.queryParameters;
  if (params == null || params.isEmpty) {
    params = new Map();
    params['engine'] = 'stagexl';
    params['nbObj'] = '300';
    params['id'] = '2';
    params['cw'] = '1280';
    params['ch'] = '720';
  }

  GraphicEngineBenchmark benchmark = _getEngine(params, document.body);
  BenchmarkBlendModeManager manager = benchmark.manager;
  Map result;

  assert(params['nbObj'] != null);

  if (params['id'] == '1') {
    result =
        await manager.runBlendModeNormalBenchmark(int.parse(params['nbObj']));
  } else if (params['id'] == '2') {
    result = await manager.runBlendModeAddBenchmark(int.parse(params['nbObj']));
  } else if (params['id'] == '3') {
    result =
        await manager.runBlendModeMultiplyBenchmark(int.parse(params['nbObj']));
  } else if (params['id'] == '4') {
    result =
        await manager.runBlendModeOverlayBenchmark(int.parse(params['nbObj']));
  } else if (params['id'] == '5') {
    result =
        await manager.runBlendModeScreenBenchmark(int.parse(params['nbObj']));
  } else if (params['id'] == '6') {
    result =
        await manager.runBlendModeRandomBenchmark(int.parse(params['nbObj']));
  }

  window.parent.postMessage(json.encode(result), params["target"]);
}

GraphicEngineBenchmark _getEngine(
    Map<String, String> parameters, Element container) {
  int canvasWidth = int.parse(parameters['cw']);
  int canvasHeight = int.parse(parameters['ch']);

    return new PixiBenchmarkBlendMode(container, canvasWidth, canvasHeight);

}
