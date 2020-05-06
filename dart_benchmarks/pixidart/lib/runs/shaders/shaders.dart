import 'dart:html';
import 'dart:math';

import 'package:pixi_dart_benchmark/benchmarks/common.dart';
import 'package:pixi_dart_benchmark/benchmarks/shader/interfaces/common.dart';

class ShaderAllTypeAtOnceBenchmark implements BenchmarkBase {
  final int canvasWidth;
  final int canvasHeight;
  final ShaderInterface interface;
  final layout;
  final int nbOfObjects;
  List _bunnies = [];
  var bunnyDisplacementBitmap;
  Random rdm = new Random();

  ShaderAllTypeAtOnceBenchmark(this.interface, this.nbOfObjects, this.layout,
      this.canvasWidth, this.canvasHeight) {
    var container = interface.createContainer();
    var data = interface.createBitmapData(querySelector('#bunny'), 'bunny.png');
    var dataBg = interface.createBitmapData(
        querySelector('#background'), '../assets/background.jpg');

    var background = interface.createBitmap(dataBg);
    interface.addChild(container, background);

    bunnyDisplacementBitmap = interface.createBitmap(data);
    interface
      ..addChild(container, bunnyDisplacementBitmap)
      ..centerPivot(bunnyDisplacementBitmap)
      ..setAlpha(bunnyDisplacementBitmap, 0.25)
      ..setX(bunnyDisplacementBitmap, 25)
      ..setY(bunnyDisplacementBitmap, 75);

    num thirdOfObject = nbOfObjects / 3;

    for (int i = -1; ++i < nbOfObjects;) {
      var bunny = interface.createBitmap(data);
      interface.addChild(container, bunny);
      interface.setX(bunny, 50 + rdm.nextInt(canvasWidth - 50));
      interface.setY(bunny, 50 + rdm.nextInt(canvasHeight - 50));
      interface.setRotation(bunny, rdm.nextDouble() * pi);
      interface.centerPivot(bunny);

      int shaderTypeStep = i ~/ thirdOfObject;

      interface.setShader(bunny, ShaderType.values[shaderTypeStep],
          optionnalObject: bunnyDisplacementBitmap);
      _bunnies.add(bunny);
    }

    interface.addChild(layout, container);
  }

  eachFrameFunction([num v]) {
    moveSprite(
        interface, bunnyDisplacementBitmap, v, canvasWidth, canvasHeight);
  }
}

class ShaderStepByStepBenchmark implements BenchmarkBase {
  final int canvasWidth;
  final int canvasHeight;
  final ShaderInterface interface;
  final layout;
  final int nbOfObjects;
  List _bunnies = [];
  var bunnyDisplacementBitmap;
  Random rdm = new Random();
  var data, container;

  ShaderStepByStepBenchmark(this.interface, this.nbOfObjects, this.layout,
      this.canvasWidth, this.canvasHeight) {
    container = interface.createContainer();
    data = interface.createBitmapData(querySelector('#bunny'), 'bunny.png');
    var dataBg = interface.createBitmapData(
        querySelector('#background'), '../assets/background.jpg');

    var background = interface.createBitmap(dataBg);
    interface.addChild(container, background);

    bunnyDisplacementBitmap = interface.createBitmap(data);
    interface
      ..addChild(container, bunnyDisplacementBitmap)
      ..centerPivot(bunnyDisplacementBitmap)
      ..setAlpha(bunnyDisplacementBitmap, 0.25)
      ..setX(bunnyDisplacementBitmap, 25)
      ..setY(bunnyDisplacementBitmap, 75);

    interface.addChild(layout, container);

    thirdOfObject = nbOfObjects / 3;
  }

