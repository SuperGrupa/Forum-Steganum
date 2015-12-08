// Zmienna globalna stegano
stegano = (function () {
    var modules = { };
    
    function run() {
        document.addEventListener('module-canvas-loaded', function () {
            modules.access = stegano.access();
        });
        
        modules.integration = stegano.integration();
        modules.algorithm = stegano.algorithm();
    }
    
    function module(moduleName) {
        return modules[moduleName];
    }
    
    return {
        run: run,
        module: module
    };
})();
