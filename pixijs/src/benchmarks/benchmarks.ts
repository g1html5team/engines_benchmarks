import '../styles.css';
import './benchmarks.css';
import { v4 as uuidv4 } from 'uuid';
import Axios, { AxiosInstance, AxiosResponse } from 'axios';
import * as Toastr from 'toastr';
import 'toastr/build/toastr.min.css';
import { BenchmarkConfig } from './model/benchmark_config';
import { ConfigResponse } from './model/response';

declare const RENDERER: string;

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
      children: Benchmarks.getElementValue('children'),
      labels: Benchmarks.getElementValue('labels'),
      filter: Benchmarks.getElementValue('filters'),
      masks: Benchmarks.getElementValue('masks'),
      blend: Benchmarks.getElementValue('blend'),
      gpu: Benchmarks.getElementValue('gpu'),
      atlas: Benchmarks.getElementValue('atlas'),
      flipbook: Benchmarks.getElementValue('flipbook'),
      particles: Benchmarks.getElementValue('particles'),
      render_texture: Benchmarks.getElementValue('texture'),
      shader: Benchmarks.getElementValue('shader'),
      spine: Benchmarks.getElementValue('spine'),
      visibility: Benchmarks.getElementValue('visibility'),
      zindex: Benchmarks.getElementValue('zindex'),
      stagexl: 'false',
      ng1n: 'false',
      'pixi-dart1-internal': 'true',
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
      const response: AxiosResponse = await this.client.post(
        `${this.serverURL}/api/config?id=${this.runId}`,
        JSON.stringify(this.config),
        { validateStatus: () => true },
      );

      if (response.status === 200) {
        // Display result URL
        const resultRawUrl = `http://${this.config.serverIp}:8080/result_view.html?id=${this.runId}`;
        console.log(`Result viewer: ${resultRawUrl}`); // TODO (sch) display result url in page instead of console

        // Hide form
        document.getElementById('benchmark-form').classList.add('hidden');

        // Show iframe
        document.getElementById('iframe-container').classList.remove('hidden');

        let lastResponse = response as AxiosResponse<ConfigResponse>;

        while (lastResponse.status === 200) {
          const capturedWindow = window;
          const { data } = lastResponse;
          const subtitle = document.querySelector('.benchmarks-subtitle');
          subtitle.classList.remove('hidden');
          subtitle.textContent = `${data.engine.toUpperCase()} (${RENDERER}) - ${data.step} - ${data.parameter}`;

          // Create iframe
          // We don't use data.baseUrl as it points to server and then would serve original benchmarks
          let uri = `${data.path}?`;
          Object.keys(data).forEach((dataKey: keyof ConfigResponse) => {
            if (dataKey !== 'baseUrl' && dataKey !== 'path') {
              uri += `${dataKey}=${data[dataKey]}&`;
            }
          });
          uri = encodeURI(uri.substring(0, uri.length - 1));

          const iframeContainer = document.getElementById('iframe-container');
          const iframes = iframeContainer.querySelectorAll('iframe');
          for (let i = 0; i < iframes.length; i++) {
            iframes[i].parentNode.removeChild(iframes[i]);
          }

          const iframe = document.createElement('iframe');
          iframe.width = data.cw.toString();
          iframe.height = data.ch.toString();
          iframeContainer.appendChild(iframe);

          iframe.src = uri.substring(1);

          const resultPromise = new Promise<string>((resolve) => {
            capturedWindow.addEventListener('message', (event) => {
              resolve(JSON.parse(event.data));
            });
          });

          const result = await resultPromise;
          lastResponse = await this.client.post(
            `${this.serverURL}/api/next?id=${this.runId}`,
            JSON.stringify({
              result,
              response: lastResponse.data,
            }),
          );
        }
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

  document.getElementById('benchmark-form').onsubmit = (event): void => {
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
