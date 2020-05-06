import 'dart:html';

abstract class Interface {
  addChild(covariant container, covariant child);
  removeChild(covariant container, covariant child);
  addChildAt(covariant container, covariant child, int index);
  createContainer();

  setX(covariant object, num value);
  setY(covariant object, num value);
  setRotation(covariant object, num value);
  setAlpha(covariant object, num value);

  num getX(covariant object);
  num getY(covariant object);
  num getRotation(covariant object);
  num getAlpha(covariant object);

  centerPivot(covariant object);
  createBitmap(covariant bitmapData);
  createBitmapData(covariant source, String sourceString);
  createBitmapDataFromImageElement(ImageElement image);

  setScale(covariant object, num value);
  setScaleX(covariant object, num value);
  setScaleY(covariant object, num value);

  num getScaleX(covariant object);
  num getScaleY(covariant object);
}
