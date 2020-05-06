import 'dart:html' hide Point;
import 'package:pixi/pixi.dart';

import 'common.dart';

class PixiInterface implements Interface {
  PixiInterface();

  addChild(Container container, DisplayObject child) {
    container.addChild(child);
  }

  removeChild(Container container, DisplayObject child) {
    container.removeChild(child);
  }

  addChildAt(Container container, DisplayObject child, int index) {
    container.addChildAt(child, index);
  }

  num getAlpha(DisplayObject object) {
    return object.alpha;
  }

  num getRotation(DisplayObject object) {
    return object.rotation;
  }

  num getX(DisplayObject object) {
    return object.x;
  }

  num getY(DisplayObject object) {
    return object.y;
  }

  num getScaleX(DisplayObject object) {
    return object.scale.x;
  }

  num getScaleY(DisplayObject object) {
    return object.scale.y;
  }

  setX(DisplayObject object, num value) {
    object.x = value;
  }

  setY(DisplayObject object, num value) {
    object.y = value;
  }

  setRotation(DisplayObject object, num degrees) {
    object.rotation = degrees;
  }

  setAlpha(DisplayObject object, num value) {
    object.alpha = value;
  }

  centerPivot(Sprite object) {
    object.anchor.x = 0.5;
    object.anchor.y = 0.5;
  }

  createBitmap(covariant bitmapData) {
    if (bitmapData is Texture) {
      return new Sprite(bitmapData);
    } else {
      return Sprite.fromImage(bitmapData);
    }
  }

  createBitmapData(source, String sourceString) {
    return sourceString;
  }

  @override
  createBitmapDataFromImageElement(ImageElement image) {
    BaseTexture baseTexture = new BaseTexture(image);
    Texture texture = new Texture(baseTexture);
    return texture;
  }

  createContainer() {
    return new Container();
  }

  setScale(DisplayObject object, num value) {
    object.scale = new Point(value, value);
  }

  setScaleX(DisplayObject object, num value) {
    object.scale = new Point(value, object.scale.y);
  }

  setScaleY(DisplayObject object, num value) {
    object.scale = new Point(object.scale.x, value);
  }
}
