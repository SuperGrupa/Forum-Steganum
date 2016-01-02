stegano.algorithm.hiding = (function () {
    var image, secretText, usedPixels = [], callback;
    
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
    
    function _getNextPixel() {
        var randomPixel;
        image = stegano.module('image').getData();
        do {
            randomPixel = stegano.module('algorithm').random.get(0, image.width*image.height);
        } while (usedPixels.indexOf(randomPixel) !== -1);
        usedPixels.push(randomPixel);
        
        return randomPixel;
    }
    
    function _getNextBits(charCode, charPixelNumber) {
        // przesuń w lewo i pobierz 3 najmłodsze bity
        return ((charCode >> 3*charPixelNumber) & 0x7);
    }
    
    function _hide3Bits(data, pixelNum) {
        var x = pixelNum % image.width,
            y = Math.floor(pixelNum / image.width),
            pixel = stegano.module('image').getPixel(image, x, y),
            color = {
                r: (pixel.r & 0xFE) | ((data & 0x04) >> 2),
                g: (pixel.g & 0xFE) | ((data & 0x02) >> 1),
                b: (pixel.b & 0xFE) |  (data & 0x01)
            };
    
        stegano.module('image').setPixel(image, x, y, color);
    }
    
    function _hideText() {
        // ukrywamy ciąg zakończony zerem
        for (var i = 0, length = secretText.length; i <= length; ++i) {
            var letter = 0;
            if (i != length) {
                letter = secretText.charCodeAt(i);
            }
            
            // każdą literę ukrywamy na 6 pikselach (po 3 bity na piksel)
            for (var j = 0; j < 6; ++j) {
                var pixelNumber = _getNextPixel(),
                    nextBits = _getNextBits(letter, j);
            
                _hide3Bits(nextBits, pixelNumber);
            }
        }
    }
    
    function _hiding(imagePublicKey) {
        // przygotuj ziarno RNG i ustaw nim generator
        var seed = stegano.module('algorithm').prepareSeed(imagePublicKey, stegano.secretPassword());
        stegano.module('algorithm').random.seed(seed);

        _generateNoise();                   // szum na najmniej znaczących bitach
        _hideText();                        // ukrywanie tekstu

        stegano.module('image').save();     // zapis na canvas przekształconego obrazka

        usedPixels = [];                    // czyścimy po sobie

        var image = new FS.File(stegano.module('integration').getCanvas().toDataURL());
        image.metadata = {
            public_key: imagePublicKey
        };
        
        return image;
    }
    
    function _createImageWithHiddenContent() {
        Meteor.call('setImagePublicKey', function (error, result) {
            if (secretText != '') {
                // wykonuj ukrywanie wiadomości tylko jeśli jest coś do ukrycia
                var image = _hiding(result);
            } else {
                // nic nie rób, tylko utwórz plik z tego co jest na canvasie
                var image = new FS.File(stegano.module('integration').getCanvas().toDataURL());
            }
            
            image = Images.insert(image, function (error, fileobj) {
                if (error) {
                    alertsServ.error(error);
                }
                // nie udało się przesłać pliku - nie wysyłaj samej treści
                if (!image || !image._id) {
                    alertsServ.error('Nie udało się wysłać obrazka na serwer!');
                }
            });
            
            // wywołaj zdefiniowany w aplikacji callback kończący wysyłanie wiadomości,
            // dostarczając mu id obrazka
            callback(image._id);
            if (stegano.module('events').getViewMode() == 'Secret') {
                stegano.module('algorithm').retrieving(document.querySelector('img[data-image-id="'+ image._id +'"]'));
            }
        });
    }
    
    function run(secretToHide, cb) {
        callback = cb;
        
        // załadowanie nazwy pliku i obrazka na canvas
        var fileName = stegano.module('helpers').validation.fileNameFromInput();
        if (fileName) {
            secretText = secretToHide;
            stegano.module('image').loadFromFile(fileName, _createImageWithHiddenContent);
        }
    }
    
    return {
        run: run
    };
});
