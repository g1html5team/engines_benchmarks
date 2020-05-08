
import 'package:stagexl/stagexl.dart';
import 'package:stagexl_benchmark/interfaces/stagexl.dart';
import 'dart:web_gl' as gl;

import 'common.dart';

class StagexlBlendModeInterface extends StagexlInterface
    implements BlendModeInterface {
  StagexlBlendModeInterface();

  @override
  setBlendMode(DisplayObject object, BlendModeType blendMode) {
    object.blendMode = getBaseBlendMode(blendMode);
  }

//  static const BlendMode OVERLAY =
//  const BlendMode._(gl.DST_COLOR, gl.ONE, "lighter", 'overlay');
  @override
  getBaseBlendMode(BlendModeType blendMode) {
    BlendMode baseBlendMode;
    switch (blendMode) {
      case BlendModeType.normal:
        baseBlendMode = BlendMode.NORMAL;
        break;
      case BlendModeType.add:
        baseBlendMode = BlendMode.ADD;
        break;
      case BlendModeType.multiply:
        baseBlendMode = BlendMode.MULTIPLY;
        break;
      case BlendModeType.overlay:
        baseBlendMode = BlendMode(gl.WebGL.DST_COLOR, gl.WebGL.ONE, "lighter");
        break;
      case BlendModeType.screen:
        baseBlendMode = BlendMode.SCREEN;
        break;
    }

    return baseBlendMode;
  }
}

