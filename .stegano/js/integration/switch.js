stegano.integration.switch = (function () {
    var viewSwitcher, formId;
        
    function _run() {
        if (formId === undefined) {
            return;
        }
        
        var form = document.querySelector(formId);
        
        viewSwitcher = document.createElement('div');
        viewSwitcher.className = 'view-switch';
        viewSwitcher.innerHTML =
            '<span class="view-mode">Normal view</span>' +
            '<div class="onoffswitch">' +
                '<input type="checkbox" name="onoffswitch" class="onoffswitch-checkbox" id="myonoffswitch">' +
                '<label class="onoffswitch-label" for="myonoffswitch"></label>' +
            '</div>';
        
        form.appendChild(viewSwitcher);        
        $('.view-switch input').click(stegano.module('events').switchView);        
    }
    
    // taki jakby konstruktor, wywoływany automatycznie kiedy wywoływana jest funkcja stegano.load
    // funkcja w tzw. domknięciu ()
    (function () {
        formId = stegano.module('integration').selectors().form;
        _run();
    })();
});
