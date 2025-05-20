#!/bin/bash

MOVIES=("pushpa" "krrish" "dangal" "3idiots" "tanhaji")

echo "First movie is ${MOVIES[0]}"
echo "Second movie is ${MOVIES[1]}"
echo "Third movie is ${MOVIES[2]}"
echo "Fourth movie is ${MOVIES[3]}"
echo "Fifth movie is ${MOVIES[4]}"
echo "All movies are ${MOVIES[#]}"
echo "All movies are ${#MOVIES[@]}"