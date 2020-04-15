function createSpine(loader, name){
    return  new PIXI.spine.Spine(loader.resources[name].spineData);
}
