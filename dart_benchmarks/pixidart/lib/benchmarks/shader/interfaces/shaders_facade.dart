@JS()
library graphic_engine_benchmark.custom.shader.interfaces.shaders_facade;

import 'package:js/js.dart';

//import 'package:pixi/pixi.js.dart';

@JS('callFilter')
external dynamic callFilter(String vertexShader, String fragmentShader);
