stegano.algorithm.hiding = (function () {
    var image, secretText, randomGeneratorSeed;
    
    function _generateNoise() {       
        image = stegano.module('image').getData();
        var width = image.width,
            height = image.height;
        
        for (var i = 0; i < height; ++i) {
            for (var j = 0; j < width; ++j) {
                var r = (Math.random()*2) | 0,
                    g = (Math.random()*2) | 0,
                    b = (Math.random()*2) | 0,
                    pixel = stegano.module('image').getPixel(image, j, i);
                
                pixel.r = (pixel.r & 0xFE) | r;
                pixel.g = (pixel.g & 0xFE) | g;
                pixel.b = (pixel.b & 0xFE) | b;

                stegano.module('image').setPixel(image, j, i, pixel);
            }
        }
    }
    
    function _hide3Bits(data, pixelNum) {
        var x = pixelNum % image.width,
            y = pixelNum / image.height,
            pixel = stegano.module('image').getPixel(image, x, y),
            color = {
                r: (pixel.r & 0xFE) | ((data & 0x04) >> 2),
                g: (pixel.g & 0xFE) | ((data & 0x02) >> 1),
                b: (pixel.b & 0xFE) |  (data & 0x01)
            };
    
        stegano.module('image').setPixel(image, x, y, color);
    }
    
    function _hideText() {
        
    }
    
    function _hiding() {
        _generateNoise();
        _hideText();
        
        stegano.module('image').save();
    }
    
    function run(secretToHide) {
        console.log('Hiding');
        
        // załadowanie nazwy pliku i obrazka na canvas
        var fileName = stegano.module('helpers').validation.fileNameFromInput();
        if (fileName) {
            secretText = secretToHide;
            stegano.module('image').load(fileName, _hiding);
        }
    }
    
    return {
        run: run
    };
});
