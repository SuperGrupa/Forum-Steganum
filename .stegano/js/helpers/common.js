stegano.helpers = (function () {
    var helpers = { };
    
    // taki jakby konstruktor, wywoływany automatycznie kiedy wywoływana jest funkcja stegano.load
    // funkcja w tzw. domknięciu ()
    (function () {
        helpers.validation = stegano.helpers.validation();
    })();
    
    return {
        validation: helpers.validation
    };
});
