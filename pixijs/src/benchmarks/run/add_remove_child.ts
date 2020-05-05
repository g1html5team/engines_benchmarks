import '../../canvas.css';
import * as Toastr from 'toastr';
import { SimpleAddBenchmark } from '../lib/simple_add_benchmark';
import { Benchmark } from '../lib/benchmark';
import { SimpleAddRemoveBenchmark } from '../lib/simple_add_remove_benchmark';
import { AddRemoveContainerBenchmark } from '../lib/add_remove_container_benchmark';

const urlParams = new URLSearchParams(window.location.search);

const width = urlParams.has('cw') ? parseInt(urlParams.get('cw'), 10) : 1280;
const height = urlParams.has('ch') ? parseInt(urlParams.get('ch'), 10) : 720;

const numberOfObjects = urlParams.has('nbObj') ? parseInt(urlParams.get('nbObj'), 10) : 300;
const parentWindowTarget = urlParams.has('target') ? urlParams.get('target') : '';
const benchmarkId = urlParams.has('id') ? parseInt(urlParams.get('id'), 10) : 1;

let benchmark: Benchmark;

switch (benchmarkId) {
  case 1: {
    // Simple add benchmark
    benchmark = new SimpleAddBenchmark(width, height, numberOfObjects);
    benchmark.init().then(() => {
      benchmark.run().then((result) => {
        window.parent.postMessage(result.toString(), parentWindowTarget);
      });
    });
    break;
  }
  case 2: {
    // Simple add remove benchmark
    benchmark = new SimpleAddRemoveBenchmark(width, height, numberOfObjects);
    benchmark.init().then(() => {
      benchmark.run().then((result) => {
        window.parent.postMessage(result.toString(), parentWindowTarget);
      });
    });
    break;
  }
  case 3: {
    benchmark = new AddRemoveContainerBenchmark(width, height, numberOfObjects);
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
