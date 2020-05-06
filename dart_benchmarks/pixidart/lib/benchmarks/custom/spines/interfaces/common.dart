
import 'package:pixi_dart_benchmark/interfaces/common.dart';

const String turtleAnimationName = "animationTortueLoop";
const String waveAnimationName = "animationWaterLoop";

abstract class SpinesInterface extends Interface {
  createSkeletonAnimation(covariant skeletonData);
  getLoader();
}
