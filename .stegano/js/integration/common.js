stegano.integration = (function () {
    var integration = { };
    var elements = {
        fileInputId: 'file-input',
        postInputId: 'new-post-text',
        formId: 'new-post-form'
    };
    
    function integrate() {
        // utworzy na żądanie canvas, input do wpisania tajnej wiadomości 
        // i switch do przełączania widoków zwykły/tajny
        integration.canvas = stegano.integration.canvas();
        integration.input = stegano.integration.input();
        integration.switch = stegano.integration.switch();
    }
    
    function getImageData() {
        if (integration.canvas !== undefined) {
            return integration.canvas.getImageData();
        }
    }
    
    function getElementsIds() {
        return elements;
    }
    
    function getCanvas() {
        if (integration.canvas !== undefined) {
            return integration.canvas.get();
        }
    }

    return {
        run: integrate,
        getImageData: getImageData,
        getElementsIds: getElementsIds,
        getCanvas: getCanvas
    };
});
