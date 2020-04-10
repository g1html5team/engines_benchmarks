import * as PIXI from 'pixi.js';

export interface MovingSprite extends PIXI.Sprite {
  direction: number;
  turningSpeed: number;
  speed: number;
  offset: number;
}
