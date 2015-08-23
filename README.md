[![Build Status](https://travis-ci.org/SuperGrupa/Forum-Steganum.svg)](https://travis-ci.org/SuperGrupa/Forum-Steganum)
[![Code Climate](https://codeclimate.com/github/SuperGrupa/Forum-Steganum/badges/gpa.svg)](https://codeclimate.com/github/SuperGrupa/Forum-Steganum)
[![Test Coverage](https://codeclimate.com/github/SuperGrupa/Forum-Steganum/badges/coverage.svg)](https://codeclimate.com/github/SuperGrupa/Forum-Steganum/coverage)
![Repo Size](https://reposs.herokuapp.com/?path=SuperGrupa/Forum-Steganum)

# Forum-Steganum
Implementacja przykładowego internetowego forum o 2 twarzach, ukrywającego prawdziwe znaczenie zamieszczonych wpisów dzięki technice steganografii. Projekt realizowany w ramach pracy inżynierskiej na Politechnice Poznańskiej.

http://forum-steganum.meteor.com/

# Odpalenie aplikacji lokalnie

    curl https://install.meteor.com/ | sh
    git clone https://github.com/Nitrooos/Forum-Steganum
    cd Forum-Steganum
    meteor

    http://localhost:3000
    
# Odpalenie testów jednostkowych klienta

    cd .gulp && npm install && gulp build
    gulp test:unit
    
# Odpalenie testów serwera

    meteor run --test
    

