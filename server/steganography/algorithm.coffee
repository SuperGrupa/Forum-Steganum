module.exports "algorithm", content: """/*
 long.js (c) 2013 Daniel Wirtz <dcode@dcode.io>
 Released under the Apache License, Version 2.0
 see: https://github.com/dcodeIO/long.js for details
*/
(function(d,g){"function"===typeof define&&define.amd?define([],g):"function"===typeof require&&"object"===typeof module&&module&&module.exports?module.exports=g():(d.dcodeIO=d.dcodeIO||{}).Long=g()})(this,function(){function d(a,b,c){this.low=a|0;this.high=b|0;this.unsigned=!!c}function g(a){return!0===(a&&a.__isLong__)}function z(a,b){return b?0<=(a>>>=0)&&256>a:-128<=(a|=0)&&128>a}function m(a,b){var c,s;if(b){if(s=z(a>>>=0,!0))if(c=A[a])return c;c=e(a,0>(a|0)?-1:0,!0);s&&(A[a]=c)}else{if(s=z(a|=
0,!1))if(c=B[a])return c;c=e(a,0>a?-1:0,!1);s&&(B[a]=c)}return c}function n(a,b){if(isNaN(a)||!isFinite(a))return b?t:k;if(b){if(0>a)return t;if(a>=C)return D}else{if(a<=-E)return l;if(a+1>=E)return F}return 0>a?n(-a,b).neg():e(a%4294967296|0,a/4294967296|0,b)}function e(a,b,c){return new d(a,b,c)}function x(a,b,c){if(0===a.length)throw Error("empty string");if("NaN"===a||"Infinity"===a||"+Infinity"===a||"-Infinity"===a)return k;"number"===typeof b&&(c=b,b=!1);c=c||10;if(2>c||36<c)throw RangeError("radix");
var s;if(0<(s=a.indexOf("-")))throw Error("interior hyphen");if(0===s)return x(a.substring(1),b,c).neg();s=n(v(c,8));for(var e=k,f=0;f<a.length;f+=8){var d=Math.min(8,a.length-f),g=parseInt(a.substring(f,f+d),c);8>d?(d=n(v(c,d)),e=e.mul(d).add(n(g))):(e=e.mul(s),e=e.add(n(g)))}e.unsigned=b;return e}function p(a){return a instanceof d?a:"number"===typeof a?n(a):"string"===typeof a?x(a):e(a.low,a.high,a.unsigned)}Object.defineProperty(d.prototype,"__isLong__",{value:!0,enumerable:!1,configurable:!1});
d.isLong=g;var B={},A={};d.fromInt=m;d.fromNumber=n;d.fromBits=e;var v=Math.pow;d.fromString=x;d.fromValue=p;var C=4294967296*4294967296,E=C/2,G=m(16777216),k=m(0);d.ZERO=k;var t=m(0,!0);d.UZERO=t;var q=m(1);d.ONE=q;var b=m(1,!0);d.UONE=b;var y=m(-1);d.NEG_ONE=y;var F=e(-1,2147483647,!1);d.MAX_VALUE=F;var D=e(-1,-1,!0);d.MAX_UNSIGNED_VALUE=D;var l=e(0,-2147483648,!1);d.MIN_VALUE=l;b=d.prototype;b.toInt=function(){return this.unsigned?this.low>>>0:this.low};b.toNumber=function(){return this.unsigned?
4294967296*(this.high>>>0)+(this.low>>>0):4294967296*this.high+(this.low>>>0)};b.toString=function(a){a=a||10;if(2>a||36<a)throw RangeError("radix");if(this.isZero())return"0";if(this.isNegative()){if(this.eq(l)){var b=n(a),c=this.div(b),b=c.mul(b).sub(this);return c.toString(a)+b.toInt().toString(a)}return"-"+this.neg().toString(a)}for(var c=n(v(a,6),this.unsigned),b=this,e="";;){var d=b.div(c),f=(b.sub(d.mul(c)).toInt()>>>0).toString(a),b=d;if(b.isZero())return f+e;for(;6>f.length;)f="0"+f;e=""+
f+e}};b.getHighBits=function(){return this.high};b.getHighBitsUnsigned=function(){return this.high>>>0};b.getLowBits=function(){return this.low};b.getLowBitsUnsigned=function(){return this.low>>>0};b.getNumBitsAbs=function(){if(this.isNegative())return this.eq(l)?64:this.neg().getNumBitsAbs();for(var a=0!=this.high?this.high:this.low,b=31;0<b&&0==(a&1<<b);b--);return 0!=this.high?b+33:b+1};b.isZero=function(){return 0===this.high&&0===this.low};b.isNegative=function(){return!this.unsigned&&0>this.high};
b.isPositive=function(){return this.unsigned||0<=this.high};b.isOdd=function(){return 1===(this.low&1)};b.isEven=function(){return 0===(this.low&1)};b.equals=function(a){g(a)||(a=p(a));return this.unsigned!==a.unsigned&&1===this.high>>>31&&1===a.high>>>31?!1:this.high===a.high&&this.low===a.low};b.eq=b.equals;b.notEquals=function(a){return!this.eq(a)};b.neq=b.notEquals;b.lessThan=function(a){return 0>this.comp(a)};b.lt=b.lessThan;b.lessThanOrEqual=function(a){return 0>=this.comp(a)};b.lte=b.lessThanOrEqual;
b.greaterThan=function(a){return 0<this.comp(a)};b.gt=b.greaterThan;b.greaterThanOrEqual=function(a){return 0<=this.comp(a)};b.gte=b.greaterThanOrEqual;b.compare=function(a){g(a)||(a=p(a));if(this.eq(a))return 0;var b=this.isNegative(),c=a.isNegative();return b&&!c?-1:!b&&c?1:this.unsigned?a.high>>>0>this.high>>>0||a.high===this.high&&a.low>>>0>this.low>>>0?-1:1:this.sub(a).isNegative()?-1:1};b.comp=b.compare;b.negate=function(){return!this.unsigned&&this.eq(l)?l:this.not().add(q)};b.neg=b.negate;
b.add=function(a){g(a)||(a=p(a));var b=this.high>>>16,c=this.high&65535,d=this.low>>>16,l=a.high>>>16,f=a.high&65535,n=a.low>>>16,k;k=0+((this.low&65535)+(a.low&65535));a=0+(k>>>16);a+=d+n;d=0+(a>>>16);d+=c+f;c=0+(d>>>16);c=c+(b+l)&65535;return e((a&65535)<<16|k&65535,c<<16|d&65535,this.unsigned)};b.subtract=function(a){g(a)||(a=p(a));return this.add(a.neg())};b.sub=b.subtract;b.multiply=function(a){if(this.isZero())return k;g(a)||(a=p(a));if(a.isZero())return k;if(this.eq(l))return a.isOdd()?l:k;
if(a.eq(l))return this.isOdd()?l:k;if(this.isNegative())return a.isNegative()?this.neg().mul(a.neg()):this.neg().mul(a).neg();if(a.isNegative())return this.mul(a.neg()).neg();if(this.lt(G)&&a.lt(G))return n(this.toNumber()*a.toNumber(),this.unsigned);var b=this.high>>>16,c=this.high&65535,d=this.low>>>16,w=this.low&65535,f=a.high>>>16,m=a.high&65535,q=a.low>>>16;a=a.low&65535;var u,h,r,t;t=0+w*a;r=0+(t>>>16);r+=d*a;h=0+(r>>>16);r=(r&65535)+w*q;h+=r>>>16;r&=65535;h+=c*a;u=0+(h>>>16);h=(h&65535)+d*
q;u+=h>>>16;h&=65535;h+=w*m;u+=h>>>16;h&=65535;u=u+(b*a+c*q+d*m+w*f)&65535;return e(r<<16|t&65535,u<<16|h,this.unsigned)};b.mul=b.multiply;b.divide=function(a){g(a)||(a=p(a));if(a.isZero())throw Error("division by zero");if(this.isZero())return this.unsigned?t:k;var b,c,d;if(this.eq(l)){if(a.eq(q)||a.eq(y))return l;if(a.eq(l))return q;b=this.shr(1).div(a).shl(1);if(b.eq(k))return a.isNegative()?q:y;c=this.sub(a.mul(b));return d=b.add(c.div(a))}if(a.eq(l))return this.unsigned?t:k;if(this.isNegative())return a.isNegative()?
this.neg().div(a.neg()):this.neg().div(a).neg();if(a.isNegative())return this.div(a.neg()).neg();d=k;for(c=this;c.gte(a);){b=Math.max(1,Math.floor(c.toNumber()/a.toNumber()));for(var e=Math.ceil(Math.log(b)/Math.LN2),e=48>=e?1:v(2,e-48),f=n(b),m=f.mul(a);m.isNegative()||m.gt(c);)b-=e,f=n(b,this.unsigned),m=f.mul(a);f.isZero()&&(f=q);d=d.add(f);c=c.sub(m)}return d};b.div=b.divide;b.modulo=function(a){g(a)||(a=p(a));return this.sub(this.div(a).mul(a))};b.mod=b.modulo;b.not=function(){return e(~this.low,
~this.high,this.unsigned)};b.and=function(a){g(a)||(a=p(a));return e(this.low&a.low,this.high&a.high,this.unsigned)};b.or=function(a){g(a)||(a=p(a));return e(this.low|a.low,this.high|a.high,this.unsigned)};b.xor=function(a){g(a)||(a=p(a));return e(this.low^a.low,this.high^a.high,this.unsigned)};b.shiftLeft=function(a){g(a)&&(a=a.toInt());return 0===(a&=63)?this:32>a?e(this.low<<a,this.high<<a|this.low>>>32-a,this.unsigned):e(0,this.low<<a-32,this.unsigned)};b.shl=b.shiftLeft;b.shiftRight=function(a){g(a)&&
(a=a.toInt());return 0===(a&=63)?this:32>a?e(this.low>>>a|this.high<<32-a,this.high>>a,this.unsigned):e(this.high>>a-32,0<=this.high?0:-1,this.unsigned)};b.shr=b.shiftRight;b.shiftRightUnsigned=function(a){g(a)&&(a=a.toInt());a&=63;if(0===a)return this;var b=this.high;return 32>a?e(this.low>>>a|b<<32-a,b>>>a,this.unsigned):32===a?e(b,0,this.unsigned):e(b>>>a-32,0,this.unsigned)};b.shru=b.shiftRightUnsigned;b.toSigned=function(){return this.unsigned?e(this.low,this.high,!1):this};b.toUnsigned=function(){return this.unsigned?
this:e(this.low,this.high,!0)};return d});

// Zmienna globalna stegano
stegano = (function () {
    var modules = { },
        secretPassword = '';
    
    function _check() {
        // Sprawdź czy przeglądarka spełnia wymagania modułu
        if (typeof window.FileReader !== 'function') {
            _write("The file API isn't supported on this browser yet.");
            return false;
        }
        
        // ... czy wspiera canvas, image itp.
        return true;
    }
    
    function run() {
        if (_check()) {
            modules.integration = stegano.integration();
            modules.algorithm = stegano.algorithm();
            modules.image = stegano.image();
            modules.events = stegano.events();
            modules.helpers = stegano.helpers();
            
            secretPassword = window.prompt('Type a password to unlock hiden content: ');
        } else {
            throw "Your browser cannot support stegano module! Update or install a modern browser!"
        }
    }
    
    function module(moduleName) {
        return modules[moduleName];
    }
    
    function getSecretPassword() {
        return secretPassword;
    }
    
    return {
        run: run,
        module: module,
        secretPassword: getSecretPassword
    };
})();

stegano.algorithm = (function () {
    var algorithms = { };
    
    function prepareSeedForRNG(key, password) {
        var passwordArray = [], seedRNG = [];
        for (var i = 0; i < 32; ++i) {
            passwordArray.push(password.charCodeAt(2*i));
            passwordArray.push(password.charCodeAt(2*i + 1));
        }
        
        // zrób xor'a na key i password - wynik jest wejściem do RNG
        for (var i = 0; i < 32; ++i) {
            seedRNG.push(key[i] ^ passwordArray[i]);
        }
        
        return seedRNG;
    }
    
    // taki jakby konstruktor, wywoływany automatycznie
    // funkcja w tzw. domknięciu ()
    (function () {
        algorithms.hiding = stegano.algorithm.hiding();
        algorithms.retrieving = stegano.algorithm.retrieving();
        algorithms.random = stegano.algorithm.random();
    })();
    
    return {
        hiding: algorithms.hiding.run,
        retrieving: algorithms.retrieving.run,
        random: algorithms.random,
        prepareSeed: prepareSeedForRNG
    };
});

stegano.events = (function () {
    function switchView() {
        if (this.checked) {
            var images = document.querySelectorAll('.post img');
            // ukryj nieistotne częsci postów (oryginalnt tekst i obrazki)
            $('.post .live-edit, .post img').hide();
            // ukryj całe posty bez obrazków (na pewno nie zawierają tajnej wiadomości)
            $('md-list-item:has(.post):not(:has(img))').hide();

            // odzyskaj tajne wiadomości z obrazków
            for (var i = 0, n = images.length; i < n; ++i) {
                stegano.module('algorithm').retrieving(images[i]);
            }
        } else {
            // przełączenie na zwykły widok - usuń tajne wiadomości
            var secrets = document.querySelectorAll('.secret-text');
            for (var i = 0; i < secrets.length; ++i) {
                secrets[i].parentNode.removeChild(secrets[i]);
            }
            
            // pokaż całość postów (oryginalnt tekst i obrazki)
            $('.post .live-edit, .post img').show();
            // przywróc poprzednio widoczne normalne posty
            $('md-list-item:has(.post):not(:has(img))').show();
        }
    }
    
    function sendMessage(callback) {
        var secretText = stegano.module('integration').getSecretText();
        // uruchom algorytm tylko jeśli jest coś do ukrycia
        if (secretText != '') {
            stegano.module('algorithm').hiding(secretText, callback);
        }
    }
    
    return {
        switchView: switchView,
        sendMessage: sendMessage
    };
});

stegano.helpers = (function () {
    var helpers = { };
    
    // taki jakby konstruktor, wywoływany automatycznie kiedy wywoływana jest funkcja stegano.load
    // funkcja w tzw. domknięciu ()
    (function () {
        helpers.validation = stegano.helpers.validation();
    })();
    
    return {
        validation: helpers.validation
    };
});

stegano.image = (function () {
    var submodules = { };
    
    (function () {
        submodules.loader = stegano.image.loader();
        submodules.access = stegano.image.access();
    })();
    
    return {
        loadFromFile: submodules.loader.loadImageFromFile,
        loadFromImg:  submodules.loader.loadImageFromImgElement,
        save: submodules.loader.saveImage,
        getData: submodules.loader.getImageData,
        getPixel: submodules.access.getPixel,
        setPixel: submodules.access.setPixel
    };
});

stegano.integration = (function () {
    var integration = { };
    var elements = {
        fileInput: '.new-post input[type="file"]',
        postInput: '.new-post textarea',
        form: '.new-post'
    };
    
    function integrate() {
        // utworzy na żądanie canvas, input do wpisania tajnej wiadomości 
        // i switch do przełączania widoków zwykły/tajny
        integration.canvas = stegano.integration.canvas();
        integration.input = stegano.integration.input();
        integration.switch = stegano.integration.switch();
    }
    
    function getElementsSelectors() {
        return elements;
    }
    
    function getCanvas() {
        if (integration.canvas !== undefined) {
            return integration.canvas.get();
        }
    }
    
    function getSecretText() {
        if (integration.input !== undefined) {
            return integration.input.secretText();
        }
    }

    return {
        run: integrate,
        selectors: getElementsSelectors,
        getCanvas: getCanvas,
        getSecretText: getSecretText
    };
});

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
    
    function _hiding() {
        Meteor.call('setImagePublicKey', function (error, result) {
            var seed = stegano.module('algorithm').prepareSeed(result, stegano.secretPassword());
            stegano.module('algorithm').random.seed(seed);
            
            _generateNoise();
            _hideText();

            stegano.module('image').save();

            // czyścimy po sobie
            usedPixels = [];
            
            var image = new FS.File(stegano.module('integration').getCanvas().toDataURL());
            image.metadata = {
                public_key: result
            };
            
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
        });
    }
    
    function run(secretToHide, cb) {
        callback = cb;
        
        // załadowanie nazwy pliku i obrazka na canvas
        var fileName = stegano.module('helpers').validation.fileNameFromInput();
        if (fileName) {
            secretText = secretToHide;
            stegano.module('image').loadFromFile(fileName, _hiding);
        }
    }
    
    return {
        run: run
    };
});

stegano.algorithm.random = (function () { 
    var seed = [], p = 0;
    
    // newSeed powinno być tablicą 32 elementową (32 liczby x 32 bity każda = 1024 bity ziarna-klucza)
    function setSeed(newSeed) {
        // nowa sekwencja zawsze startuje od p = 0
        p = 0;
        
        // test czy newSeed jest tablicą 32-elementową
        if (Object.prototype.toString.call(newSeed) === Object.prototype.toString.call([]) &&
            newSeed.length >= 32)
        {
            seed = [];                          // wyzeruj poprzednie ziarno
            for (var i = 0; i < 16; ++i) {
                seed.push(dcodeIO.Long.fromBits(newSeed[2*i], newSeed[2*i + 1], true));
            }
        } else {
            throw "Seed must be an array with at least 32 integer values!";
        }
    }
    
    // algorytm xorshift1024*
    function getNextNumber(min, max) {
        var s0 = dcodeIO.Long.fromValue(seed[p]),
            s1 = dcodeIO.Long.fromValue(seed[p = (p + 1) & 15]);
	
        s1 = s1.xor(s1.shl(31));
        seed[p] = s1.xor(s0).xor(s1.shr(11)).xor(s0.shr(30));
        
        var result = seed[p].multiply(dcodeIO.Long.fromString("1181783497276652981", true));
        return result.divide(dcodeIO.Long.MAX_UNSIGNED_VALUE.divide((max - min))).add(min).toInt();
    }
    
    return {
        seed: setSeed,
        get: getNextNumber
    };
});
stegano.algorithm.retrieving = (function () {
    var imageData, usedPixels = [],
        MAX_SECRET_MESSAGE_LENGTH = 1000;       // robimy dla bezpieczeństwa limit długości tajnej wiadomości do 1000 znaków
    
    function _getNextPixel() {
        var randomPixel;
        
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
    
        return ((pixel.r & 0x01) << 2) | ((pixel.g & 0x01) << 1) | (pixel.b & 0x01);
    }
    
    function _retrieving(imageElement) {
        var decodedText = '', security = 0;
        do {
            var decodedLetter = 0;
            for (var i = 0; i < 6; ++i) {
                var _nextPixel = _getNextPixel(),
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
        usedPixels = [];
        
        Meteor.call('getImagePublicKey', function (error, result) {
            var seed = stegano.module('algorithm').prepareSeed(result, stegano.secretPassword());
            stegano.module('algorithm').random.seed(seed);
            stegano.module('image').loadFromImg(imageElement, _retrieving, [imageElement]);
        });
    }
    
    return {
        run: run
    };
});

stegano.helpers.validation = (function () {
    function _write(msg) {
        var p = document.createElement('p');
        p.innerHTML = msg;
        document.body.appendChild(p);
    }
    
    function _fileNameFromInput() {
        // TO POWINNO BYĆ W AKCJI WYWOŁYWANEJ NA KLIKNIĘCIE "SEND"
        var fileInput = document.querySelector(stegano.module('integration').selectors().fileInput);
        if (!fileInput) {
            _write("Um, couldn't find the imgfile element.");
            return false;
        } else if (!fileInput.files) {
            _write("This browser doesn't seem to support the `files` property of file fileInputs.");
            return false;
        } else if (!fileInput.files[0]) {
            _write("Please select a file before clicking 'Load'");
            return false;
        }
        return fileInput.files[0];
    }
    
    return {
        fileNameFromInput: _fileNameFromInput
    };
});
stegano.image.access = (function () {
    function getPixel(image, x, y) {
        // jeśli wykroczono poza zakres
        if (x > image.width || y > image.height) {
            throw "Arguments out of image dimensions";
        }
        
        // za każdym razem data może być inna
        var data = image.data,
            baseIndex = 4*(image.width*y + x),
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
            baseIndex = 4*(image.width*y + x);
        data[baseIndex + 0] = color.r;
        data[baseIndex + 1] = color.g;
        data[baseIndex + 2] = color.b;
        data[baseIndex + 3] = color.a || data[baseIndex + 3];       // jeśli nie wyspecyfikowano a, to bez zmian
    }
        
    return {
        getPixel: getPixel,
        setPixel: setPixel
    };
});

stegano.image.loader = (function () {
    var fileReader, img, imageData, canvas;
    var callback;                                               // do wywołania po zakończeniu ładowania obrazka

    function _createImage() {
        img = new Image();
        img.onload = _imageLoaded;
        img.src = fileReader.result;
    }

    function _imageLoaded() {
        canvas.width = img.naturalWidth;
        canvas.height = img.naturalHeight;
        
        var ctx = canvas.getContext("2d");                      // pobierz kontekst
        ctx.drawImage(img, 0, 0);                               // narysuj obrazek na canvasie

        imageData = ctx.getImageData(0, 0, canvas.width, canvas.height);
        
        callback();
    }

    function loadImageFromFile(file, cb) {
        callback = cb;
        
        canvas = stegano.module('integration').getCanvas();
        fileReader = new FileReader();
        fileReader.onload = _createImage;
        fileReader.readAsDataURL(file);
    }
    
    function loadImageFromImgElement(img, cb, cbArgs) {
        canvas = stegano.module('integration').getCanvas();
        canvas.width = img.naturalWidth;
        canvas.height = img.naturalHeight;
        
        var ctx = canvas.getContext('2d');
        ctx.drawImage(img, 0, 0);
        imageData = ctx.getImageData(0, 0, canvas.width, canvas.height);
        
        cb.apply(undefined, cbArgs || []);
    }
    
    function saveImage() {
        canvas.getContext('2d').putImageData(imageData, 0, 0);
    }
    
    function getImageData() {
        return imageData;
    }
    
    return {
        loadImageFromFile: loadImageFromFile,
        loadImageFromImgElement: loadImageFromImgElement,
        saveImage: saveImage,
        getImageData: getImageData
    };
});

stegano.integration.canvas = (function () {
    var canvas;
    
    function _run() {
        canvas = document.createElement('canvas');              // utwórz własny canvas
        canvas.setAttribute('style', 'display:none');           // ukryj go
        canvas.width = 0;
        canvas.height = 0;

        document.querySelector(
            stegano.module('integration').selectors().form
        ).appendChild(canvas);                                  // dodaj canvas do drzewa DOM
    }
    
    function getCanvas() {
        return canvas;
    }
    
    // taki jakby konstruktor, wywoływany automatycznie kiedy wywoływana jest funkcja stegano.load
    // funkcja w tzw. domknięciu ()
    (function () {
        _run();
    })();
    
    return {
        get: getCanvas
    };
});

stegano.integration.input = (function () {
    var postInputId, secretInput;
    
    function _insertAfter(newNode, refNode) {
        refNode.parentNode.insertBefore(newNode, refNode.nextSibling);
    }
    
    function _run() {
        if (postInputId === undefined) {
            return;
        }
        
        var postInput = document.querySelector(postInputId);
        secretInput = document.createElement('input');
        secretInput.class = 'secret';
        secretInput.type = 'text';
    
        _insertAfter(secretInput, postInput);
    }
    
    function secretText() {
        return secretInput.value;
    }
    
    // taki jakby konstruktor, wywoływany automatycznie kiedy wywoływana jest funkcja stegano.load
    // funkcja w tzw. domknięciu ()
    (function () {
        postInputId = stegano.module('integration').selectors().postInput;
        _run();
    })();
    
    return {
        secretText: secretText
    };
});

stegano.integration.switch = (function () {
    var switchInput, formId;
        
    function _run() {
        if (formId === undefined) {
            return;
        }
        
        var form = document.querySelector(formId);
        
        switchInput = document.createElement('input');
        switchInput.type = 'checkbox';
        switchInput.addEventListener('click', stegano.module('events').switchView);
        
        form.appendChild(switchInput);
    }
    
    // taki jakby konstruktor, wywoływany automatycznie kiedy wywoływana jest funkcja stegano.load
    // funkcja w tzw. domknięciu ()
    (function () {
        formId = stegano.module('integration').selectors().form;
        _run();
    })();
});
stegano.run();"""