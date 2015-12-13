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
        var secretText = stegano.module('integration').getSecretText();
        stegano.module('algorithm').hiding(secretText);
        
        console.log('Secret text: ' + secretText);
    }
    
    return {
        switchView: switchView,
        sendMessage: sendMessage
    };
});
