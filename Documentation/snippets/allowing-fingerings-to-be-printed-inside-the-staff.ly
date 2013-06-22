%% DO NOT EDIT this file manually; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% Make any changes in LSR itself, or in Documentation/snippets/new/ ,
%% and then run scripts/auxiliar/makelsr.py
%%
%% This file is in the public domain.
\version "2.17.20"

\header {
  lsrtags = "editorial-annotations, fretted-strings, spacing, specific-notation"

  texidoc = "
By default, vertically oriented fingerings are positioned outside the
staff.  However, this behavior can be canceled. Note: you must use a
chord construct <>, even if it is only a single note.

"
  doctitle = "Allowing fingerings to be printed inside the staff"
} % begin verbatim


\relative c' {
  <c-1 e-2 g-3 b-5>2
  \override Fingering.staff-padding = #'()
  <c-1 e-2 g-3 b-5>4 <g'-0>
}
