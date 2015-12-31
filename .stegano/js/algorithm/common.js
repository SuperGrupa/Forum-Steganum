stegano.algorithm = (function () {
    var algorithms = { };
    
    function prepareSeedForRNG(key, password) {
        var passwordArray = [], seedRNG = [];
        for (var i = 0; i < 32; ++i) {
            passwordArray.push(password.charCodeAt(2*i));
            passwordArray.push(password.charCodeAt(2*i + 1));
        }
        
        // zrób xor'a na key i password - wynik jest wejściem do RNG
        for (var i = 0; i < 32; ++i) {
            seedRNG.push(key[i] ^ passwordArray[i]);
        }
        
        return seedRNG;
    }
    
    // taki jakby konstruktor, wywoływany automatycznie
    // funkcja w tzw. domknięciu ()
    (function () {
        algorithms.hiding = stegano.algorithm.hiding();
        algorithms.retrieving = stegano.algorithm.retrieving();
        algorithms.random = stegano.algorithm.random();
    })();
    
    return {
        hiding: algorithms.hiding.run,
        retrieving: algorithms.retrieving.run,
        random: algorithms.random,
        prepareSeed: prepareSeedForRNG
    };
});
