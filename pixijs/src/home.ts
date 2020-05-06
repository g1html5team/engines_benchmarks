import './styles.css';

window.onload = (): void => {
  document.getElementsByTagName('body')[0].classList.remove('preload');
};

document.getElementById('examples').onclick = (): void => {
  window.location.href = 'examples/index.html';
};

document.getElementById('benchmarks').onclick = (): void => {
  window.location.href = 'benchmarks/index.html';
};
