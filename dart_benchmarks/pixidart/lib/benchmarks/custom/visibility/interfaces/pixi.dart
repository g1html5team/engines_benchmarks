
import 'package:pixi/pixi.dart';
import 'package:pixi_dart_benchmark/interfaces/pixi.dart';

import 'common.dart';

class PixiVisibilityInterface extends PixiInterface
    implements VisibilityInterface {
  PixiVisibilityInterface();

  setVisible(DisplayObject child, bool visibility) {
    child.visible = visibility;
  }

  setScale(DisplayObject object, num value) {
    object.scale = new Point(value, value);
  }
}
