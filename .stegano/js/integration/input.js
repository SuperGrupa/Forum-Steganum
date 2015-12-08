stegano.integration.input = (function () {
    var postInputId;
    
    function _insertAfter(newNode, refNode) {
        refNode.parentNode.insertBefore(newNode, refNode.nextSibling);
    }
    
    function _run() {
        if (postInputId === undefined) {
            return;
        }
        
        var secretInput = document.createElement('input'),
            postInput = document.getElementById(postInputId);
    
        _insertAfter(secretInput, postInput);
    }
    
    // taki jakby konstruktor, wywoływany automatycznie kiedy wywoływana jest funkcja stegano.load
    // funkcja w tzw. domknięciu ()
    (function () {
        postInputId = stegano.module('integration').getElementsIds().postInputId;
        _run();
    })();
});
