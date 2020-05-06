
import 'package:pixi_dart_benchmark/interfaces/common.dart';

abstract class ShapeInterface extends Interface {
  createShape(num width, num height);
  beginPath(covariant object, int color);
  closePath(covariant object);
  moveTo(covariant object, num x, num y);
  lineTo(covariant object, num x, num y);
  arcTo(covariant object, num controlX, num controlY, num endX, num endY,
      num radius);
  quadraticCurveTo(
      covariant object, num controlX, num controlY, num endX, num endY);
  bezierCurveTo(covariant object, num controlX1, num controlY1, num controlX2,
      num controlY2, num endX, num endY);
  rect(covariant object, num x, num y, num width, num height);
  rectRound(covariant object, num x, num y, num width, num height,
      num ellipseWidth, num ellipseHeight);
  arc(covariant object, num x, num y, num radius, num startAngle, num endAngle,
      [bool antiClockwise = false]);
  circle(covariant object, num x, num y, num radius,
      [bool antiClockwise = false]);
  ellipse(covariant object, num x, num y, num width, num height);
  fillColor(covariant object, int color);
}
