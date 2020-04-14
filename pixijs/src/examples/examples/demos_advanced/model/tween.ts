// Very simple tweening utility functions. This should be replaced with a proper tweening library in a real product.
export class TweenUtils {
  // Basic lerp funtion.
  public static lerp(a1: number, a2: number, t: number): number {
    return a1 * (1 - t) + a2 * t;
  }

  // Backout function from tweenjs.
  // https://github.com/CreateJS/TweenJS/blob/master/src/tweenjs/Ease.js
  public static backout(amount: number): Function {
    // eslint-disable-next-line no-param-reassign
    return (t: number): number => --t * t * ((amount + 1) * t + amount) + 1;
  }
}

export interface Tween<T> {
  object: T;
  property: keyof T;
  propertyBeginValue: number;
  target: number;
  time: number;
  easing: Function;
  onchange: Function;
  oncomplete: Function;
  start: number;
}
