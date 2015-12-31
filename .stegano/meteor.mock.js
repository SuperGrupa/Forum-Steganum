Meteor = {
    call: function(methodName) {
        switch (methodName) {
            case 'getImagePublicKey':
                var result = [123, 456789, 4397856, 238761, 958652, 23985695, 9328798234, 498576, 10575, 394875, 328457, 2756, 93285732890, 93863, 89457, 32987,
                              45, 42395, 3285, 42398520, 428957, 2875, 43890709, 924875, 9287529, 245876, 2498573, 43089767, 48957, 423958, 47356, 982472];
                arguments[arguments.length - 1].call(undefined, undefined, result);
                break;
            case 'setImagePublicKey':
                var result = [123, 456789, 4397856, 238761, 958652, 23985695, 9328798234, 498576, 10575, 394875, 328457, 2756, 93285732890, 93863, 89457, 32987,
                              45, 42395, 3285, 42398520, 428957, 2875, 43890709, 924875, 9287529, 245876, 2498573, 43089767, 48957, 423958, 47356, 982472];
                arguments[arguments.length - 1].call(undefined, undefined, result);
                break;
        }
    }
};

FS = {
    File: function () {
        return {
            _id: '123456789'                // zwróc pseudoobiekt z fake'owym id
        };
    }
};

Images = {
    insert: function (image, callback) {
        callback(undefined);                // undefined, bo zakładamy, że w mockach nie występują błędy z przesłaniem na serwer
        
        return {
            _id: '123456789'                // zwróc pseudoobiekt z fake'owym id
        };
    }
};

alertsServ = {
    error: function (errorText) {
        alert(errorText);
    }
};