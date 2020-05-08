
import 'package:stagexl/stagexl.dart';
import 'package:stagexl_benchmark/interfaces/stagexl.dart';

import 'common.dart';

class StagexlAtlasInterface extends StagexlInterface implements AtlasInterface {
  StagexlAtlasInterface();

  @override
  removeChildren(DisplayObjectContainer container) {
    container.removeChildren();
  }

  @override
  setBitmapData(Bitmap bitmap, BitmapData data) {
    bitmap.bitmapData = data;
  }
}
