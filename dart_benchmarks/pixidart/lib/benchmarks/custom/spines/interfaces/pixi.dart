

import 'package:pixi_dart_benchmark/interfaces/pixi.dart';
import 'package:pixi_dart_benchmark/spine/pixi_spine.dart';

import 'common.dart';

class PixiSpinesInterface extends PixiInterface implements SpinesInterface {
  PixiSpinesInterface();

  createSkeletonAnimation(skeletonData) {
    return new Spine(skeletonData);
  }

  getLoader() {}
  getAssets() {}
}
