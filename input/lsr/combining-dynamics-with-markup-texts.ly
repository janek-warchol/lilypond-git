%% Do not edit this file; it is auto-generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.11.38"

\header {
  lsrtags = "expressive-marks, text"
 texidoc = "
Some dynamics may involve text indications (such as \"più forte\",
\"piano subito\", etc.). They can be produced using a \\markup bloc.
" }
% begin verbatim
\layout{ragged-right = ##t}

piuf =	\markup {  \italic "molto" \dynamic "f" }

\relative c''{
  c-\piuf
  c
  c2\< c2\!
  
  c2\< c2\!
}

