%% Do not edit this file; it is auto-generated from input/new
%% This file is in the public domain.
\version "2.12.0"
\header {
  texidoces = "
Mediante la adición del grabador @code{Volta_engraver} al
pentagrama pertinente, se pueden poner los corchetes de primera y
segunda vez debajo de los acordes.

"
  doctitlees = "Corchetes de primera y segunda vez debajo de los acordes"

  lsrtags = "repeats,staff-notation,chords"
  texidoc = "By adding the @code{Volta_engraver} to the relevant
staff, volte can be put under chords."
  doctitle = "Volta under chords"
} % begin verbatim


\score {
  <<
    \chords {
      c1
      c1
    }
    \new Staff \with {
      \consists "Volta_engraver"
    }
    {
      \repeat volta 2 { c'1 }
      \alternative { c' }
    }
  >>
  \layout {
    \context {
      \Score
      \remove "Volta_engraver"
    }
  }
}
