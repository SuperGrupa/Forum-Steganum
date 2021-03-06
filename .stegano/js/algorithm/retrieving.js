stegano.algorithm.retrieving = (function () {
    var MAX_SECRET_MESSAGE_LENGTH = 1000;       // robimy dla bezpieczeństwa limit długości tajnej wiadomości do 1000 znaków
    
    function _getNextPixel(usedPixels) {
        var randomPixel;
        
        var imageData = stegano.module('image').getData();
        do {
            randomPixel = stegano.module('algorithm').random.get(0, imageData.width*imageData.height);
        } while (usedPixels.indexOf(randomPixel) !== -1);
        usedPixels.push(randomPixel);
        
        return randomPixel;
    }
    
    function _decodeBitsFrom(pixelNum) {
        var imageData = stegano.module('image').getData();
        
        var x = pixelNum % imageData.width,
            y = Math.floor(pixelNum / imageData.width),
            pixel = stegano.module('image').getPixel(imageData, x, y);
    
        return ((pixel.r & 0x01) << 2) | ((pixel.g & 0x01) << 1) | (pixel.b & 0x01);
    }
    
    function _retrieving(imageElement) {
        var decodedText = '', security = 0, usedPixels = [];
        do {
            var decodedLetter = 0;
            for (var i = 0; i < 6; ++i) {
                var _nextPixel = _getNextPixel(usedPixels),
                    _nextDecodedBits = _decodeBitsFrom(_nextPixel);
            
                decodedLetter |= _nextDecodedBits << 3*i;
            }
            decodedText += String.fromCharCode(decodedLetter);
            ++security;
        } while (decodedLetter !== 0 && security < MAX_SECRET_MESSAGE_LENGTH);
        
        // podmień obrazek na zawarty w nim tekst
        var decodedTextElement = document.createElement('p');
        decodedTextElement.className = 'secret-text';
        decodedTextElement.appendChild(document.createTextNode(decodedText));
        
        imageElement.parentNode.insertBefore(decodedTextElement, imageElement);
    }
    
    // imageElement - musimy wiedzieć, z którego obrazka aktualnie wyciągamy treść
    function run(imageElement) {
        Meteor.call('getImagePublicKey', imageElement.dataset.imageId, function (error, result) {
            // wykryto obrazek bez ukrytej treści (bez klucza na serwerze)
            if (!result) {
                $(imageElement).closest('md-list-item').hide();
                return;
            }
            
            var seed = stegano.module('algorithm').prepareSeed(result, stegano.secretPassword());
            stegano.module('algorithm').random.seed(seed);
            stegano.module('image').loadFromImg(imageElement, _retrieving, [imageElement]);
        });
    }
    
    return {
        run: run
    };
});
