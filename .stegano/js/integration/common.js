stegano.integration = (function () {
    var integration = { };
    var elements = {
        fileInputId: 'image-file',
        postInputId: 'post-message-id',
        formId: 'image-form'
    };
    
    function integrate() {
        // utworzy na żądanie canvas i input do wpisania tajnej wiadomości
        integration.canvas = stegano.integration.canvas();
        integration.input = stegano.integration.input();
    }
    
    function getImageData() {
        if (integration.canvas !== undefined) {
            return integration.canvas.getImageData();
        }
    }
    
    function getElementsIds() {
        return elements;
    }

    return {
        run: integrate,
        getImageData: getImageData,
        getElementsIds: getElementsIds
    };
});
