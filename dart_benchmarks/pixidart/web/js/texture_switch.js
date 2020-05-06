var loader = new PIXI.loaders.Loader();

function loadSprite(url, callback) {
    loader.add(url).load(callback);
}

function getSprite(url, img) {
    return new PIXI.Sprite(loader.resources[url].textures[img]);
}


