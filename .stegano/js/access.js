stegano.access = (function () {
    var imageDimensions;
    
    function getPixel(x, y) {
        // jeśli wykroczono poza zakres
        if (x > imageDimensions.width || y > imageDimensions.height) {
            throw "Arguments out of image dimensions";
        }
        
        // za każdym razem data może być inna
        var data = stegano.module('integration').getImageData().data,
            baseIndex = imageDimensions.width*y + x,
            color = {
                r: data[baseIndex + 0],
                g: data[baseIndex + 1],
                b: data[baseIndex + 2],
                a: data[baseIndex + 3]
            };
    
        return color;
    }
    
    function setPixel(x, y, color) {
        if (!color) {
            throw "None color to set specified";
        }
        
        var data = stegano.module('integration').getImageData().data,
            baseIndex = imageDimensions.width*y + x;
        data[baseIndex + 0] = color.r;
        data[baseIndex + 1] = color.g;
        data[baseIndex + 2] = color.b;
        data[baseIndex + 3] = color.a;
    }
    
    // taki jakby konstruktor, wywoływany automatycznie kiedy wywoływana jest funkcja stegano.access
    // funkcja w tzw. domknięciu ()
    (function () {
        var imageData = stegano.module('integration').getImageData();
        imageDimensions = {
            width: imageData.width,
            height: imageData.height
        };
    })();
    
    return {
        getPixel: getPixel,
        setPixel: setPixel
    };
});
