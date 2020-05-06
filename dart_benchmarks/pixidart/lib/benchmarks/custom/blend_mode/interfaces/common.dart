
import 'package:pixi_dart_benchmark/interfaces/common.dart';

abstract class BlendModeInterface extends Interface {
  setBlendMode(covariant object, BlendModeType blendMode);
  dynamic getBaseBlendMode(BlendModeType blendMode);
}

class BlendModeType {
  static const BlendModeType normal = const BlendModeType('normal');
  static const BlendModeType add = const BlendModeType('add');
  static const BlendModeType multiply = const BlendModeType('mutliply');
  static const BlendModeType overlay = const BlendModeType('overlay');
  static const BlendModeType screen = const BlendModeType('screen');

  static List<BlendModeType> get all => [
        BlendModeType.normal,
        BlendModeType.add,
        BlendModeType.multiply,
        BlendModeType.overlay,
        BlendModeType.screen,
      ];

  final String name;
  const BlendModeType(this.name);
}
