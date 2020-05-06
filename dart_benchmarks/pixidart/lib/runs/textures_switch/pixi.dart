import 'dart:async';
import 'dart:js';
import 'dart:math' as math;

import 'package:pixi/pixi.dart';
import 'package:pixi_dart_benchmark/benchmarks/common.dart';
import 'package:pixi_dart_benchmark/interfaces/common.dart';
import 'package:pixi_dart_benchmark/runs/atlasses/atlas_facade.dart';
class PixiTextureSwitchBenchmark implements BenchmarkBase {
  final int canvasWidth;
  final int canvasHeight;
  final Interface interface;
  final Container layout;
  final int nbOfObjects;
  math.Random rdm = new math.Random();
  Container containerA = new Container();
  Container containerB = new Container();

  final String _rDir = '../assets/data.json';
  final String _rDir2 = '../assets/data_b.json';

  PixiTextureSwitchBenchmark(this.interface, this.nbOfObjects, this.layout,
      this.canvasWidth, this.canvasHeight);

  init() async {
    Completer _completer = new Completer();
    _completing(b, a) {
      _completer.complete();
    }

    loadSprite(_rDir, allowInterop(_completing));
    await _completer.future;
    _drawA();

    Completer _completer2 = new Completer();
    _completing2(b, a) {
      _completer2.complete();
    }

    loadSprite(_rDir2, allowInterop(_completing2));
    await _completer2.future;
    _drawB();
  }

  _drawA() {
    Sprite bg1 = getSprite(_rDir, "slota.background")
      ..x = 640
      ..y = 360
      ..anchor.x = .5
      ..anchor.y = .5;

    Sprite c1 = getSprite(_rDir, "slota.caracter")
      ..x = 300
      ..y = 360
      ..anchor.x = .5
      ..anchor.y = .5;

    Sprite e1 = getSprite(_rDir, "slota.ending")
      ..x = 600
      ..y = 360
      ..anchor.x = .5
      ..anchor.y = .5;

    Sprite d1 = getSprite(_rDir, "slota.complete")
      ..x = 300
      ..y = 450
      ..anchor.x = .5
      ..anchor.y = .5;

    Sprite s1A = getSprite(_rDir, "slota.symbolA")
      ..x = 1000
      ..y = 100
      ..anchor.x = .5
      ..anchor.y = .5;

    Sprite s1B = getSprite(_rDir, "slota.symbolB")
      ..x = 1000
      ..y = 250
      ..anchor.x = .5
      ..anchor.y = .5;

    Sprite s1C = getSprite(_rDir, "slota.symbolC")
      ..x = 1000
      ..y = 400
      ..anchor.x = .5
      ..anchor.y = .5;

    Sprite s1D = getSprite(_rDir, "slota.symbolD")
      ..x = 1000
      ..y = 550
      ..anchor.x = .5
      ..anchor.y = .5;

    Sprite s1E = getSprite(_rDir, "slota.symbolE")
      ..x = 1000
      ..y = 650
      ..anchor.x = .5
      ..anchor.y = .5;

    containerA.addChild(bg1);
    containerA.addChild(c1);
    containerA.addChild(e1);
    containerA.addChild(d1);

    containerA.addChild(s1A);
    containerA.addChild(s1B);
    containerA.addChild(s1C);
    containerA.addChild(s1D);
    containerA.addChild(s1E);
  }

  _drawB() {
    Sprite bg1 = getSprite(_rDir2, "slotb.background")
      ..x = 640
      ..y = 360
      ..anchor.x = .5
      ..anchor.y = .5;

    Sprite c1 = getSprite(_rDir2, "slotb.caracter")
      ..x = 300
      ..y = 360
      ..anchor.x = .5
      ..anchor.y = .5;

    Sprite e1 = getSprite(_rDir2, "slotb.ending")
      ..x = 600
      ..y = 360
      ..anchor.x = .5
      ..anchor.y = .5;

    Sprite d1 = getSprite(_rDir2, "slotb.complete")
      ..x = 300
      ..y = 450
      ..anchor.x = .5
      ..anchor.y = .5;

    Sprite s1A = getSprite(_rDir2, "slotb.symbolA")
      ..x = 1000
      ..y = 100
      ..anchor.x = .5
      ..anchor.y = .5;

    Sprite s1B = getSprite(_rDir2, "slotb.symbolB")
      ..x = 1000
      ..y = 250
      ..anchor.x = .5
      ..anchor.y = .5;

    Sprite s1C = getSprite(_rDir2, "slotb.symbolC")
      ..x = 1000
      ..y = 400
      ..anchor.x = .5
      ..anchor.y = .5;

    Sprite s1D = getSprite(_rDir2, "slotb.symbolD")
      ..x = 1000
      ..y = 550
      ..anchor.x = .5
      ..anchor.y = .5;

    Sprite s1E = getSprite(_rDir2, "slotb.symbolE")
      ..x = 1000
      ..y = 650
      ..anchor.x = .5
      ..anchor.y = .5;

    containerB.addChild(bg1);
    containerB.addChild(c1);
    containerB.addChild(e1);
    containerB.addChild(d1);

    containerB.addChild(s1A);
    containerB.addChild(s1B);
    containerB.addChild(s1C);
    containerB.addChild(s1D);
    containerB.addChild(s1E);
  }

  bool b = false;
  eachFrameFunction([num v]) {
    if (b) {
      layout.removeChild(containerB);
      layout.addChild(containerA);
      b = false;
    } else {
      layout.removeChild(containerA);
      layout.addChild(containerB);
      b = true;
    }
  }
}
