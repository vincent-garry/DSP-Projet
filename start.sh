#!/bin/sh
Xvfb :99 -ac &
export DISPLAY=:99
java -jar Jeu_Puissance4.jar