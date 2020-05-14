import '../../canvas.css';
import * as Toastr from 'toastr';
import { Benchmark } from '../lib/benchmark';
import { OutOfSceneBenchmark } from '../lib/visibility/out_of_scene_benchmark';
import { VisibilityFalseBenchmark } from '../lib/visibility/visibility_false_benchmark';
import { AlphaBenchmark } from '../lib/visibility/alpha_benchmark';
import { MoveOutsideBenchmark } from '../lib/visibility/move_outside_benchmark';
import { ScaleBenchmark } from '../lib/visibility/scale_benchmark';

const urlParams = new URLSearchParams(window.location.search);

const width = urlParams.has('cw') ? parseInt(urlParams.get('cw'), 10) : 1280;
const height = urlParams.has('ch') ? parseInt(urlParams.get('ch'), 10) : 720;

const numberOfObjects = urlParams.has('nbObj') ? parseInt(urlParams.get('nbObj'), 10) : 150;
const parentWindowTarget = urlParams.has('target') ? urlParams.get('target') : '';
const benchmarkId = urlParams.has('id') ? parseInt(urlParams.get('id'), 10) : 4;

let benchmark: Benchmark;

switch (benchmarkId) {
  case 1: {
    // Simple add benchmark
    benchmark = new OutOfSceneBenchmark(width, height, numberOfObjects);
    benchmark.init().then(() => {
      benchmark.run().then((result) => {
        window.parent.postMessage(result.toString(), parentWindowTarget);
      });
    });
    break;
  }
  case 2: {
    // Simple add remove benchmark
    benchmark = new VisibilityFalseBenchmark(width, height, numberOfObjects);
    benchmark.init().then(() => {
      benchmark.run().then((result) => {
        window.parent.postMessage(result.toString(), parentWindowTarget);
      });
    });
    break;
  }
  case 3: {
    benchmark = new AlphaBenchmark(width, height, numberOfObjects);
    benchmark.init().then(() => {
      benchmark.run().then((result) => {
        window.parent.postMessage(result.toString(), parentWindowTarget);
      });
    });
    break;
  }
  case 4: {
    benchmark = new MoveOutsideBenchmark(width, height, numberOfObjects);
    benchmark.init().then(() => {
      benchmark.run().then((result) => {
        window.parent.postMessage(result.toString(), parentWindowTarget);
      });
    });
    break;
  }
  case 5: {
    benchmark = new ScaleBenchmark(width, height, numberOfObjects);
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
