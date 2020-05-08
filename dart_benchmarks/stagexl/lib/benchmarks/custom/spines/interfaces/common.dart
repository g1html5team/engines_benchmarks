import 'package:stagexl_benchmark/interfaces/common.dart';

const String turtleAnimationName = "animationTortueLoop";
const String waveAnimationName = "animationWaterLoop";

abstract class SpinesInterface extends Interface {
  createSkeletonAnimation(covariant skeletonData);
  getLoader();
}
