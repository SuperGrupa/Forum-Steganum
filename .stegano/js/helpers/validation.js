stegano.helpers.validation = (function () {
    function _write(msg) {
        var p = document.createElement('p');
        p.innerHTML = msg;
        document.body.appendChild(p);
    }
    
    function _fileNameFromInput() {
        // TO POWINNO BYĆ W AKCJI WYWOŁYWANEJ NA KLIKNIĘCIE "SEND"
        var fileInput = document.getElementById(stegano.module('integration').getElementsIds().fileInputId);
        if (!fileInput) {
            _write("Um, couldn't find the imgfile element.");
            return false;
        } else if (!fileInput.files) {
            _write("This browser doesn't seem to support the `files` property of file fileInputs.");
            return false;
        } else if (!fileInput.files[0]) {
            _write("Please select a file before clicking 'Load'");
            return false;
        }
        return fileInput.files[0];
    }
    
    return {
        fileNameFromInput: _fileNameFromInput
    };
});