import '../../canvas.css';
import * as Toastr from 'toastr';
import { Benchmark } from '../lib/benchmark';
import { ZIndexOneChildBenchmark } from '../lib/zindex/zindex_one_child_benchmark';
import { ZIndexRandomChildrenBenchmark } from '../lib/zindex/zindex_random_children_benchmark';
import { ZIndexMultipleTexturesBenchmark } from '../lib/zindex/zindex_multiple_textures_benchmark';

const urlParams = new URLSearchParams(window.location.search);

const width = urlParams.has('cw') ? parseInt(urlParams.get('cw'), 10) : 1280;
const height = urlParams.has('ch') ? parseInt(urlParams.get('ch'), 10) : 720;

const numberOfObjects = urlParams.has('nbObj') ? parseInt(urlParams.get('nbObj'), 10) : 150;
const parentWindowTarget = urlParams.has('target') ? urlParams.get('target') : '';
const benchmarkId = urlParams.has('id') ? parseInt(urlParams.get('id'), 10) : 1;

let benchmark: Benchmark;

switch (benchmarkId) {
  case 1: {
    // Simple add benchmark
    benchmark = new ZIndexOneChildBenchmark(width, height, numberOfObjects);
    benchmark.init().then(() => {
      benchmark.run().then((result) => {
        window.parent.postMessage(result.toString(), parentWindowTarget);
      });
    });
    break;
  }
  case 2: {
    // Simple add remove benchmark
    benchmark = new ZIndexRandomChildrenBenchmark(width, height, numberOfObjects);
    benchmark.init().then(() => {
      benchmark.run().then((result) => {
        window.parent.postMessage(result.toString(), parentWindowTarget);
      });
    });
    break;
  }
  case 3: {
    benchmark = new ZIndexMultipleTexturesBenchmark(width, height, numberOfObjects);
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
