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
