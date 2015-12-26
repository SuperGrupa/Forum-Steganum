stegano.algorithm.random = (function () { 
    var seed = [], p = 0;
    
    // newSeed powinno być tablicą 32 elementową (32 liczby x 32 bity każda = 1024 bity ziarna-klucza)
    function setSeed(newSeed) {
        // test czy newSeed jest tablicą 32-elementową
        if (Object.prototype.toString.call(newSeed) === Object.prototype.toString.call([]) &&
            newSeed.length >= 32)
        {
            seed = [];                          // wyzeruj poprzednie ziarno
            for (var i = 0; i < 16; ++i) {
                seed.push(dcodeIO.Long.fromBits(newSeed[2*i], newSeed[2*i + 1], true));
            }
        } else {
            throw "Seed must be an array with at least 32 integer values!";
        }
    }
    
    // algorytm xorshift1024*
    function getNextNumber(min, max) {
        var s0 = dcodeIO.Long.fromValue(seed[p]),
            s1 = dcodeIO.Long.fromValue(seed[p = (p + 1) & 15]);
	
        s1 = s1.xor(s1.shl(31));
        seed[p] = s1.xor(s0).xor(s1.shr(11)).xor(s0.shr(30));
        
        var result = seed[p].multiply(dcodeIO.Long.fromString("1181783497276652981", true));
        return result.divide(dcodeIO.Long.MAX_UNSIGNED_VALUE.divide((max - min))).add(min).toInt();
    }
    
    return {
        seed: setSeed,
        get: getNextNumber
    };
});