stegano.algorithm.retrieving = (function () {
    var image, imageData, secretKey, usedPixels = [];
    
    function _getNextPixel() {
        var randomPixel,
            imageData = stegano.module('image').getData();
        do {
            randomPixel = stegano.module('algorithm').random.get(0, imageData.width*imageData.height);
        } while (usedPixels.indexOf(randomPixel) !== -1);
        usedPixels.push(randomPixel);
        
        return randomPixel;
    }
    
    function _decodeBitsFrom(pixelNum) {
        imageData = stegano.module('image').getData();
        
        var x = pixelNum % imageData.width,
            y = Math.floor(pixelNum / imageData.width),
            pixel = stegano.module('image').getPixel(imageData, x, y);
    
        // TO DO wyciąganie 3 bitów
    }
    
    function _retrieving() {
        do {
            var decodedLetter;
            for (var i = 0; i < 6; ++i) {
                var _nextPixel = _getNextPixel(),
                    _nextDecodedBits = _decodeBitsFrom(_nextPixel);
            
                // TODO łączenie kolejnych bitów w literę
            }
        } while (1);
    }
    
    // imageElement - musimy wiedzieć, z którego obrazka aktualnie wyciągamy treść
    function run(imageElement) {
        console.log('Retrieving');
        
        image = imageElement;
        secretKey = Meteor.call('getImageSeed');
        stegano.module('algorithm').random.seed(secretKey);
        stegano.module('image').loadFromImg(imageElement, _retrieving);
    }
    
    return {
        run: run
    };
});
