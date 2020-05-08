import 'dart:math' as math;

import 'package:stagexl/stagexl.dart';
import 'package:stagexl_benchmark/interfaces/stagexl.dart';

import 'common.dart';

class StagexlRenderTextureInterface extends StagexlInterface
    implements RenderTextureInterface {
  StagexlRenderTextureInterface();

  @override
  create(num width, num height) {
    return new BitmapData(width, height, 0x00000000);
  }

  @override
  release(covariant renderTexture) {}

  @override
  clear(covariant renderTexture) {
    (renderTexture as BitmapData).clear();
  }

  @override
  drawPixels(covariant renderTexture, covariant bitmapData, math.Point point) {
    BitmapData data = bitmapData as BitmapData;
    (renderTexture as BitmapData)
        .drawPixels(data, data.rectangle, new Point(point.x, point.y));
  }

  @override
  draw(covariant renderTexture, covariant bitmapData) {
    (renderTexture as BitmapData).draw(bitmapData);
  }
}
