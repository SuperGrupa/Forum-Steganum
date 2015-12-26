stegano.integration.switch = (function () {
    var switchInput, formId;
    
    function _switchView() {
        // jeśli chcesz przełączyć się na tajny widok
        if (this.checked) {
            var images = document.getElementsByTagName('img');
            for (var i = 0, n = images.length; i < n; ++i) {
                stegano.module('algorithm').retrieving(images[i]);
            }
        }
    }
    
    function _run() {
        if (formId === undefined) {
            return;
        }
        
        var form = document.querySelector(formId);
        
        switchInput = document.createElement('input');
        switchInput.type = 'checkbox';
        switchInput.addEventListener('click', _switchView);
        
        form.appendChild(switchInput);
    }
    
    // taki jakby konstruktor, wywoływany automatycznie kiedy wywoływana jest funkcja stegano.load
    // funkcja w tzw. domknięciu ()
    (function () {
        formId = stegano.module('integration').selectors().form;
        _run();
    })();
});
