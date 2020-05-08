import 'dart:math';
import 'package:stagexl/stagexl.dart';
import 'package:stagexl_benchmark/interfaces/stagexl.dart';
import 'package:stagexl_particle/stagexl_particle.dart';

import 'common.dart';

class StagexlParticlesInterface extends StagexlInterface
    implements ParticlesInterface {
  StagexlParticlesInterface();

  Random rdm = new Random();

  setBrightness(DisplayObject object, num value) {
    object.filters = [new ColorMatrixFilter.adjust(brightness: value)];
  }

  setHue(DisplayObject object, num value) {
    object.filters = [new ColorMatrixFilter.adjust(hue: value)];
  }

  @override
  setParticles(ParticleEmitter particle, [num v]) {
    particle.start();
  }

  @override
  ParticleEmitter createParticles({num particleCount = 1000}) {
    Map particleConfig = {
      "maxParticles": particleCount,
      "duration": 0,
      "lifeSpan": 0.7,
      "lifespanVariance": 0.2,
      "startSize": 16,
      "startSizeVariance": 30,
      "finishSize": 53,
      "finishSizeVariance": 110,
      "shape": "circle",
      "emitterType": 0,
      "location": {"x": 0, "y": 0},
      "locationVariance": {"x": 5, "y": 5},
      "speed": 100,
      "speedVariance": 33,
      "angle": 0,
      "angleVariance": 360,
      "gravity": {"x": 1, "y": 10},
      "radialAcceleration": 20,
      "radialAccelerationVariance": 0,
      "tangentialAcceleration": 10,
      "tangentialAccelerationVariance": 0,
      "minRadius": 0,
      "maxRadius": 100,
      "maxRadiusVariance": 100,
      "rotatePerSecond": 0,
      "rotatePerSecondVariance": 0,
      "compositeOperation": "source-over",
      "startColor": {
        "red": rdm.nextDouble(),
        "green": rdm.nextDouble(),
        "blue": rdm.nextDouble(),
        "alpha": 1
      },
      "finishColor": {
        "red": rdm.nextDouble(),
        "green": rdm.nextDouble(),
        "blue": rdm.nextDouble(),
        "alpha": 0
      }
    };
    //particleConfig['startColor'] = {"red": rdm.nextDouble(), "green": rdm.nextDouble(), "blue": rdm.nextDouble(), "alpha": 1};

    return new ParticleEmitter(particleConfig);
  }
}
