stegano.image = (function () {
    var submodules = { };
    
    (function () {
        submodules.loader = stegano.image.loader();
        submodules.access = stegano.image.access();
    })();
});
