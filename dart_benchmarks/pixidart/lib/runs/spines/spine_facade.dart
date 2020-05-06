@JS()
library graphic_engine_benchmark.runs.spines.spine_facade;

import 'package:js/js.dart';
import 'package:pixi/pixi.dart';
import 'package:pixi_dart_benchmark/spine/pixi_spine.dart';

@JS("getTextureAtlas")
external Atlas getAtlas(var textures);

@JS("getTextureFrom")
external Texture getTextureFrom(String name);

@JS("loaderAddSkeletonDataWithExistingAtlas")
external Texture loaderAddSkeletonDataWithExistingAtlas(
    Loader loader, String name, String json, Atlas atlas);

@JS("createSpine")
external Spine createSpine(Loader loader, String name);
