stegano.algorithm.hiding = (function () {
    var image;
    
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
        
        stegano.module('image').save();
    }
    
    function _hiding() {
        _generateNoise();
    }
    
    function run() {
        console.log('Hiding');
        
        // załadowanie nazwy pliku i obrazka na canvas
        var fileName = stegano.module('helpers').validation.fileNameFromInput();
        if (fileName) {
            stegano.module('image').load(fileName, _hiding);
        }
    }
    
    return {
        run: run
    };
});
