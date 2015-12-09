// Zmienna globalna stegano
stegano = (function () {
    var modules = { };
    
    function _check() {
        // Sprawdź czy przeglądarka spełnia wymagania modułu
        if (typeof window.FileReader !== 'function') {
            _write("The file API isn't supported on this browser yet.");
            return false;
        }
        
        // ... czy wspiera canvas, image itp.
        return true;
    }
    
    function run() {
        if (_check()) {
            modules.integration = stegano.integration();
            modules.algorithm = stegano.algorithm();
            modules.events = stegano.events();
        } else {
            throw "Your browser cannot support stegano module! Update or install a modern browser!"
        }
    }
    
    function module(moduleName) {
        return modules[moduleName];
    }
    
    return {
        run: run,
        module: module
    };
})();
