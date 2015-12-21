stegano.integration.input = (function () {
    var postInputId, secretInput;
    
    function _insertAfter(newNode, refNode) {
        refNode.parentNode.insertBefore(newNode, refNode.nextSibling);
    }
    
    function _run() {
        if (postInputId === undefined) {
            return;
        }
        
        var postInput = document.querySelector(postInputId);
        secretInput = document.createElement('input');
        secretInput.class = 'secret';
        secretInput.type = 'text';
    
        _insertAfter(secretInput, postInput);
    }
    
    function secretText() {
        return secretInput.value;
    }
    
    // taki jakby konstruktor, wywoływany automatycznie kiedy wywoływana jest funkcja stegano.load
    // funkcja w tzw. domknięciu ()
    (function () {
        postInputId = stegano.module('integration').selectors().postInput;
        _run();
    })();
    
    return {
        secretText: secretText
    };
});
