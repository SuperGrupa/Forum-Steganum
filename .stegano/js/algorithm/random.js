stegano.algorithm.random = (function () { 
    var seed = [];
    
    // newSeed powinno być tablicą 32 elementową (32 liczby x 32 bity każda = 1024 bity ziarna-klucza)
    function setSeed(newSeed) {
        // test czy newSeed jest tablicą 32-elementową
        if (Object.prototype.toString.call(newSeed) === Object.prototype.toString.call([]) &&
            newSeed.length >= 32)
        {
            for (var i = 0; i < 16; ++i) {
                seed.push(dcodeIO.Long.fromBits(newSeed[2*i], newSeed[2*i + 1], true));
            }
        } else {
            throw "Seed must be an array with at least 32 integer values!";
        }
    }
    
    function getNextNumber(min, max) {
        // tymczasowo domyślny generator (TO DO własny)
        return Math.floor(Math.random()*(max - min) + min);
    }
    
    return {
        seed: setSeed,
        get: getNextNumber
    };
});