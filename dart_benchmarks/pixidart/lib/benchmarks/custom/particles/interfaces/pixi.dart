import 'dart:math' as math;

import 'package:pixi/pixi.dart';
import 'package:pixi_dart_benchmark/interfaces/pixi.dart';

import 'common.dart';

class PixiParticlesInterface extends PixiInterface
    implements ParticlesInterface {
  PixiParticlesInterface();
  num base = 0;
  setBrightness(DisplayObject object, num value) {
    object.filters = [new ColorMatrixFilter()..brightness(value, false)];
  }

  setHue(DisplayObject object, num value) {
    object.filters = [new ColorMatrixFilter()..hue(value, false)];
  }

  @override
  setParticles(DisplayObject particle, [num v]) {

if(v != 0)
  {

       num scale = ((v - base) / 1000);
        particle.x *= 1.1;
//        particle.localTransform = (1, 1);

      particle.rotation += 0.1;
      particle.scale = new Point(scale,scale);
  }

//      }
//    }

// particle.getGlobalPosition().x : la position dans la scene
// particle.localTransform.tx : 0 au début: position d'origine idem particle.x
  }

  Container createParticles() {
    return createRound(20);
  }

  Container createRound(num rayon) {
    var round = new Container();
    var points = new Graphics();
    points.beginFill(0xFFFF0B, 1);
    for (var i = -rayon; i <= rayon; ++i) {
      points.drawCircle(i, math.sqrt((rayon * rayon) - (i * i)), 2); //x, y
      points.drawCircle(i, -math.sqrt((rayon * rayon) - (i * i)), 2); //x, y
    }
    points.endFill();
    round.addChild(points);

    return round;
  }

  /* @override
  Container CreateParticles2() {
    //ParticleContainer

    print("Create particle");

    var particleContainer = new ParticleContainer();

    for (var i = 0; i < 10; ++i) {
      var graphics = new Graphics();

// draw a circle, set the lineStyle to zero so the circle doesn't have an outline
      graphics.lineStyle(0);
      graphics.beginFill(0xFFFF0B, 0.5);
      graphics.drawCircle(i * 10, i * 5, 40); //(num x, num y, num radius)
      graphics.endFill();

//var graphics = new PIXI.Sprite.fromImage("myImage.png");
      var graphics2 = new Sprite(new Texture(new BaseTexture(graphics)));
      particleContainer.addChild(graphics2);
    }

    return particleContainer;
  }*/
}
