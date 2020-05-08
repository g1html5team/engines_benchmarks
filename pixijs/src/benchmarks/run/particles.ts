import '../../canvas.css';
import * as Toastr from 'toastr';
import { Benchmark } from '../lib/benchmark';
import { AddRemoveContainerBenchmark } from '../lib/add_remove/add_remove_container_benchmark';
import { ParticlesBrightnessBenchmark } from '../lib/particles/particles_brightness_benchmark';
import { ParticlesBenchmark } from '../lib/particles/particles_benchmark';

const urlParams = new URLSearchParams(window.location.search);

const width = urlParams.has('cw') ? parseInt(urlParams.get('cw'), 10) : 1280;
const height = urlParams.has('ch') ? parseInt(urlParams.get('ch'), 10) : 720;

const numberOfObjects = urlParams.has('nbObj') ? parseInt(urlParams.get('nbObj'), 10) : 20;
const parentWindowTarget = urlParams.has('target') ? urlParams.get('target') : '';
const benchmarkId = urlParams.has('id') ? parseInt(urlParams.get('id'), 10) : 2;

let benchmark: Benchmark;

switch (benchmarkId) {
  case 1: {
    // Particles brightness benchmark
    benchmark = new ParticlesBrightnessBenchmark(width, height, numberOfObjects);
    benchmark.init().then(() => {
      benchmark.run().then((result) => {
        window.parent.postMessage(result.toString(), parentWindowTarget);
      });
    });
    break;
  }
  case 2: {
    // Particles benchmark
    // TODO (sch) this is not implemented
    benchmark = new ParticlesBenchmark(width, height, numberOfObjects);
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
