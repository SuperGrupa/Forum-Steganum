stegano.integration.switch = (function () {
    var switchInput, formId;
    
    function _run() {
        if (formId === undefined) {
            return;
        }
        
        var form = document.getElementById(formId);
        
        switchInput = document.createElement('input');
        switchInput.type = 'checkbox';
        form.appendChild(switchInput);
    }
    
    // taki jakby konstruktor, wywoływany automatycznie kiedy wywoływana jest funkcja stegano.load
    // funkcja w tzw. domknięciu ()
    (function () {
        formId = stegano.module('integration').getElementsIds().formId;
        _run();
    })();
});
