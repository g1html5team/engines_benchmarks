import 'dart:html';
import 'dart:math';
import 'package:stagexl_benchmark/benchmarks/common.dart';
import 'package:stagexl_benchmark/benchmarks/custom/gpu_slots/interfaces/common.dart';

class GPUSlotsOverflowBenchmark implements BenchmarkBase {
  final int canvasWidth;
  final int canvasHeight;
  final GPUSlotsInterface interface;
  final layout;
  final int nbOfObjects;
  Random rdm = new Random();

  var container;
  List _bitmaps = [];
  int squareZone = 300;

  GPUSlotsOverflowBenchmark(this.interface, this.nbOfObjects, this.layout,
      this.canvasWidth, this.canvasHeight) {
    container = interface.createContainer();

    for (String imageName in getImageNames()) {
      var data = interface.createBitmapData(
          querySelector('#$imageName'), './images/$imageName.png');
      var bitmap = interface.createBitmap(data);
      interface.addChild(container, bitmap);
      interface.setX(bitmap, rdm.nextInt(canvasWidth));
      interface.setY(bitmap, rdm.nextInt(canvasHeight));
      interface.centerPivot(bitmap);
      _bitmaps.add(bitmap);
    }

    interface.addChild(layout, container);
  }

  eachFrameFunction([num v]) {
    for (var bitmap in _bitmaps) {
      interface.setX(bitmap, rdm.nextInt(canvasWidth));
      interface.setY(bitmap, rdm.nextInt(canvasHeight));
    }
  }

  static List<String> _imageNames;
  static List<String> getImageNames() {
    if (_imageNames == null) {
      _imageNames = <String>[];

      for (int i = 1; i <= 8; ++i) {
        for (int j = 1; j <= 3; ++j) {
          _imageNames.add('character_${i}_$j');
        }
      }
    }

    return _imageNames;
  }
}
