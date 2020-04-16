import '../styles.css';
import './examples.css';

const gameLinks = document.body.getElementsByClassName('game-link');

let gameURL: string;

function generateIFrameContent(): void {
  // Remove all iFrames and content
  const iframes = document.querySelectorAll('iframe');
  for (let i = 0; i < iframes.length; i++) {
    iframes[i].parentNode.removeChild(iframes[i]);
  }

  // Create a new iframe
  const iframe = document.createElement('iframe');

  const gameContainer = document.getElementById('game-container');
  gameContainer.appendChild(iframe);

  iframe.src = gameURL;
}

function onClick(gameLink: Element): void {
  // Set game title
  const gameTitle = document.getElementById('game-title');
  gameTitle.innerText = gameLink.textContent;

  // Set list item selected
  for (let j = 0; j < gameLinks.length; j++) {
    gameLinks[j].classList.remove('selected');
  }
  gameLink.classList.add('selected');

  gameURL = `${gameLink.getAttribute('data-src')}.html`;
  generateIFrameContent();
}

for (let i = 0; i < gameLinks.length; i++) {
  const gameLink = gameLinks[i];
  gameLink.addEventListener('click', () => onClick(gameLink));
}
