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
        stegano.module('algorithm').hiding();
        
        // hide
        // and send
    }
    
    return {
        switchView: switchView,
        sendMessage: sendMessage
    };
});
