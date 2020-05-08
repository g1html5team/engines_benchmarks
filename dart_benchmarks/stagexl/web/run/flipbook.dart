import 'dart:convert';
import 'dart:html';

import 'package:stagexl_benchmark/benchmarks/common.dart';
import 'package:stagexl_benchmark/benchmarks/custom/flipbook/engines/common.dart';
import 'package:stagexl_benchmark/benchmarks/custom/flipbook/engines/stagexl.dart';

/// IDS
/// no IDS used
main() async {
  Map<String, String> params = Uri.base.queryParameters;
  if (params == null || params.isEmpty) {
    params = new Map();
    params['engine'] = 'stagexl';
    params['cw'] = '1280';
    params['ch'] = '720';
  }

  GraphicEngineBenchmark benchmark = _getEngine(params, document.body);
  BenchmarkFlipbookManager manager = benchmark.manager;
  Map result;

  result = await manager.runFlipbookBenchmark();

  window.parent.postMessage(json.encode(result), params["target"]);
}

GraphicEngineBenchmark _getEngine(
    Map<String, String> parameters, Element container) {
  int canvasWidth = int.parse(parameters['cw']);
  int canvasHeight = int.parse(parameters['ch']);

    return new StagexlBenchmarkFlipbook(
        container, canvasWidth, canvasHeight, false);

}
