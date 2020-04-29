import '../../canvas.css';
import * as PIXI from 'pixi.js';
import { UrlUtils } from '../utils/url_utils';

const canvasDimensions = UrlUtils.getDimensionsFromQueryParam(window.location.search);

const app = new PIXI.Application(canvasDimensions);

document.body.appendChild(app.view);
