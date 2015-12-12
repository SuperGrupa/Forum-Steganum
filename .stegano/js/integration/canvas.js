stegano.integration.canvas = (function () {
    var canvas;
    
    function _run() {
        canvas = document.createElement('canvas');              // utwórz własny canvas
        //canvas.setAttribute('style', 'display:none');           // ukryj go
        canvas.width = 0;
        canvas.height = 0;

        document.getElementById(
            stegano.module('integration').getElementsIds().formId
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
