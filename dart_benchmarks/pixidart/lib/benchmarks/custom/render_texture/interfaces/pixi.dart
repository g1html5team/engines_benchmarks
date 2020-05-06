import 'dart:math' as math;
import 'package:pixi/pixi.dart';
import 'package:pixi_dart_benchmark/interfaces/pixi.dart';

import 'common.dart';

class ScaleModes {
  static const int basic = 0;
  static const int linear = 0;
  static const int nearest = 1;
}

class PixiRenderTextureInterface extends PixiInterface
    implements RenderTextureInterface {
  final Application app;

  PixiRenderTextureInterface(this.app) : super();

  @override
  create(num width, num height) {
    return RenderTexture.create(width, height);
  }

  @override
  release(covariant renderTexture) {}

  @override
  clear(covariant renderTexture) {}

  @override
  drawPixels(covariant renderTexture, covariant bitmapData, math.Point point) {
    Sprite sprite = createBitmap(bitmapData);
    sprite.position.x = point.x;
    sprite.position.y = point.y;

    (app.renderer as WebGLRenderer).render(sprite, renderTexture, false);
  }

  @override
  draw(covariant renderTexture, covariant bitmapData) {
    drawPixels(renderTexture, bitmapData, new math.Point(0, 0));
  }
}
