import 'dart:html';
import 'dart:math';
import 'package:stagexl_benchmark/benchmarks/common.dart';
import 'package:stagexl_benchmark/benchmarks/custom/add_remove_child/interfaces/common.dart';

class SimpleAddBenchmark implements BenchmarkBase {
  final int canvasWidth;
  final int canvasHeight;
  final AddRemoveInterface interface;
  final layout;
  final int nbOfObjects;
  Random rdm = new Random();
  List _bunnies = [];
  dynamic _container;

  SimpleAddBenchmark(this.interface, this.nbOfObjects, this.layout,
      this.canvasWidth, this.canvasHeight) {
    _container = interface.createContainer();
    var data = interface.createBitmapData(querySelector('#bunny'), 'bunny.png');

    for (int i = -1; ++i < nbOfObjects;) {
      var bunny = interface.createBitmap(data);
      _bunnies.add(bunny);
    }

    interface.addChild(layout, _container);
  }

  eachFrameFunction([num v]) async {
    for (var bunny in _bunnies) {
      await interface.addChild(_container, bunny);
      await interface.setX(bunny, rdm.nextInt(canvasWidth));
      await interface.setY(bunny, rdm.nextInt(canvasHeight));
    }
  }
}

class SimpleAddRemoveBenchmark implements BenchmarkBase {
  final int canvasWidth;
  final int canvasHeight;
  final AddRemoveInterface interface;
  final layout;
  final int nbOfObjects;
  Random rdm = new Random();
  List _bunnies = [];
  List _removed = [];
  dynamic _container;

  SimpleAddRemoveBenchmark(this.interface, this.nbOfObjects, this.layout,
      this.canvasWidth, this.canvasHeight) {
    _container = interface.createContainer();
    var data = interface.createBitmapData(querySelector('#bunny'), 'bunny.png');
    for (int i = -1; ++i < nbOfObjects;) {
      var bunny = interface.createBitmap(data);
      interface.addChild(_container, bunny);
      interface.setX(bunny, rdm.nextInt(canvasWidth));
      interface.setY(bunny, rdm.nextInt(canvasHeight));
      interface.setRotation(bunny, rdm.nextDouble() * pi);
      interface.centerPivot(bunny);
      _bunnies.add(bunny);
    }

    interface.addChild(layout, _container);
  }

  bool _drawNow = false;

  eachFrameFunction([num v]) {
    if (_removed.isEmpty && _container.children.length > 0) {
      for (var bunny in _bunnies) {
        interface.removeChild(_container, bunny);
        _removed.add(bunny);
      }
    } else {
      if (_drawNow) {
        _drawNow = false;
      } else {
        for (var bunny in _removed) {
          interface.addChild(_container, bunny);
          interface.setX(bunny, rdm.nextInt(canvasWidth));
          interface.setY(bunny, rdm.nextInt(canvasHeight));
          interface.setRotation(bunny, rdm.nextDouble() * pi);
        }
        _drawNow = true;
        _removed.clear();
      }
    }
  }
}

class AddRemoveContainerBenchmark implements BenchmarkBase {
  final int canvasWidth;
  final int canvasHeight;
  final AddRemoveInterface interface;
  final layout;
  final int nbOfObjects;
  Random rdm = new Random();
  dynamic _container1;
  dynamic _container2;
  bool hasContainer1;

  AddRemoveContainerBenchmark(this.interface, this.nbOfObjects, this.layout,
      this.canvasWidth, this.canvasHeight) {
    _container1 = interface.createContainer();
    _container2 = interface.createContainer();
    var data = interface.createBitmapData(querySelector('#bunny'), 'bunny.png');
    for (int i = -1; ++i < nbOfObjects;) {
      var bunny = interface.createBitmap(data);
      interface.setX(bunny, rdm.nextInt(canvasWidth));
      interface.setY(bunny, rdm.nextInt(canvasHeight));
      interface.addChild(_container1, bunny);
      interface.addChild(_container2, bunny);
    }

    interface.addChild(layout, _container1);
    hasContainer1 = true;
  }

  eachFrameFunction([num v]) {
    if (hasContainer1) {
      hasContainer1 = false;
      interface.removeChild(layout, _container1);
      interface.addChild(layout, _container2);
      _container1 = interface.createContainer();

      for (int i = -1; ++i < nbOfObjects;) {
        var data =
            interface.createBitmapData(querySelector('#bunny'), 'bunny.png');
        var bunny = interface.createBitmap(data);
        interface.setX(bunny, rdm.nextInt(canvasWidth));
        interface.setY(bunny, rdm.nextInt(canvasHeight));
        interface.addChild(_container2, bunny);
      }
    } else {
      hasContainer1 = true;
      interface.removeChild(layout, _container2);
      interface.addChild(layout, _container1);
      _container2 = interface.createContainer();

      for (int i = -1; ++i < nbOfObjects;) {
        var data =
            interface.createBitmapData(querySelector('#bunny'), 'bunny.png');
        var bunny = interface.createBitmap(data);
        interface.setX(bunny, rdm.nextInt(canvasWidth));
        interface.setY(bunny, rdm.nextInt(canvasHeight));
        interface.addChild(_container1, bunny);
      }
    }
  }
}
