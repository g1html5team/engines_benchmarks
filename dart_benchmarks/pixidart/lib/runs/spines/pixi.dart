import 'dart:async';
import 'dart:js';
import 'dart:math' as math;

import 'package:pixi/pixi.dart';
import 'package:pixi_dart_benchmark/benchmarks/common.dart';
import 'package:pixi_dart_benchmark/benchmarks/custom/spines/interfaces/common.dart';
import 'package:pixi_dart_benchmark/benchmarks/custom/spines/interfaces/pixi.dart';
import 'package:pixi_dart_benchmark/runs/spines/spine_facade.dart';
import 'package:pixi_dart_benchmark/spine/pixi_spine.dart';


class PixiSpinesBenchmark implements BenchmarkBase {
  final int canvasWidth;
  final int canvasHeight;
  final PixiSpinesInterface interface;
  final Container layout;
  final int nbOfObjects;
  final int nbOfDeformObjects;
  math.Random rdm = new math.Random();
  Container container = new Container();
  List<Spine> _turtles = [];
  Loader loader = Loader();

  PixiSpinesBenchmark(this.interface, this.nbOfObjects, this.nbOfDeformObjects,
      this.layout, this.canvasWidth, this.canvasHeight);

  init() async {
    loader
      ..add("carapace", "../assets/spine/images/game5/game5/carapace.png")
      ..add("carapaceBack", "../assets/spine/images/game5/game5/carapace_back.png")
      ..add("head", "../assets/spine/images/game5/game5/head.png")
      ..add("mer", "../assets/spine/images/game5/game5/mer.png")
      ..add("merTop", "../assets/spine/images/game5/game5/mer_top.png")
      ..add("neck", "../assets/spine/images/game5/game5/neck.png")
      ..add("patteFull", "../assets/spine/images/game5/game5/patte_full.png")
      ..add("phylaTortue", "../assets/spine/images/game5/game5/phyla_tortue.png")
      ..add("sable", "../assets/spine/images/game5/game5/sable.jpg")
      ..add("sand", "../assets/spine/images/game5/game5/sand.png")
      ..add("shadow", "../assets/spine/images/game5/game5/shadow.png")
      ..add("shadow2", "../assets/spine/images/game5/game5/shadow2.png")
      ..add("tracesEau", "../assets/spine/images/game5/game5/traces_eau.png");
    Completer firstCompleter = new Completer();
    loader.load(allowInterop((a, b) {
      firstCompleter.complete();
    }));
    await firstCompleter.future;
    var v = getTextureFrom('carapace');


    Map<String, Texture> allTextures = {
      "../assets/spine/images/game5/game5/carapace": (getTextureFrom("carapace")),
      "../assets/spine/images/game5/game5/carapace_back": (getTextureFrom("carapaceBack")),
      "../assets/spine/images/game5/game5/head": (getTextureFrom("head")),
      "../assets/spine/images/game5/game5/mer": (getTextureFrom("mer")),
      "../assets/spine/game5/game5/mer_top": (getTextureFrom("merTop")),
      "../assets/spine/images/game5/game5/neck": (getTextureFrom("neck")),
      "../assets/spine/mages/game5/game5/patte_full": (getTextureFrom("patteFull")),
      "../assets/spine/mages/game5/game5/phyla_tortue": (getTextureFrom("phylaTortue")),
      "../assets/spine/images/game5/game5/sable": (getTextureFrom("sable")),
      "../assets/spine/images/game5/game5/sand": (getTextureFrom("sand")),
      "../assets/spine/images/game5/game5/shadow": (getTextureFrom("shadow")),
      "../assets/spine/images/game5/game5/shadow2": (getTextureFrom("shadow2")),
      "../assets/spine/images/game5/game5/traces_eau": (getTextureFrom("tracesEau"))
    };
    Atlas atlas = getAtlas(allTextures);

    Completer secondCompleter = new Completer();
    loaderAddSkeletonDataWithExistingAtlas(
        loader, "turtle", "../assets/shop_tortue.json", atlas);
    loaderAddSkeletonDataWithExistingAtlas(
        loader, "wave", "../assets/shop_mer_top.json", atlas);
    loader.load(allowInterop((a, b) {
      secondCompleter.complete();
    }));
    await secondCompleter.future;

    for (int i = 0; i < nbOfDeformObjects; i++) {
      Spine wave = createSpine(loader, "wave");
      interface.addChild(container, wave);
      interface.setX(wave, -640 + i * ((-640) / nbOfDeformObjects));
      interface.setY(wave, -360 + i * ((-360) / nbOfDeformObjects));
      wave.state.setAnimationByName(0, waveAnimationName, true);
    }

    for (int i = -1; ++i < nbOfObjects;) {
      Spine turtle = createSpine(loader, "turtle");
      interface.addChild(container, turtle);
      interface.setX(turtle, rdm.nextInt(canvasWidth ~/ 2));
      interface.setY(turtle, rdm.nextInt(canvasHeight ~/ 2));
      _turtles.add(turtle);
      turtle.state.setAnimationByName(0, turtleAnimationName, true);
    }
    layout.addChild(container);
  }

  eachFrameFunction([num v]) {
  }
}
