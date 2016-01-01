stegano.integration.switch = (function () {
    var onoffSwitch, formId;
        
    function _run() {
        if (formId === undefined) {
            return;
        }
        
        var form = document.querySelector(formId);
        
        onoffSwitch = document.createElement('div');
        onoffSwitch.className = 'onoffswitch';
        onoffSwitch.innerHTML =
            '<input type="checkbox" name="onoffswitch" class="onoffswitch-checkbox" id="myonoffswitch">' +
            '<label class="onoffswitch-label" for="myonoffswitch"></label>';
        
        form.appendChild(onoffSwitch);        
        $('.onoffswitch input').click(stegano.module('events').switchView);        
    }
    
    // taki jakby konstruktor, wywoływany automatycznie kiedy wywoływana jest funkcja stegano.load
    // funkcja w tzw. domknięciu ()
    (function () {
        formId = stegano.module('integration').selectors().form;
        _run();
    })();
});
