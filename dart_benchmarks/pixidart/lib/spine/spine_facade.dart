@JS()
library spine_facade.js;

import 'package:js/js.dart';
import 'package:pixi/pixi.dart';
import 'package:pixi_dart_benchmark/spine/pixi_spine.dart';

@JS("createSpine")
external Spine createSpine(Loader loader, String name);
