import 'dart:convert';
import 'dart:html';
import 'package:pixi_dart_benchmark/benchmarks/common.dart';
import 'package:pixi_dart_benchmark/benchmarks/custom/spines/engines/common.dart';
import 'package:pixi_dart_benchmark/benchmarks/custom/spines/engines/pixi.dart';

main() async {
  Map<String, String> params = Uri.base.queryParameters;
  if (params == null || params.isEmpty) {
    params = new Map();
    params['engine'] = 'pixi';
    params['nbObj'] = '20';
    params['nbDeformObj'] = '10';
    params['cw'] = '1280';
    params['ch'] = '720';
  }

  GraphicEngineBenchmark benchmark = _getEngine(params, document.body);
  IBenchmarkSpinesManager manager = benchmark.manager;
  Map result;

  assert(params['nbObj'] != null);
  assert(params['nbDeformObj'] != null);

  result = await manager.runSpinesBenchmark(
      int.parse(params['nbObj']), int.parse(params['nbDeformObj']));

  window.parent.postMessage(json.encode(result), params["target"]);
}

GraphicEngineBenchmark _getEngine(
    Map<String, String> parameters, Element container) {
  int canvasWidth = int.parse(parameters['cw']);
  int canvasHeight = int.parse(parameters['ch']);

    return new PixiBenchmarkSpines(container, canvasWidth, canvasHeight);

}
