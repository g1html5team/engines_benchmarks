import 'dart:convert';
import 'dart:html';

import 'package:pixi_dart_benchmark/benchmarks/common.dart';
import 'package:pixi_dart_benchmark/benchmarks/custom/gpu_slots/engines/common.dart';
import 'package:pixi_dart_benchmark/benchmarks/custom/gpu_slots/engines/pixi.dart';
import 'package:pixi_dart_benchmark/runs/gpu_slots.dart';

/// IDS
/// 1 - GPUSlotsOverflow

main() async {
  Map<String, String> params = Uri.base.queryParameters;
  if (params == null || params.isEmpty) {
    params = new Map();
    params['engine'] = 'pixi';
    params['nbObj'] = '0';
    params['id'] = '1';
    params['cw'] = '1280';
    params['ch'] = '720';
  }

  GraphicEngineBenchmark benchmark = _getEngine(params, document.body);
  BenchmarkGPUSlotsManager manager = benchmark.manager;
  Map result;

  assert(params['nbObj'] != null);

  GPUSlotsOverflowBenchmark.getImageNames();

  //> Run tests

  if (params['id'] == '1') {
    result =
        await manager.runGPUSlotsOverflowBenchmark(int.parse(params['nbObj']));
  }
  window.parent.postMessage(json.encode(result), params["target"]);
}

GraphicEngineBenchmark _getEngine(
    Map<String, String> parameters, Element container) {
  int canvasWidth = int.parse(parameters['cw']);
  int canvasHeight = int.parse(parameters['ch']);

    return new PixiBenchmarkGPUSlots(container, canvasWidth, canvasHeight);

}
