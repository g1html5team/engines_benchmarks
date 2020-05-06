
import 'package:pixi_dart_benchmark/interfaces/common.dart';

abstract class ShaderInterface extends Interface {
  setShader(covariant object, ShaderType shaderType,
      {covariant optionnalObject});
}

enum ShaderType {
  blur,
  displacement,
  glow,
}
