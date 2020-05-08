import 'dart:async';
import 'dart:math';
import 'package:stagexl_benchmark/benchmarks/common.dart';
import 'package:stagexl_benchmark/benchmarks/custom/flipbook/interfaces/common.dart';

class FlipbookBenchmark implements BenchmarkBase {
  final int canvasWidth;
  final int canvasHeight;
  final FlipbookInterface interface;
  final layout;
  Random rdm = new Random();
  dynamic flipbook;



  List<String> files = [];

  FlipbookBenchmark(
      this.interface, this.layout, this.canvasWidth, this.canvasHeight) {
    for (int i = -1; ++i < 29;) {
      if (i < 10) {
        files.add('../assets/flipbook/v000$i.jpg');
      } else {
        files.add('../assets/flipbook/v00$i.jpg');
      }
    }
  }

  Future initialize() async {
    await interface.load(files);
    flipbook = interface.createFlipbook();
    interface.addChild(layout, flipbook);
  }

  int i = 0;

  eachFrameFunction([num v]) {
    if (i > 29) i = 0;
    interface.play(flipbook, i++);
  }
}
