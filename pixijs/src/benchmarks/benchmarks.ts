import '../styles.css';
import './benchmarks.css';
import { BenchmarkConfig } from './model/benchmark_info';

window.onload = (): void => {
  document.getElementsByTagName('body')[0].classList.remove('preload');
};

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

function getElementValue(elementId: string): string {
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

function initConfig(): BenchmarkConfig {
  return {
    target: window.location.href,
    userAgent: navigator.userAgent,
    serverIp: getElementValue('ip'),
    serverPort: getElementValue('port'),
    userName: getElementValue('user'),
    device: getElementValue('device'),
    runDuration: getElementValue('duration'),
    canvasWidth: getElementValue('width'),
    canvasHeight: getElementValue('height'),
    runChildren: getElementValue('children'),
    runLabels: getElementValue('labels'),
    runFilters: getElementValue('filters'),
    runMasks: getElementValue('masks'),
    runBlendMode: getElementValue('blend'),
    runGpuSlot: getElementValue('gpu'),
    runAtlas: getElementValue('atlas'),
    runFlipbook: getElementValue('flipbook'),
    runParticles: getElementValue('particles'),
    runRenderTexture: getElementValue('texture'),
    runShader: getElementValue('shader'),
    runSpine: getElementValue('spine'),
    runVisibility: getElementValue('visibility'),
    runZindex: getElementValue('zindex'),
    runStageXl: '',
    runPixi: '',
    runNg1n: '',
  };
}

document.getElementById('form').onsubmit = (event): void => {
  // TODO
  initConfig();
  event.preventDefault();
};
