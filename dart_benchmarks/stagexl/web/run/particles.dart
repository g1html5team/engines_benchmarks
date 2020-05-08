import 'dart:convert';
import 'dart:html';

import 'package:stagexl_benchmark/benchmarks/common.dart';
import 'package:stagexl_benchmark/benchmarks/custom/particles/engines/common.dart';
import 'package:stagexl_benchmark/benchmarks/custom/particles/engines/stagexl.dart';

/// IDS
/// 1 = Brightness
/// 2 = Hue
main() async {
  Map<String, String> params = Uri.base.queryParameters;
  if (params == null || params.isEmpty) {
    params = new Map();
    params['engine'] = 'pixi'; //ng1n stagexl pixi
    params['nbObj'] = '20';
    params['id'] = '2';
    params['cw'] = '1280';
    params['ch'] = '720';
  }

  GraphicEngineBenchmark benchmark = _getEngine(params, document.body);
  BenchmarkParticlesManager manager = benchmark.manager;
  Map result;

  assert(params['nbObj'] != null);

  if (params['id'] == '1') {
    result = await manager.runParticles1Benchmark(int.parse(params['nbObj']));
  } else if (params['id'] == '2') {
    result = await manager.runParticles2Benchmark(int.parse(params['nbObj']));
  }

  window.parent.postMessage(json.encode(result), params["target"]);
}

GraphicEngineBenchmark _getEngine(
    Map<String, String> parameters, Element container) {
  int canvasWidth = int.parse(parameters['cw']);
  int canvasHeight = int.parse(parameters['ch']);

    return new StagexlBenchmarkParticles(
        container, canvasWidth, canvasHeight, false);
}
