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
    
    function getElementsIds() {
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
        getElementsIds: getElementsIds,
        getCanvas: getCanvas,
        getSecretText: getSecretText
    };
});
