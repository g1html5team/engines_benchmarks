import 'dart:async';

import 'package:pixi_dart_benchmark/interfaces/common.dart';

abstract class FlipbookInterface extends Interface {
  Future load({covariant ng1n, covariant stagexl, covariant pixi});

  play(covariant object, int currentFrame);

  dynamic createFlipbook(covariant dataList);
}
