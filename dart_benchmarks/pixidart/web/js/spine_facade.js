function createSpine(loader, name){
    return  new PIXI.spine.Spine(loader.resources[name].spineData);
}
function getTextureAtlas(textures){
    var atlas = new PIXI.spine.TextureAtlas();

    atlas.addTextureHash(textures, true);
    return atlas;
}

function getTextureFrom(name){
    return PIXI.Texture.from(name);
}

function loaderAddSkeletonDataWithExistingAtlas(loader, name, json, atlas){
    loader.add(name, json, {metadata: {spineAtlas: atlas}});
}
