import 'dart:html';

import 'package:pixi/pixi.dart';
import 'package:pixi_dart_benchmark/interfaces/pixi.dart';

import '../common.dart';

class PixiBenchmark implements GraphicEngineBenchmark {
  final int canvasWidth;
  final int canvasHeight;
  Element container;
  CanvasElement get canvas => app.view;
  PixiInterface interface = new PixiInterface();
  BenchmarkManager manager;
  Application app;
  Container layout;
  bool useCanvas2D = false;

  PixiBenchmark(this.container, this.canvasWidth, this.canvasHeight) {
    initialize();
    manager = new BenchmarkManager(
        interface, canvasWidth, canvasHeight, frameRendering, layout);
  }

  initialize() {
    app = new Application(new Options(width: canvasWidth, height: canvasHeight, forceCanvas: useCanvas2D));
    app.ticker.stop();
    app.stop();
    layout = app.stage;
    container.append(app.view);
  }

  release() {
    app.destroy(true);
  }

  frameRendering(num v) {
    app.ticker.update();
    app.render();
  }
}
