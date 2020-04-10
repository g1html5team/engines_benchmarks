import * as PIXI from 'pixi.js';
import '../styles.css';
import BgGrass from '../assets/bg_grass.jpg';

const app = new PIXI.Application({
    width: 800, height: 600, backgroundColor: 0x1099bb,
});
document.body.appendChild(app.view);

app.loader
    .add('bg_grass', BgGrass)
    .load(build);

function build() {
    // Create a new texture
    const texture = app.loader.resources.bg_grass.texture;

    // Create the simple plane
    const verticesX = 10;
    const verticesY = 10;
    const plane = new PIXI.SimplePlane(texture, verticesX, verticesY);

    plane.x = 100;
    plane.y = 100;

    app.stage.addChild(plane);

    // Get the buffer for vertice positions.
    const buffer = plane.geometry.getBuffer('aVertexPosition');
    const bufferData = buffer.data as any;

    // Listen for animate update
    app.ticker.add(() => {
        // Randomize the vertices positions a bit to create movement.
        for (let i = 0; i < bufferData.length; i++) {
            bufferData[i] += (Math.random() - 0.5);
        }
        buffer.update();
    });
}