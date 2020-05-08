

import 'package:stagexl/stagexl.dart';
import 'package:stagexl_benchmark/interfaces/stagexl.dart';

import 'common.dart';

class StagexlFilterInterface extends StagexlInterface
    implements FilterInterface {
  StagexlFilterInterface();

  setBrightness(DisplayObject object, num value) {
    object.filters = [new ColorMatrixFilter.adjust(brightness: value)];
  }

  setHue(DisplayObject object, num value) {
    object.filters = [new ColorMatrixFilter.adjust(hue: value)];
  }
}
