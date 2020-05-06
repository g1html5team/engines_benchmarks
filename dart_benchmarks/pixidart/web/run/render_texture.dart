import 'dart:convert';
import 'dart:html';
import 'package:pixi_dart_benchmark/benchmarks/common.dart';
import 'package:pixi_dart_benchmark/benchmarks/custom/render_texture/engines/common.dart';
import 'package:pixi_dart_benchmark/benchmarks/custom/render_texture/engines/pixi.dart';

main() async {
  Map<String, String> uriParams = Uri.base.queryParameters;

  Map<String, String> params = new Map();
  if (uriParams != null && !uriParams.isEmpty) {
    for (String key in uriParams.keys) {
      params[key] = uriParams[key];
    }
  }

  if (!params.containsKey('engine')) params['engine'] = 'pixi';
  if (!params.containsKey('cw')) params['cw'] = '1280';
  if (!params.containsKey('ch')) params['ch'] = '720';

  GraphicEngineBenchmark benchmark = _getEngine(params, document.body);
  BenchmarkRenderTextureManager manager = benchmark.manager;

  Map result = await manager.createTexture();
  window.parent.postMessage(json.encode(result), params["target"]);
}

GraphicEngineBenchmark _getEngine(
    Map<String, String> parameters, Element container) {
  int canvasWidth = int.parse(parameters['cw']);
  int canvasHeight = int.parse(parameters['ch']);

    return new PixiBenchmarkRenderTexture(container, canvasWidth, canvasHeight);

}
