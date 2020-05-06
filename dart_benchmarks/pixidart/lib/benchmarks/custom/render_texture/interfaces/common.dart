import 'dart:html';
import 'dart:math';

import 'package:pixi_dart_benchmark/interfaces/common.dart';

abstract class RenderTextureInterface extends Interface {
  create(num width, num height);
  draw(covariant renderTexture, covariant bitmapData);
  drawPixels(covariant renderTexture, covariant bitmapData, Point point);
  clear(covariant renderTexture);
  release(covariant renderTexture);
  createBitmap(covariant renderTexture);
}
