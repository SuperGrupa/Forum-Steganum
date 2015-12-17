stegano.algorithm = (function () {
    var algorithms = { };
    
    // taki jakby konstruktor, wywoływany automatycznie kiedy wywoływana jest funkcja stegano.load
    // funkcja w tzw. domknięciu ()
    (function () {
        algorithms.hiding = stegano.algorithm.hiding();
        algorithms.retrieving = stegano.algorithm.retrieving();
        algorithms.random = stegano.algorithm.random();
    })();
    
    return {
        hiding: algorithms.hiding.run,
        retrieving: algorithms.retrieving.run,
        random: algorithms.random
    };
});
