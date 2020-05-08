import 'dart:async';

import 'package:stagexl_benchmark/interfaces/common.dart';

abstract class FlipbookInterface extends Interface {
  Future load(List<String> strings);

  play(covariant object, int currentFrame);

  dynamic createFlipbook();
}
