import 'package:pixi_dart_benchmark/interfaces/common.dart';

abstract class ParticlesInterface extends Interface {
  setBrightness(covariant object, num value);
  setHue(covariant object, num value);

  setParticles(covariant object, [num v]);

  createParticles(); //ParticleEmitter
}
