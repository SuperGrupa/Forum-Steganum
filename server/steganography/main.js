var stegano = (function () {
    var modules = {
        load: { },
        access: { }
    };
    
    function run() {
        document.addEventListener('module-load-loaded', function () {
            modules.access = stegano.access();
        });
        
        modules.load = stegano.load();
    }
    
    function module(moduleName) {
        return modules[moduleName];
    }
    
    return {
        run: run,
        module: module
    };
})();

window.addEventListener('load', function () {
    // blokuj wysyłanie formularza
    document.getElementById('image-form').addEventListener('submit', function () {
        return false;
    });

    // na kliknięcie przycisku "Load" ładuj obrazek
    document.getElementById('load-image').addEventListener('click', function () {
        stegano.run();
    });
});