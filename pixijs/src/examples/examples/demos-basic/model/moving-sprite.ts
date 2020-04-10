import * as PIXI from 'pixi.js';

export class MovingSprite extends PIXI.Sprite {
    direction: number;
    turningSpeed: number;
    speed: number;
    offset: number;
}