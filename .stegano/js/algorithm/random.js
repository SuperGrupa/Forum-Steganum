stegano.algorithm.random = (function () { 
    var seed;
    
    function setSeed(newSeed) {
        seed = newSeed;
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