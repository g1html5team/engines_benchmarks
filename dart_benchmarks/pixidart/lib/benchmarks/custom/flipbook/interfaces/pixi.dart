import 'dart:async';


import 'package:pixi/pixi.dart';
import 'package:pixi_dart_benchmark/interfaces/pixi.dart';

import 'common.dart';

class PixiFlipbookInterface extends PixiInterface implements FlipbookInterface {
  PixiFlipbookInterface();

  Future<List> load({ng1n, stagexl, List<String> pixi}) async {
    List<Texture> textures = [];
    for (String data in pixi) {
      textures.add(Texture.fromImage(data));
    }
    return textures;
  }

  play(AnimatedSprite object, int currentFrame) {
    object.gotoAndStop(currentFrame);
  }

  AnimatedSprite createFlipbook(List<Texture> dataList) {
    return new AnimatedSprite(dataList);
  }
}
