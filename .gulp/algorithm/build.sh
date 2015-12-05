#!/bin/bash

# Definicje ścieżek
ALGORITHM_FILES_PATH=$(pwd)/../.steganography/js
ALGORITHM_FILES="$ALGORITHM_FILES_PATH/lib/main.js $ALGORITHM_FILES_PATH/*.js"

# Jeśli nie istnieje katalog /build to go stwórz
mkdir -p $ALGORITHM_FILES_PATH/build

# Scal pliki *.js (na końcu main.js - ważne!) w jeden
cat $ALGORITHM_FILES > $ALGORITHM_FILES_PATH/build/build.js
# Dopisz stegano.run() na końcu - żeby kod automatycznie się wykonał
echo 'stegano.run()' >> $ALGORITHM_FILES_PATH/build/build.js

# Dopiero teraz możesz uglifikować
uglifyjs $ALGORITHM_FILES_PATH/build/build.js --compress --mangle sort=true --output=$ALGORITHM_FILES_PATH/build/build.min.js

