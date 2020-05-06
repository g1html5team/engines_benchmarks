import 'package:stagexl/stagexl.dart';
import 'dart:math' as math;

class FixedContainer extends DisplayObjectContainer {
  FixedContainer(int _width, int _height)
  {
    this.width = _width;
    this.height = _height;
  }
}

num degreesToRadians(num degrees) => degrees * math.pi / 180;
num radiansToDegrees(num radiants) => radiants * 180 / math.pi
;
