stegano.image.loader = (function () {
    var fileReader, img, imageData, canvas;

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
    }

    function loadImage(file) {
        canvas = stegano.module('integration').getCanvas();
        fileReader = new FileReader();
        fileReader.onload = _createImage;
        fileReader.readAsDataURL(file);
    }
    
    function getImageData() {
        return imageData;
    }
    
    return {
        loadImage: loadImage,
        getImageData: getImageData
    };
});
