stegano.integration = (function () {
    var integration = { };
    
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

    return {
        run: integrate,
        getImageData: getImageData
    };
});
