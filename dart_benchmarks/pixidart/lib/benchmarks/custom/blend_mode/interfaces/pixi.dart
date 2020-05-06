
import 'package:pixi/pixi.dart';
import 'package:pixi_dart_benchmark/interfaces/pixi.dart';

import 'common.dart';

class PixiBlendModeInterface extends PixiInterface
    implements BlendModeInterface {
  PixiBlendModeInterface();

  @override
  setBlendMode(Sprite object, BlendModeType blendMode) {
    object.blendMode = getBaseBlendMode(blendMode);
  }

  ///http://pixijs.download/dev/docs/PIXI.html#.BLEND_MODES
  @override
  getBaseBlendMode(BlendModeType blendMode) {
    int baseBlendMode;

    switch (blendMode) {
      case BlendModeType.normal:
        baseBlendMode = BlendModes.normal;
        break;
      case BlendModeType.add:
        baseBlendMode = BlendModes.add;
        break;
      case BlendModeType.multiply:
        baseBlendMode = BlendModes.multiply;
        break;
      case BlendModeType.overlay:
        baseBlendMode = BlendModes.overlay;
        break;
      case BlendModeType.screen:
        baseBlendMode = BlendModes.screen;
        break;
    }

    return baseBlendMode;
  }
}

//from pixi dart package : https://github.com/emergent-design/pixi.dart/blob/23ad50491020c5c1fcdb29e8f00795ef1683040f/lib/src/core/Const.dart
class BlendModes {
  static const int normal = 0;
  static const int add = 1;
  static const int multiply = 2;
  static const int screen = 3;
  static const int overlay = 4;
  static const int darken = 5;
  static const int lighten = 6;
  static const int colorDodge = 7;
  static const int colorBurn = 8;
  static const int hardLight = 9;
  static const int softLight = 10;
  static const int difference = 11;
  static const int exclusion = 12;
  static const int hue = 13;
  static const int saturation = 14;
  static const int color = 15;
  static const int luminosity = 16;
}
