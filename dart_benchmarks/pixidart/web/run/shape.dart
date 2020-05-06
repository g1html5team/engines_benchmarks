import 'dart:convert';
import 'dart:html';
import 'package:pixi_dart_benchmark/benchmarks/common.dart';
import 'package:pixi_dart_benchmark/benchmarks/custom/shape/engines/common.dart';
import 'package:pixi_dart_benchmark/benchmarks/custom/shape/engines/pixi.dart';

main() async {
  Map<String, String> params = Uri.base.queryParameters;
  if (params == null || params.isEmpty) {
    params = new Map();
    params['engine'] = 'ng1n';
    params['nbObj'] = '150';
    params['id'] = '5';
    params['cw'] = '1280';
    params['ch'] = '720';
  }

  GraphicEngineBenchmark benchmark = _getEngine(params, document.body);
  BenchmarkShapeManager manager = benchmark.manager;
  Map result;

  assert(params['nbObj'] != null);

  if (params['id'] == '1') {
    result = await manager.runShapeRectBenchmark(int.parse(params['nbObj']));
  }
  if (params['id'] == '2') {
    result = await manager.runShapeBezierBenchmark(int.parse(params['nbObj']));
  }
  if (params['id'] == '3') {
    result =
        await manager.runShapeQuadraticBenchmark(int.parse(params['nbObj']));
  }
  if (params['id'] == '4') {
    result = await manager.runShapeLineBenchmark(int.parse(params['nbObj']));
  }
  if (params['id'] == '5') {
    result = await manager.runShapeArcBenchmark(int.parse(params['nbObj']));
  }

  window.parent.postMessage(json.encode(result), params["target"]);
}

GraphicEngineBenchmark _getEngine(
    Map<String, String> parameters, Element container) {
  int canvasWidth = int.parse(parameters['cw']);
  int canvasHeight = int.parse(parameters['ch']);

    return new PixiBenchmarkShape(container, canvasWidth, canvasHeight);

}
