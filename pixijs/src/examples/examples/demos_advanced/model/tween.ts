// Basic lerp funtion.
import { Reel } from './reel';

export class TweenUtils {
  public static lerp(a1: number, a2: number, t: number): number {
    return a1 * (1 - t) + a2 * t;
  }

  // Backout function from tweenjs.
  // https://github.com/CreateJS/TweenJS/blob/master/src/tweenjs/Ease.js
  public static backout(amount: number): Function {
    // eslint-disable-next-line no-param-reassign
    return (t: number): number => --t * t * ((amount + 1) * t + amount) + 1;
  }

  // Very simple tweening utility function. This should be replaced with a proper tweening library in a real product.
  public static tweenTo(
    object: Reel,
    property: string,
    target: number,
    time: number,
    easing: Function,
    onchange: Function,
    oncomplete: Function,
  ): Tween {
    return {
      object,
      property,
      // eslint-disable-next-line @typescript-eslint/no-explicit-any
      propertyBeginValue: (object as any)[property],
      target,
      easing,
      time,
      change: onchange,
      complete: oncomplete,
      start: Date.now(),
    };
  }
}

export interface Tween {
  object: Reel;
  property: string;
  propertyBeginValue: number;
  target: number;
  easing: Function;
  time: number;
  change: Function;
  complete: Function;
  start: number;
}
