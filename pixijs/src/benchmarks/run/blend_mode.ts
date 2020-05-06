import '../../canvas.css';
import * as Toastr from 'toastr';
import * as PIXI from 'pixi.js';
import { Benchmark } from '../lib/benchmark';
import { BlendModeBenchmark } from '../lib/blend_mode/blend_mode_benchmark';

const urlParams = new URLSearchParams(window.location.search);

const width = urlParams.has('cw') ? parseInt(urlParams.get('cw'), 10) : 1280;
const height = urlParams.has('ch') ? parseInt(urlParams.get('ch'), 10) : 720;

const numberOfObjects = urlParams.has('nbObj') ? parseInt(urlParams.get('nbObj'), 10) : 300;
const parentWindowTarget = urlParams.has('target') ? urlParams.get('target') : '';
const benchmarkId = urlParams.has('id') ? parseInt(urlParams.get('id'), 10) : 6;

let benchmark: Benchmark;

switch (benchmarkId) {
  case 1: {
    // Blend mode normal
    benchmark = new BlendModeBenchmark(width, height, numberOfObjects, PIXI.BLEND_MODES.NORMAL);
    benchmark.init().then(() => {
      benchmark.run().then((result) => {
        window.parent.postMessage(result.toString(), parentWindowTarget);
      });
    });
    break;
  }
  case 2: {
    // Blend mode add
    benchmark = new BlendModeBenchmark(width, height, numberOfObjects, PIXI.BLEND_MODES.ADD);
    benchmark.init().then(() => {
      benchmark.run().then((result) => {
        window.parent.postMessage(result.toString(), parentWindowTarget);
      });
    });
    break;
  }
  case 3: {
    // Blend mode multiply
    benchmark = new BlendModeBenchmark(width, height, numberOfObjects, PIXI.BLEND_MODES.MULTIPLY);
    benchmark.init().then(() => {
      benchmark.run().then((result) => {
        window.parent.postMessage(result.toString(), parentWindowTarget);
      });
    });
    break;
  }
  case 4: {
    // Blend mode overlay
    benchmark = new BlendModeBenchmark(width, height, numberOfObjects, PIXI.BLEND_MODES.OVERLAY);
    benchmark.init().then(() => {
      benchmark.run().then((result) => {
        window.parent.postMessage(result.toString(), parentWindowTarget);
      });
    });
    break;
  }
  case 5: {
    // Blend mode screen
    benchmark = new BlendModeBenchmark(width, height, numberOfObjects, PIXI.BLEND_MODES.SCREEN);
    benchmark.init().then(() => {
      benchmark.run().then((result) => {
        window.parent.postMessage(result.toString(), parentWindowTarget);
      });
    });
    break;
  }
  case 6: {
    // Blend mode random
    benchmark = new BlendModeBenchmark(width, height, numberOfObjects);
    benchmark.init().then(() => {
      benchmark.run().then((result) => {
        window.parent.postMessage(result.toString(), parentWindowTarget);
      });
    });
    break;
  }
  default: {
    Toastr.error('Invalid benchmark id');
    // TODO (sch) throw error
  }
}
