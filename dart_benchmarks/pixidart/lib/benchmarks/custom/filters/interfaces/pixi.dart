import 'package:pixi/pixi.dart';
import 'package:pixi_dart_benchmark/interfaces/pixi.dart';

import 'common.dart';

class PixiFilterInterface extends PixiInterface implements FilterInterface {
  PixiFilterInterface() : super();

  setBrightness(DisplayObject object, num value) {


    ColorMatrixFilter f = new ColorMatrixFilter();
    f.brightness(value, false);

    object.filters = [f];

  }

  setHue(DisplayObject object, num value) {
    object.filters = [new ColorMatrixFilter()..hue(value * 360, false)];
  }
}
