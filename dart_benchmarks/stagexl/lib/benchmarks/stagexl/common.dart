import 'dart:html';
import 'package:stagexl/stagexl.dart';
import 'package:stagexl_benchmark/benchmarks/common.dart';
import 'package:stagexl_benchmark/helpers/stagexl_objects.dart';
import 'package:stagexl_benchmark/interfaces/stagexl.dart';

class StageXlBenchmark implements GraphicEngineBenchmark {
  final int canvasWidth;
  final int canvasHeight;
  Element container;
  CanvasElement canvas;
  StagexlInterface interface = new StagexlInterface();
  BenchmarkManager manager;
  Stage app;
  FixedContainer layout;

  StageXlBenchmark(this.container, this.canvasWidth, this.canvasHeight, [bool useWebgl = false]) {
    initialize();
    manager = new BenchmarkManager(
        interface, canvasWidth, canvasHeight, frameRendering, layout);

  }

  initialize() {
  canvas = querySelector('canvas');
    canvas.width = canvasWidth;
    canvas.height = canvasHeight;

    app = new Stage(canvas);
    app.backgroundColor = Color.Aqua;
    layout = new FixedContainer(canvasWidth, canvasHeight);
//    layout.x = -canvasWidth / 2;
//    layout.y = -canvasHeight / 2;
    app.addChild(layout);
  }

  release() {
    Element h = container.children.first;
    container.children.clear();
    container.append(h);
    app.removeChildren();
//    app.release();
    app.removeFromParent();
    app = null;
    canvas = null;
    layout = null;
  }

  frameRendering(num v) {
    app.stage.materialize(v, v);
  }
}
