%% Do not edit this file; it is auto-generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.11.38"

\header {
  lsrtags = "expressive-marks, tweaks-and-overrides"
 texidoc = "
A caesura is sometimes denoted with a double \"railtracks\" breath mark
with a fermata sign positioned over the top of the railtracks. This
snippet should present an optically pleasing combination of railtracks
and a fermata.
" }
% begin verbatim
{
  \context Voice {
    c''2.
    % use some scheme code to construct the symbol
    \override BreathingSign #'text = #(markup #:line 
                                  (#:musicglyph "scripts.caesura.curved"
                                   #:translate (cons -1.75 1.6) 
                                   #:musicglyph "scripts.ufermata"
                                  ))
    \breathe c''4
    % set the breathe mark back to normal
    \revert BreathingSign #'text
    c''2. \breathe c''4
    \bar "|."
  }
}

