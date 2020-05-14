import '../../canvas.css';
import { SpineBenchmark } from '../lib/spine/spine_benchmark';

const urlParams = new URLSearchParams(window.location.search);

const width = urlParams.has('cw') ? parseInt(urlParams.get('cw'), 10) : 1280;
const height = urlParams.has('ch') ? parseInt(urlParams.get('ch'), 10) : 720;

const numberOfObjects = urlParams.has('nbObj') ? parseInt(urlParams.get('nbObj'), 10) : 20;
const numberOfDeformObjects = urlParams.has('nbDeformObj') ? parseInt(urlParams.get('nbDeformObj'), 10) : 10;
const parentWindowTarget = urlParams.has('target') ? urlParams.get('target') : '';

const benchmark = new SpineBenchmark(width, height, numberOfObjects, numberOfDeformObjects);
benchmark.init().then(() => {
  benchmark.run().then((result) => {
    window.parent.postMessage(result.toString(), parentWindowTarget);
  });
});
