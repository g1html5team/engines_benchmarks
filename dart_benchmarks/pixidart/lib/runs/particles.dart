import 'dart:html';
import 'dart:math';

import 'package:pixi_dart_benchmark/benchmarks/common.dart';
import 'package:pixi_dart_benchmark/benchmarks/custom/particles/interfaces/common.dart';

class Particles1Benchmark implements BenchmarkBase {
  final int canvasWidth;
  final int canvasHeight;
  final ParticlesInterface interface;
  final layout;
  final int nbOfObjects;
  List _bunnies = [];
  Random rdm = new Random();

  Particles1Benchmark(this.interface, this.nbOfObjects, this.layout,
      this.canvasWidth, this.canvasHeight) {
    var container = interface.createContainer();
    var data = interface.createBitmapData(querySelector('#bunny'), 'bunny.png');
    for (int i = -1; ++i < nbOfObjects;) {
      var bunny = interface.createBitmap(data);
      interface.addChild(container, bunny);
      interface.setX(bunny, rdm.nextInt(canvasWidth));
      interface.setY(bunny, rdm.nextInt(canvasHeight));
      interface.setRotation(bunny, rdm.nextDouble() * pi);
      interface.centerPivot(bunny);
      _bunnies.add(bunny);
    }

    interface.addChild(layout, container);
  }

  eachFrameFunction([num v]) {
    for (var bunny in _bunnies) {
      interface.setBrightness(bunny, rdm.nextDouble() * 2);
    }
  }
}

class Particles2Benchmark implements BenchmarkBase {
  final int canvasWidth;
  final int canvasHeight;
  final ParticlesInterface interface;
  final layout;
  final int nbOfObjects;

  List _particles = [];
  Random rdm = new Random();

  Particles2Benchmark(this.interface, this.nbOfObjects, this.layout,
      this.canvasWidth, this.canvasHeight) {
    var container = interface.createContainer();
    for (int i = -1; ++i < nbOfObjects;) {
      var particle = interface.createParticles(); //ParticleEmitter LightEmmiter
      interface.addChild(container, particle);
      interface.setX(particle, rdm.nextInt(canvasWidth));
      interface.setY(particle, rdm.nextInt(canvasHeight));
      _particles.add(particle);
    }

    interface.addChild(layout, container);
  }

  eachFrameFunction([num v]) {
    for (var particle in _particles) {
      //ParticleEmitter
      interface.setParticles(particle, v);
    }
  }
}
