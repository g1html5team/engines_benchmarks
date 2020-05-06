

import 'package:pixi/pixi.dart';
import 'package:pixi_dart_benchmark/interfaces/pixi.dart';

import 'common.dart';

class PixiAtlasInterface extends PixiInterface implements AtlasInterface {
  PixiAtlasInterface();

  @override
  removeChildren(Container container) {
    container.removeChildren();
  }

  @override
  setBitmapData(Sprite bitmap, Texture data) {
    bitmap.texture = data;
  }
}
