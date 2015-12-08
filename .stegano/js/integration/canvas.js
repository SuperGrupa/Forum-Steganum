stegano.integration.canvas = (function () {
    var fileInputId = 'image-file', formId = 'image-form';    
    var fileInput, file, fileReader, img, imageData;
    var moduleLoadedEvent = new Event('module-canvas-loaded');

    function _check() {
        if (typeof window.FileReader !== 'function') {
            _write("The file API isn't supported on this browser yet.");
            return false;
        }

        fileInput = document.getElementById(fileInputId);
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
        return true;
    }
    
    function _createImage() {
        img = new Image();
        img.onload = _imageLoaded;
        img.src = fileReader.result;
    }

    function _imageLoaded() {
        var canvas = document.createElement('canvas');          // utwórz własny canvas
        canvas.setAttribute('style', 'display:none');           // ukryj go
        canvas.width = img.width;                               // zmień wymiary
        canvas.height = img.height;                             // na odpowiadające obrazkowi
        var ctx = canvas.getContext("2d");                      // pobierz kontekst
        ctx.drawImage(img, 0, 0);                               // narysuj obrazek na canvasie

        document.getElementById(formId).appendChild(canvas);    // dodaj canvas do drzewa DOM
                
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
            file = fileInput.files[0];
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
        getImageData: getImageData
    };
});
