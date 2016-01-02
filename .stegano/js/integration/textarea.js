stegano.integration.textarea = (function () {
    var postInputId, secretTextarea;
    
    function _insertAfter(newNode, refNode) {
        refNode.parentNode.insertBefore(newNode, refNode.nextSibling);
    }
    
    function _run() {
        if (postInputId === undefined) {
            return;
        }
        
        var postInput = document.querySelector(postInputId);
        secretTextarea = document.createElement('textarea');
        secretTextarea.setAttribute('maxlength', '1000');
        secretTextarea.placeholder = 'Type to add hidden content';
    
        _insertAfter(secretTextarea, postInput);
    }
    
    function secretText() {
        return secretTextarea.value;
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
