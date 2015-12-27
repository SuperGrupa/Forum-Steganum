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
    
        return (pixel.r & 0x01) | (pixel.g & 0x02) | (pixel.b & 0x04);
    }
    
    function _retrieving() {
        var decodedText = '', sec = 0;
        
        do {
            var decodedLetter = 0;
            for (var i = 0; i < 6; ++i) {
                var _nextPixel = _getNextPixel(),
                    _nextDecodedBits = _decodeBitsFrom(_nextPixel);
            
                console.log(_nextDecodedBits);
                decodedLetter |= _nextDecodedBits << 3*i;
            }
            
            decodedText += String.fromCharCode(decodedLetter);
            ++sec;
        } while (decodedLetter !== 0 && sec < 1000);
        
        console.log(decodedText);
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
