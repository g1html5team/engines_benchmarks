import '../../canvas.css';
import { RenderTextureBenchmark } from '../lib/render_texture/render_texture_benchmark';

const urlParams = new URLSearchParams(window.location.search);

const width = urlParams.has('cw') ? parseInt(urlParams.get('cw'), 10) : 1280;
const height = urlParams.has('ch') ? parseInt(urlParams.get('ch'), 10) : 720;

const parentWindowTarget = urlParams.has('target') ? urlParams.get('target') : '';

const benchmark = new RenderTextureBenchmark(width, height);
benchmark.init().then(() => {
  benchmark.run().then((result) => {
    window.parent.postMessage(result.toString(), parentWindowTarget);
  });
});
