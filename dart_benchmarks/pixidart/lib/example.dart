import 'dart:html' hide Point;
import 'package:pixi/pixi.dart';
import 'package:js/js.dart';
import 'package:pixi_dart_benchmark/spine/pixi_spine.dart';
import 'package:pixi_dart_benchmark/spine/spine_facade.dart';

class PixiDartExample {
  Application app = Application();
  Sprite sunshine = Sprite.fromImage('assets/sunshine.png');
  Loader loader = Loader();

  PixiDartExample() {

    document.body.append(app.view);


    //Sprite example

    this.sunshine
      ..anchor = Point(0.5, 0.5)
      ..position = Point(400, 300);

    app.stage.addChild(this.sunshine);
    app.ticker.add(allowInterop((_) => this.sunshine.rotation += 0.1));


    //Spine example
    loader.add('spineBoy', 'assets/spine/spineboy.json');

    loader.load(allowInterop((a, b) {
      Spine spineBoyPro = createSpine(loader, 'spineBoy');
      spineBoyPro.x = app.screen.width / 4;
      spineBoyPro.y = app.screen.height;

      spineBoyPro.scale.set(0.25);

      app.stage.addChild(spineBoyPro);

      spineBoyPro.state.setAnimationByName(0, "shoot", true);
      app.stage.addChild(spineBoyPro);
    }));
  }
}
