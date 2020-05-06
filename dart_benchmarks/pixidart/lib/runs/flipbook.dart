import 'dart:async';
import 'dart:math';

import 'package:pixi_dart_benchmark/benchmarks/common.dart';
import 'package:pixi_dart_benchmark/benchmarks/custom/flipbook/interfaces/common.dart';
class FlipbookBenchmark implements BenchmarkBase {
  final int canvasWidth;
  final int canvasHeight;
  final FlipbookInterface interface;
  final layout;
  Random rdm = new Random();
  dynamic flipbook;

  List<String> _pixi = [];

  FlipbookBenchmark(
      this.interface, this.layout, this.canvasWidth, this.canvasHeight) {
    for (int i = -1; ++i < 29;) {
      if (i < 10) {
        _pixi.add('../assets/flipbook/v000$i.jpg');
      } else {
        _pixi.add('../assets/flipbook/v00$i.jpg');
      }
    }
  }

  Future initialize() async {
    List datas = await interface.load(
        pixi: _pixi);
    flipbook = interface.createFlipbook(datas);
    interface.addChild(layout, flipbook);
  }

  int i = 0;

  eachFrameFunction([num v]) {
    if (i > 29) i = 0;
    interface.play(flipbook, i++);
  }
}
