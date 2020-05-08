

import 'package:stagexl/stagexl.dart';
import 'package:stagexl_benchmark/interfaces/stagexl.dart';

import 'common.dart';

class StagexlShaderInterface extends StagexlInterface
    implements ShaderInterface {
  StagexlShaderInterface();

  setShader(Bitmap object, ShaderType shaderType,
      {Bitmap optionnalObject}) //List<BitmapFilter> value
  {
    switch (shaderType) {
      case ShaderType.blur:
        object.filters = [new BlurFilter()];
        break;
      case ShaderType.displacement:
        object.filters = [
          new DisplacementMapFilter(optionnalObject.bitmapData)
        ];
        break;
      case ShaderType.glow:
        object.filters = [new GlowFilter(Color.Red, 20, 20, 1, false, false)];
        break;
    }
  }
}
