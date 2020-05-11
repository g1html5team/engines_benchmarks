import '../../canvas.css';
import * as Toastr from 'toastr';
import { Benchmark } from '../lib/benchmark';
import { ShadersBenchmark } from '../lib/shaders/shaders_benchmark';
import { ShaderType } from '../lib/shaders/shader_type';
import { ShadersStepByStepBenchmark } from '../lib/shaders/shaders_step_by_step_benchmark';
import { ShadersAllBenchmark } from '../lib/shaders/shaders_all_benchmark';

const urlParams = new URLSearchParams(window.location.search);

const width = urlParams.has('cw') ? parseInt(urlParams.get('cw'), 10) : 1280;
const height = urlParams.has('ch') ? parseInt(urlParams.get('ch'), 10) : 720;

const numberOfObjects = urlParams.has('nbObj') ? parseInt(urlParams.get('nbObj'), 10) : 20;
const parentWindowTarget = urlParams.has('target') ? urlParams.get('target') : '';
const benchmarkId = urlParams.has('id') ? parseInt(urlParams.get('id'), 10) : 2;

let benchmark: Benchmark;

switch (benchmarkId) {
  case 1: {
    // Simple add benchmark
    benchmark = new ShadersBenchmark(width, height, numberOfObjects, ShaderType.Blur);
    benchmark.init().then(() => {
      benchmark.run().then((result) => {
        window.parent.postMessage(result.toString(), parentWindowTarget);
      });
    });
    break;
  }
  case 2: {
    // Simple add remove benchmark
    benchmark = new ShadersBenchmark(width, height, numberOfObjects, ShaderType.Glow);
    benchmark.init().then(() => {
      benchmark.run().then((result) => {
        window.parent.postMessage(result.toString(), parentWindowTarget);
      });
    });
    break;
  }
  case 3: {
    benchmark = new ShadersBenchmark(width, height, numberOfObjects, ShaderType.Displacement);
    benchmark.init().then(() => {
      benchmark.run().then((result) => {
        window.parent.postMessage(result.toString(), parentWindowTarget);
      });
    });
    break;
  }
  case 4: {
    benchmark = new ShadersStepByStepBenchmark(width, height, numberOfObjects);
    benchmark.init().then(() => {
      benchmark.run().then((result) => {
        window.parent.postMessage(result.toString(), parentWindowTarget);
      });
    });
    break;
  }
  case 5: {
    benchmark = new ShadersAllBenchmark(width, height, numberOfObjects);
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
