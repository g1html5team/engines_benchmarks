
import 'package:pixi/pixi.dart';
import 'package:pixi_dart_benchmark/benchmarks/custom/shape/interfaces/common.dart';
import 'package:pixi_dart_benchmark/interfaces/pixi.dart';

class PixiShapeInterface extends PixiInterface implements ShapeInterface {
  PixiShapeInterface();

  createShape(num width, num height) {
    return new Graphics();
  }

  beginPath(Graphics object, int color) {
    object.beginFill(color);
  }

  closePath(Graphics object) {
    object.endFill();
  }

  moveTo(Graphics object, num x, num y) {
    object.moveTo(x, y);
  }

  lineTo(Graphics object, num x, num y) {
    object.lineTo(x, y);
  }

  arcTo(Graphics object, num controlX, num controlY, num endX, num endY,
      num radius) {
    object.arcTo(controlX, controlY, endX, endY, radius);
  }

  quadraticCurveTo(
      Graphics object, num controlX, num controlY, num endX, num endY) {
    object.quadraticCurveTo(controlX, controlY, endX, endY);
  }

  bezierCurveTo(Graphics object, num controlX1, num controlY1, num controlX2,
      num controlY2, num endX, num endY) {
    object.bezierCurveTo(
        controlX1, controlY1, controlX2, controlY2, endX, endY);
  }

  rect(Graphics object, num x, num y, num width, num height) {
    object.drawRect(x, y, width, height);
  }

  rectRound(Graphics object, num x, num y, num width, num height,
      num ellipseWidth, num ellipseHeight) {
    object.drawRoundedRect(x, y, width, height, ellipseWidth);
  }

  arc(Graphics object, num x, num y, num radius, num startAngle, num endAngle,
      [bool antiClockwise = false]) {
    object.arc(x, y, radius, startAngle, endAngle);
  }

  circle(Graphics object, num x, num y, num radius,
      [bool antiClockwise = false]) {
    object.drawCircle(x, y, radius);
  }

  ellipse(Graphics object, num x, num y, num width, num height) {
    object.drawEllipse(x, y, width, height);
  }

  fillColor(Graphics object, int color) {}
}
