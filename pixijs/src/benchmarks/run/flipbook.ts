import '../../canvas.css';
import { FlipbookBenchmark } from '../lib/flipbook/filpbook';

const urlParams = new URLSearchParams(window.location.search);

const width = urlParams.has('cw') ? parseInt(urlParams.get('cw'), 10) : 1280;
const height = urlParams.has('ch') ? parseInt(urlParams.get('ch'), 10) : 720;

const parentWindowTarget = urlParams.has('target') ? urlParams.get('target') : '';

// Simple add benchmark
const benchmark = new FlipbookBenchmark(width, height);
benchmark.init().then(() => {
  benchmark.run().then((result) => {
    window.parent.postMessage(result.toString(), parentWindowTarget);
  });
});
