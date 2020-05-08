
import 'package:stagexl/stagexl.dart';
import 'package:stagexl_benchmark/interfaces/stagexl.dart';

import 'common.dart';

class StagexlVisibilityInterface extends StagexlInterface
    implements VisibilityInterface {
  StagexlVisibilityInterface();

  setVisible(DisplayObject object, bool visibility) {
    object.visible = visibility;
  }

  setScale(DisplayObject object, num value) {
    object.scaleX = value;
    object.scaleY = value;
  }
}
