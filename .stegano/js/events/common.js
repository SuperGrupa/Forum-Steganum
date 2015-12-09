stegano.events = (function () {
    var view = 'normal';
    
    function switchView() {
        if (view === 'normal') {
            // ... switch to secret
            view = 'secret';
        } else if (view === 'secret') {
            // switch to normal
            view = 'normal';
        }
    }
    
    function sendMessage() {
        function _check() {
            // TO POWINNO BYĆ W AKCJI WYWOŁYWANEJ NA KLIKNIĘCIE "SEND"
            fileInput = document.getElementById(stegano.module('integration').getElementsIds().fileInputId);
            if (!fileInput) {
                _write("Um, couldn't find the imgfile element.");
                return false;
            } else if (!fileInput.files) {
                _write("This browser doesn't seem to support the `files` property of file fileInputs.");
                return false;
            } else if (!fileInput.files[0]) {
                _write("Please select a file before clicking 'Load'");
                return false;
            }
            return true;
        }
        
        function _write(msg) {
            var p = document.createElement('p');
            p.innerHTML = msg;
            document.body.appendChild(p);
        }
        
        stegano.module('algorithm').hiding();
        
        // hide
        // and send
    }
    
    return {
        switchView: switchView,
        sendMessage: sendMessage
    }
});
