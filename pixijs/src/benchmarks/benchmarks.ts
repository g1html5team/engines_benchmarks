import '../styles.css';
import './benchmarks.css';
import { v4 as uuidv4 } from 'uuid';
import Axios, { AxiosInstance } from 'axios';
import * as Toastr from 'toastr';
import 'toastr/build/toastr.min.css';
import { BenchmarkConfig } from './model/benchmark_info';

class Benchmarks {
  private readonly client: AxiosInstance = Axios.create();
  private readonly serverURL: string;
  private readonly config: BenchmarkConfig;
  private readonly runId: string = uuidv4();

  public constructor() {
    this.config = {
      target: window.location.href,
      userAgent: navigator.userAgent,
      serverIp: Benchmarks.getElementValue('ip'),
      serverPort: Benchmarks.getElementValue('port'),
      userName: Benchmarks.getElementValue('user'),
      device: Benchmarks.getElementValue('device'),
      runDuration: Benchmarks.getElementValue('duration'),
      canvasWidth: Benchmarks.getElementValue('width'),
      canvasHeight: Benchmarks.getElementValue('height'),
      runChildren: Benchmarks.getElementValue('children'),
      runLabels: Benchmarks.getElementValue('labels'),
      runFilters: Benchmarks.getElementValue('filters'),
      runMasks: Benchmarks.getElementValue('masks'),
      runBlendMode: Benchmarks.getElementValue('blend'),
      runGpuSlot: Benchmarks.getElementValue('gpu'),
      runAtlas: Benchmarks.getElementValue('atlas'),
      runFlipbook: Benchmarks.getElementValue('flipbook'),
      runParticles: Benchmarks.getElementValue('particles'),
      runRenderTexture: Benchmarks.getElementValue('texture'),
      runShader: Benchmarks.getElementValue('shader'),
      runSpine: Benchmarks.getElementValue('spine'),
      runVisibility: Benchmarks.getElementValue('visibility'),
      runZindex: Benchmarks.getElementValue('zindex'),
      runStageXl: '',
      runPixi: '',
      runNg1n: '',
    };

    this.serverURL = `http://${this.config.serverIp}:${this.config.serverPort}`;
  }

  private static getElementValue(elementId: string): string {
    const element = document.getElementById(elementId);
    if (element instanceof HTMLInputElement) {
      if (element.type === 'checkbox') {
        return element.checked.toString();
      }

      return element.value;
    }

    if (element instanceof HTMLSelectElement) {
      return element.options[element.selectedIndex].value;
    }

    return '';
  }

  public async run(): Promise<void> {
    try {
      const response = await this.client.post(
        `${this.serverURL}/api/config?id=${this.runId}`,
        JSON.stringify(this.config),
        { validateStatus: () => true },
      );

      if (response.status === 200) {
        // TODO (sch)
        Toastr.info(`${response.status} ${response.statusText}`);
      } else {
        Toastr.warning(response.data, `Error ${response.status} - ${response.statusText}`);
      }
    } catch (error) {
      Toastr.error(error.message, 'Server error');
    }
  }
}

function initForm(): void {
  document.getElementsByTagName('body')[0].classList.remove('preload');

  const checkboxes: NodeListOf<HTMLInputElement> = document.querySelectorAll('input[type=checkbox]');

  document.getElementById('toggle').onclick = (): void => {
    checkboxes.forEach((checkbox) => {
      checkbox.checked = !checkbox.checked;
    });
  };

  document.getElementById('check').onclick = (): void => {
    checkboxes.forEach((checkbox) => {
      checkbox.checked = true;
    });
  };

  document.getElementById('uncheck').onclick = (): void => {
    checkboxes.forEach((checkbox) => {
      checkbox.checked = false;
    });
  };

  document.getElementById('form').onsubmit = (event): void => {
    const benchmarks = new Benchmarks();
    benchmarks
      .run()
      .then(() => {
        Toastr.info('Benchmarks done');
      })
      .catch((reason) => {
        Toastr.error(reason);
      });
    event.preventDefault();
  };
}

window.onload = (): void => {
  initForm();
};
