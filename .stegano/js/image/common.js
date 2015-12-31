stegano.image = (function () {
    var submodules = { };
    
    (function () {
        submodules.loader = stegano.image.loader();
        submodules.access = stegano.image.access();
    })();
    
    return {
        loadFromFile: submodules.loader.loadImageFromFile,
        loadFromImg:  submodules.loader.loadImageFromImgElement,
        save: submodules.loader.saveImage,
        getData: submodules.loader.getImageData,
        getPixel: submodules.access.getPixel,
        setPixel: submodules.access.setPixel
    };
});
