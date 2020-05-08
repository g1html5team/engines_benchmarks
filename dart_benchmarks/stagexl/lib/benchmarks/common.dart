import 'dart:async';
import 'dart:html';
import 'dart:math' as math;


import 'package:stagexl_benchmark/interfaces/common.dart';

import 'keys.dart';

const int secondsBeforeRun = 2;
int secondsForRun = 5;

typedef void EachFrameFunction(num v);

abstract class GraphicEngineBenchmark {
  int get canvasWidth;
  int get canvasHeight;
  Interface get interface;
  CanvasElement get canvas;
  Element get container;
  BenchmarkManager get manager;
  initialize();
  release();
  frameRendering(num v);
}

abstract class BenchmarkBase {
  int get canvasWidth;
  int get canvasHeight;
  dynamic get layout;
  Interface get interface;
  eachFrameFunction([num v]);
}

class BenchmarkRunner {
  Stopwatch frameWatch = new Stopwatch();
  Stopwatch elapsedTime = new Stopwatch();
  List<num> _framesDuration = [];

  BenchmarkBase base;
  EachFrameFunction frameRendering;

  BenchmarkRunner(this.base, this.frameRendering);

  Future<BenchmarkResult> run() async {
    _baseRender(num v) {
      frameRendering(v);
      base.eachFrameFunction(v);
    }

    for (int i = -1; ++i < 20;) {
      _baseRender(0);
    }

    await xSeconds(secondsBeforeRun);

    elapsedTime.start();

    Completer _completer = new Completer();

    _render(num v) {
      frameWatch.start();
      _baseRender(v);
      frameWatch.reset();
      _framesDuration.add(frameWatch.elapsedMicroseconds);
      window.requestAnimationFrame((num v) {
        if (elapsedTime.elapsedMilliseconds / 1000 < secondsForRun) {
          _render(v);
        } else {
          _framesDuration.add(1);
          _completer.complete();
        }
      });
    }

    _render(elapsedTime.elapsedMilliseconds);

    await _completer.future;

    return processFrames();
  }

  Future xSeconds(int nbSeconds) {
    Completer _completer = new Completer();
    new Timer(new Duration(seconds: nbSeconds), _completer.complete);
    return _completer.future;
  }

  processFrames() {
    num avg = 0;
    _framesDuration.forEach((num v) => avg += v);
    avg = (avg / _framesDuration.length);
    return new BenchmarkResult(
        avg, math.min(_framesDuration.length / secondsForRun, 60));
  }
}

class BenchmarkResult {
  /// Attention que [averageFrameMicroSecondsDuration] reprèsente le temps qu'il aura fallu pour exécuter la fonction eachFrame
  /// et pas le temps total de rendu de la frame
  /// Il est donc tant que maintenant un peu inutile.
  //TODO: créer ou utiliser un service dans la dev bar pour récupérer le temps de rendu d'une frame
  final num averageFrameMicroSecondsDuration;
  final num avgFps;

  BenchmarkResult(this.averageFrameMicroSecondsDuration, this.avgFps);

  String toString() {
    return ('$averageFrameDuration : ' +
        averageFrameMicroSecondsDuration.toString() +
        ' microseconds' +
        '\n' +
        '$averageFps : $avgFps');
  }
}

class BenchmarkManager {
  final Interface interface;
  final int canvasWidth;
  final int canvasHeight;
  dynamic layout;
  EachFrameFunction frameRendering;

  BenchmarkManager(this.interface, this.canvasWidth, this.canvasHeight,
      this.frameRendering, this.layout);


  // Todo (mHar) : THIS
  //  Future<Map> runChildrenAnimateBenchmark(int objects) async {
//    ChildrenAnimateBenchmark benchmark = new ChildrenAnimateBenchmark(
//        interface, objects, layout, canvasWidth, canvasHeight);
//    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
//    BenchmarkResult result = await runner.run();
//    return processResult(result);
//  }
//
//  Future<Map> runChildrenAddRemoveBenchmark(int objects) async {
//    ChildrenAddRemoveBenchmark benchmark = new ChildrenAddRemoveBenchmark(
//        interface, objects, layout, canvasWidth, canvasHeight);
//    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
//    BenchmarkResult result = await runner.run();
//    return processResult(result);
//  }
//
//  Future<Map> runChildrenStairsBenchmark(int objects) async {
//    ChildrenChildrenInStairsBenchmark benchmark =
//    new ChildrenChildrenInStairsBenchmark(
//        interface, objects, layout, canvasWidth, canvasHeight);
//    BenchmarkRunner runner = new BenchmarkRunner(benchmark, frameRendering);
//    BenchmarkResult result = await runner.run();
//    return processResult(result);
//  }

  Map<String, String> processResult(BenchmarkResult result) {
    return {
      averageFrameDuration:
      result.averageFrameMicroSecondsDuration.toStringAsFixed(2),
      averageFps: result.avgFps.toString()
    };
  }
}
