stegano.image = (function () {
    var submodules = { };
    
    (function () {
        submodules.loader = stegano.image.loader();
        submodules.access = stegano.image.access();
    })();
    
    return {
        load: submodules.loader.loadImage,
        getData: submodules.loader.getImageData,
        getPixel: submodules.access.getPixel,
        setPixel: submodules.access.setPixel
    };
});
