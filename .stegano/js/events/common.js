stegano.events = (function () {
    function switchView() {
        if (this.checked) {
            var images = document.querySelectorAll('.post img');
            // przełączenie na tajny widok...
            for (var i = 0, n = images.length; i < n; ++i) {
                stegano.module('algorithm').retrieving(images[i]);
            }
        } else {
            // przełączenie na zwykły widok
            var secrets = document.querySelectorAll('.secret-text'),
                images = document.querySelectorAll('.post img');
            for (var i = 0; i < secrets.length; ++i) {
                secrets[i].parentNode.removeChild(secrets[i]);
            }
            for (var i = 0; i < images.length; ++i) {
                images[i].setAttribute('style', '');
            }
        }
    }
    
    function sendMessage() {
        var secretText = stegano.module('integration').getSecretText();
        stegano.module('algorithm').hiding(secretText);
    }
    
    return {
        switchView: switchView,
        sendMessage: sendMessage
    };
});
