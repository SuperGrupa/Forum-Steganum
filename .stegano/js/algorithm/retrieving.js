stegano.algorithm.retrieving = (function () {
    var image, secretKey;
    
    function _retrieving() {
        
    }
    
    // imageElement - musimy wiedzieć, z którego obrazka aktualnie wyciągamy treść
    function run(imageElement) {
        console.log('Retrieving');
        
        image = imageElement;
        secretKey = Meteor.call('getImageSeed');
        stegano.module('algorithm').random.seed(secretKey);
        _retrieving();
    }
    
    return {
        run: run
    };
});
