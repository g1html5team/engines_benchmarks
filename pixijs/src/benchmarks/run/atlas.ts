import '../../canvas.css';
import * as Toastr from 'toastr';
import { Benchmark } from '../lib/benchmark';
import { NoAtlasAddChild } from '../lib/atlas/no_atlas_add_child';
import { NoAtlasOneSprite } from '../lib/atlas/no_atlas_one_sprite';
import { NoAtlas100Sprites } from '../lib/atlas/no_atlas_100_sprites';
import { AtlasAddChild } from '../lib/atlas/atlas_add_child';
import { AtlasOneSprite } from '../lib/atlas/atlas_one_sprite';
import { Atlas100Sprites } from '../lib/atlas/atlas_100_sprites';
import { TwoAtlasesAddChild } from '../lib/atlas/two_atlasses_add_child';
import { TwoAtlasesOneSprite } from '../lib/atlas/two_atlases_one_sprite';
import { TwoAtlases100Sprites } from '../lib/atlas/two_atlases_100_sprites';
import { ThreeAtlasesAddChild } from '../lib/atlas/three_atlasses_add_child';
import { ThreeAtlasesOneSprite } from '../lib/atlas/three_atlases_one_sprite';
import { ThreeAtlases100Sprites } from '../lib/atlas/three_atlases_100_sprites';

const urlParams = new URLSearchParams(window.location.search);

const width = urlParams.has('cw') ? parseInt(urlParams.get('cw'), 10) : 1280;
const height = urlParams.has('ch') ? parseInt(urlParams.get('ch'), 10) : 720;

const numberOfObjects = urlParams.has('nbObj') ? parseInt(urlParams.get('nbObj'), 10) : 1;
const parentWindowTarget = urlParams.has('target') ? urlParams.get('target') : '';
const benchmarkId = urlParams.has('id') ? parseInt(urlParams.get('id'), 10) : 4;

let benchmark: Benchmark;

switch (benchmarkId) {
  case 1: {
    // Simple add benchmark
    benchmark = new NoAtlasAddChild(width, height, numberOfObjects);
    benchmark.init().then(() => {
      benchmark.run().then((result) => {
        window.parent.postMessage(result.toString(), parentWindowTarget);
      });
    });
    break;
  }
  case 2: {
    // Simple add remove benchmark
    benchmark = new NoAtlasOneSprite(width, height, numberOfObjects);
    benchmark.init().then(() => {
      benchmark.run().then((result) => {
        window.parent.postMessage(result.toString(), parentWindowTarget);
      });
    });
    break;
  }
  case 3: {
    benchmark = new NoAtlas100Sprites(width, height, numberOfObjects);
    benchmark.init().then(() => {
      benchmark.run().then((result) => {
        window.parent.postMessage(result.toString(), parentWindowTarget);
      });
    });
    break;
  }
  case 4: {
    benchmark = new AtlasAddChild(width, height, numberOfObjects);
    benchmark.init().then(() => {
      benchmark.run().then((result) => {
        window.parent.postMessage(result.toString(), parentWindowTarget);
      });
    });
    break;
  }
  case 5: {
    benchmark = new AtlasOneSprite(width, height, numberOfObjects);
    benchmark.init().then(() => {
      benchmark.run().then((result) => {
        window.parent.postMessage(result.toString(), parentWindowTarget);
      });
    });
    break;
  }
  case 6: {
    benchmark = new Atlas100Sprites(width, height, numberOfObjects);
    benchmark.init().then(() => {
      benchmark.run().then((result) => {
        window.parent.postMessage(result.toString(), parentWindowTarget);
      });
    });
    break;
  }
  case 7: {
    benchmark = new TwoAtlasesAddChild(width, height, numberOfObjects);
    benchmark.init().then(() => {
      benchmark.run().then((result) => {
        window.parent.postMessage(result.toString(), parentWindowTarget);
      });
    });
    break;
  }
  case 8: {
    benchmark = new TwoAtlasesOneSprite(width, height, numberOfObjects);
    benchmark.init().then(() => {
      benchmark.run().then((result) => {
        window.parent.postMessage(result.toString(), parentWindowTarget);
      });
    });
    break;
  }
  case 9: {
    benchmark = new TwoAtlases100Sprites(width, height, numberOfObjects);
    benchmark.init().then(() => {
      benchmark.run().then((result) => {
        window.parent.postMessage(result.toString(), parentWindowTarget);
      });
    });
    break;
  }
  case 10: {
    benchmark = new ThreeAtlasesAddChild(width, height, numberOfObjects);
    benchmark.init().then(() => {
      benchmark.run().then((result) => {
        window.parent.postMessage(result.toString(), parentWindowTarget);
      });
    });
    break;
  }
  case 11: {
    benchmark = new ThreeAtlasesOneSprite(width, height, numberOfObjects);
    benchmark.init().then(() => {
      benchmark.run().then((result) => {
        window.parent.postMessage(result.toString(), parentWindowTarget);
      });
    });
    break;
  }
  case 12: {
    benchmark = new ThreeAtlases100Sprites(width, height, numberOfObjects);
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
