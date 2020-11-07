#!/bin/bash

set -x

cards=(
  "back"

  "1_club"
  "2_club"
  "3_club"
  "4_club"
  "5_club"
  "6_club"
  "7_club"
  "8_club"
  "9_club"
  "10_club"
  "jack_club"
  "queen_club"
  "king_club"

  "1_diamond"
  "2_diamond"
  "3_diamond"
  "4_diamond"
  "5_diamond"
  "6_diamond"
  "7_diamond"
  "8_diamond"
  "9_diamond"
  "10_diamond"
  "jack_diamond"
  "queen_diamond"
  "king_diamond"

  "1_spade"
  "2_spade"
  "3_spade"
  "4_spade"
  "5_spade"
  "6_spade"
  "7_spade"
  "8_spade"
  "9_spade"
  "10_spade"
  "jack_spade"
  "queen_spade"
  "king_spade"

  "1_heart"
  "2_heart"
  "3_heart"
  "4_heart"
  "5_heart"
  "6_heart"
  "7_heart"
  "8_heart"
  "9_heart"
  "10_heart"
  "jack_heart"
  "queen_heart"
  "king_heart"
)

for i in ${cards[@]}; do
  inkscape ./svg-cards.svg -i "$i" -o "./out/$i.png"
done

