import 'dart:html';
import 'package:stagexl/stagexl.dart';
import 'package:stagexl_benchmark/helpers/stagexl_objects.dart';
import 'common.dart';

class StagexlInterface implements Interface {
  StagexlInterface();

  ResourceManager resourceManager = ResourceManager();

  addChild(DisplayObjectContainer container, DisplayObject child) {
    container.addChild(child);
  }

  removeChild(DisplayObjectContainer container, DisplayObject child) {
    container.removeChild(child);
  }

  addChildAt(DisplayObjectContainer container, DisplayObject child, int index) {
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
    return object.scaleX;
  }

  num getScaleY(DisplayObject object) {
    return object.scaleX;
  }

  setX(DisplayObject object, num value) {
    object.x = value;
  }

  setY(DisplayObject object, num value) {
    object.y = value;
  }

  setRotation(DisplayObject object, num degrees) {
    object.rotation = degreesToRadians(degrees);
  }

  setAlpha(DisplayObject object, num value) {
    object.alpha = value;
  }

  centerPivot(DisplayObject object) {
    object.alignPivot(HorizontalAlign.Center, VerticalAlign.Center) ;
  }

  createBitmap(BitmapData bitmapData) {
    return new Bitmap(bitmapData);
  }

  createBitmapData(ImageElement source, String sourceString) {
    return new BitmapData.fromImageElement(source);
  }

  @override
  createBitmapDataFromImageElement(ImageElement imageElement) {
    return new BitmapData.fromImageElement(imageElement);
  }

  createContainer() {
    return new FixedContainer(0,0);
  }

  setScale(DisplayObject object, num value) {
    object.scaleX = value;
    object.scaleY = value;
  }

  setScaleX(DisplayObject object, num value) {
    object.scaleX = value;
  }

  setScaleY(DisplayObject object, num value) {
    object.scaleY = value;
  }
}
