stegano.events = (function () {
    function switchView() {
        if (this.checked) {
            var images = document.querySelectorAll('.post img');
            // ukryj nieistotne częsci postów (oryginalnt tekst i obrazki)
            $('.post .live-edit, .post img').hide();
            // ukryj całe posty bez obrazków (na pewno nie zawierają tajnej wiadomości)
            $('md-list-item:has(.post):not(:has(img))').hide();

            // odzyskaj tajne wiadomości z obrazków
            for (var i = 0, n = images.length; i < n; ++i) {
                stegano.module('algorithm').retrieving(images[i]);
            }
            
            // zmień info na switchu na widok tajny
            $('.view-mode').text('Secret view');
        } else {
            // przełączenie na zwykły widok - usuń tajne wiadomości
            var secrets = document.querySelectorAll('.secret-text');
            for (var i = 0; i < secrets.length; ++i) {
                secrets[i].parentNode.removeChild(secrets[i]);
            }
            
            // pokaż całość postów (oryginalnt tekst i obrazki)
            $('.post .live-edit, .post img').show();
            // przywróc poprzednio widoczne normalne posty
            $('md-list-item:has(.post)').show();
            // zmień info na switchu na widok normalny
            $('.view-mode').text('Normal view');
        }
    }
    
    function sendMessage(callback) {
        var secretText = stegano.module('integration').getSecretText();
        stegano.module('algorithm').hiding(secretText, callback);
    }
    
    return {
        switchView: switchView,
        sendMessage: sendMessage
    };
});