  num thirdOfObject;
  num delay = 1.0;
  int shaderTypeStep = 0;
  eachFrameFunction([num v]) {
    delay += v * 0.000001;
    if (delay >= 1.0) {
      delay = 0.0;

      if (_bunnies.length >= nbOfObjects) {
        _clearBunnies();
      }

      for (int i = -1; ++i < thirdOfObject;) {
        var bunny = interface.createBitmap(data);
        interface.addChild(container, bunny);
        interface.setX(bunny, 50 + rdm.nextInt(canvasWidth - 50));
        interface.setY(bunny, 50 + rdm.nextInt(canvasHeight - 50));
        interface.setRotation(bunny, rdm.nextDouble() * pi);
        interface.centerPivot(bunny);

        interface.setShader(bunny, ShaderType.values[shaderTypeStep],
            optionnalObject: bunnyDisplacementBitmap);
        _bunnies.add(bunny);
      }

      shaderTypeStep++;
      if (shaderTypeStep >= ShaderType.values.length) {
        shaderTypeStep = 0;
      }
    }

    moveSprite(
        interface, bunnyDisplacementBitmap, v, canvasWidth, canvasHeight);
  }

  _clearBunnies() {
    for (int i = -1; ++i < nbOfObjects;) {
      interface.removeChild(container, _bunnies[i]);
    }
  }
}

class ShaderByTypeBenchmark implements BenchmarkBase {
  final int canvasWidth;
  final int canvasHeight;
  final ShaderInterface interface;
  final layout;
  final int nbOfObjects;
  final ShaderType shaderType;
  List _bunnies = [];
  var bunnyDisplacementBitmap;
  Random rdm = new Random();

  ShaderByTypeBenchmark(this.interface, this.nbOfObjects, this.shaderType,
      this.layout, this.canvasWidth, this.canvasHeight) {
    var container = interface.createContainer();
    var data = interface.createBitmapData(querySelector('#bunny'), 'bunny.png');
    var dataBg = interface.createBitmapData(
        querySelector('#background'), '../assets/background.jpg');

    var background = interface.createBitmap(dataBg);
    interface.addChild(container, background);

    bunnyDisplacementBitmap = interface.createBitmap(data);
    interface
      ..addChild(container, bunnyDisplacementBitmap)
      ..centerPivot(bunnyDisplacementBitmap)
      ..setAlpha(bunnyDisplacementBitmap, 0.25)
      ..setX(bunnyDisplacementBitmap, 25)
      ..setY(bunnyDisplacementBitmap, 75);

    for (int i = -1; ++i < nbOfObjects;) {
      var bunny = interface.createBitmap(data);
      interface.addChild(container, bunny);
      interface.setX(bunny, 50 + rdm.nextInt(canvasWidth - 50));
      interface.setY(bunny, 50 + rdm.nextInt(canvasHeight - 50));
      interface.setRotation(bunny, rdm.nextDouble() * pi);
      interface.centerPivot(bunny);

      interface.setShader(bunny, shaderType,
          optionnalObject: bunnyDisplacementBitmap);
      _bunnies.add(bunny);
    }

    interface.addChild(layout, container);
  }

  eachFrameFunction([num v]) {
    if (shaderType == ShaderType.displacement) {
      moveSprite(
          interface, bunnyDisplacementBitmap, v, canvasWidth, canvasHeight);
    }
  }
}

num lastTime = 0.0, dirX = 1.0, dirY = 0.5, speed = 100.0;
Random rand = new Random();
void moveSprite(
    ShaderInterface interface, var sprite, num time, int width, int height) {
  num deltaTime = (time - lastTime);
  if (deltaTime > 1.0) deltaTime = 1.0;
  lastTime = time;

  num currentX = interface.getX(sprite);
  num currentY = interface.getY(sprite);

  if (currentX > width) {
    dirX = -1.0 * rand.nextDouble();
  } else if (currentX < 0) {
    dirX = 1.0 * rand.nextDouble();
  }
  if (currentY > height) {
    dirY = -1.0 * rand.nextDouble();
  } else if (currentY < 0) {
    dirY = 1.0 * rand.nextDouble();
  }

  interface.setX(sprite, currentX + deltaTime * dirX * speed);
  interface.setY(sprite, currentY + deltaTime * dirY * speed);
}
