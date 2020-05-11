function createSpine(loader, name){
    return  new PIXI.spine.Spine(loader.resources[name].spineData);
}
function getTextureAtlas(textures){
    var atlas = new PIXI.spine.core.TextureAtlas();
    console.log(textures);

    var customSpineAtlas = {
        "images/game5/game5/carapace": (getTextureFrom("carapace")),
        "images/game5/game5/carapace_back": (getTextureFrom("carapaceBack")),
        "images/game5/game5/head": (getTextureFrom("head")),
        "images/game5/game5/mer": (getTextureFrom("mer")),
        "game5/game5/mer_top": (getTextureFrom("merTop")),
        "images/game5/game5/neck": (getTextureFrom("neck")),
        "images/game5/game5/patte_full": (getTextureFrom("patteFull")),
        "images/game5/game5/phyla_tortue": (getTextureFrom("phylaTortue")),
        "images/game5/game5/sable": (getTextureFrom("sable")),
        "images/game5/game5/sand": (getTextureFrom("sand")),
        "images/game5/game5/shadow": (getTextureFrom("shadow")),
        "images/game5/game5/shadow2": (getTextureFrom("shadow2")),
        "images/game5/game5/traces_eau": (getTextureFrom("tracesEau"))
    };


        atlas.addTextureHash(customSpineAtlas, false);
    return atlas;
}

function getTextureFrom(name){
    return PIXI.Texture.from(name);
}

function loaderAddSkeletonDataWithExistingAtlas(loader, name, json, atlas){
    loader.add(name, json, {metadata: {spineAtlas: atlas}});
}
