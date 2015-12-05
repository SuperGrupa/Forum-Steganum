stegano.load = (function () {
    var input, file, fileReader, img, imageData;
    
    var moduleLoadedEvent = new Event('module-load-loaded');

    function _check() {
        if (typeof window.FileReader !== 'function') {
            _write("The file API isn't supported on this browser yet.");
            return false;
        }

        input = document.getElementById('image-file');
        if (!input) {
            _write("Um, couldn't find the imgfile element.");
            return false;
        } else if (!input.files) {
            _write("This browser doesn't seem to support the `files` property of file inputs.");
            return false;
        } else if (!input.files[0]) {
            _write("Please select a file before clicking 'Load'");
            return false;
        }
        return true;
    }
    
    function _createImage() {
        img = new Image();
        img.onload = _imageLoaded;
        img.src = fileReader.result;
    }

    function _imageLoaded() {
        var canvas = document.getElementById("canvas");
        canvas.width = img.width;
        canvas.height = img.height;
        var ctx = canvas.getContext("2d");
        ctx.drawImage(img, 0, 0);
        
        imageData = ctx.getImageData(0, 0, canvas.width, canvas.height);
        document.dispatchEvent(moduleLoadedEvent);
    }

    function _write(msg) {
        var p = document.createElement('p');
        p.innerHTML = msg;
        document.body.appendChild(p);
    }

    function loadCanvasWithImage() {
        if (_check()) {
            file = input.files[0];
            fileReader = new FileReader();
            fileReader.onload = _createImage;
            fileReader.readAsDataURL(file);
        }
    }
    
    function getImageData() {
        return imageData;
    }
    
    // taki jakby konstruktor, wywoływany automatycznie kiedy wywoływana jest funkcja stegano.load
    // funkcja w tzw. domknięciu ()
    (function () {
        loadCanvasWithImage();
    })();
    
    return {
        loadCanvasWithImage: loadCanvasWithImage,
        getImageData: getImageData
    };
});