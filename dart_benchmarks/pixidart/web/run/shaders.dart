import 'dart:convert';
import 'dart:html';

import 'package:pixi_dart_benchmark/benchmarks/common.dart';
import 'package:pixi_dart_benchmark/benchmarks/shader/engines/common.dart';
import 'package:pixi_dart_benchmark/benchmarks/shader/engines/pixi.dart';
import 'package:pixi_dart_benchmark/benchmarks/shader/interfaces/common.dart';

/// IDS
/// 1 = Brightness
/// 2 = Hue
main() async {
  Map<String, String> params = Uri.base.queryParameters;
  if (params == null || params.isEmpty) {
    params = new Map();
//    params['engine'] = 'stagexl';
//    params['engine'] = 'ng1n';
    params['engine'] = 'pixi';
    params['nbObj'] = '20';
    params['cw'] = '1280';
    params['ch'] = '720';
    params['id'] = '2';
  }

  GraphicEngineBenchmark benchmark = _getEngine(params, document.body);
  BenchmarkShaderManager manager = benchmark.manager;
  Map result;

  assert(params['nbObj'] != null);

  if (params['id'] == '1') {
    result = await manager.runShaderByTypeBenchmark(
        int.parse(params['nbObj']), ShaderType.blur);
  } else if (params['id'] == '2') {
    result = await manager.runShaderByTypeBenchmark(
        int.parse(params['nbObj']), ShaderType.glow);
  } else if (params['id'] == '3') {
    result = await manager.runShaderByTypeBenchmark(
        int.parse(params['nbObj']), ShaderType.displacement);
  } else if (params['id'] == '4') {
    result =
        await manager.runShaderStepByStepBenchmark(int.parse(params['nbObj']));
  } else if (params['id'] == '5') {
    result = await manager
        .runShaderAllTypeAtOnceBenchmark(int.parse(params['nbObj']));
  }
  window.parent.postMessage(json.encode(result), params["target"]);
}

GraphicEngineBenchmark _getEngine(
    Map<String, String> parameters, Element container) {
  int canvasWidth = int.parse(parameters['cw']);
  int canvasHeight = int.parse(parameters['ch']);

    return new PixiBenchmarkShader(container, canvasWidth, canvasHeight);

}
