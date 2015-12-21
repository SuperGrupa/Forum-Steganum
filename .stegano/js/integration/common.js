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

    return {
        run: integrate,
        selectors: getElementsSelectors,
        getCanvas: getCanvas
    };
});
