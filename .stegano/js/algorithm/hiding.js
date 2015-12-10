stegano.algorithm.hiding = (function () {

    function run() {
        console.log('Hiding');
        
        var fileName = stegano.module('helpers').validation.fileNameFromInput();
        if (fileName) {
            stegano.module('image').load(fileName);
        }
        
        
    }
    
    return {
        run: run
    };
});
