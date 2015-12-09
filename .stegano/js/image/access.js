stegano.image.access = (function () {
    function getPixel(image, x, y) {
        // jeśli wykroczono poza zakres
        if (x > image.width || y > image.height) {
            throw "Arguments out of image dimensions";
        }
        
        // za każdym razem data może być inna
        var data = image.data,
            baseIndex = image.width*y + x,
            color = {
                r: data[baseIndex + 0],
                g: data[baseIndex + 1],
                b: data[baseIndex + 2],
                a: data[baseIndex + 3]
            };
    
        return color;
    }
    
    function setPixel(image, x, y, color) {
        if (!color) {
            throw "None color to set specified";
        }
        
        var data = image.data,
            baseIndex = image.width*y + x;
        data[baseIndex + 0] = color.r;
        data[baseIndex + 1] = color.g;
        data[baseIndex + 2] = color.b;
        data[baseIndex + 3] = color.a;
    }
        
    return {
        getPixel: getPixel,
        setPixel: setPixel
    };
});
