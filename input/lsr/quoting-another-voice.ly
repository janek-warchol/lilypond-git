%% Do not edit this file; it is auto-generated from input/new
%% This file is in the public domain.
\version "2.12.0"
\header {
  texidoces = "
La propiedad @code{quotedEventTypes} determina los tipos de
eventos musicales que resultan citados.  El valor predeterminado
es @code{(note-event rest-event)}, que significa que sólo aparecen
en la expresión @code{\\quoteDuring} las notas y los silencios.
En el ejemplo siguiente, el silencio de semicorchea no aparece en
el fragmento citado porque @code{rest-event} no está dentro de los
@code{quotedEventTypes}.

"
  doctitlees = "Citar otra voz"
  lsrtags = "staff-notation"
  texidoc = "The @code{quotedEventTypes} property determines the
music event types that are quoted.  The default value is
@code{(note-event rest-event)}, which means that only notes and
rests of the quoted voice appear in the @code{\\quoteDuring}
expression.  In the following example, a 16th rest is not quoted
since @code{rest-event} is not in @code{quotedEventTypes}."
  doctitle = "Quoting another voice"
} % begin verbatim


quoteMe = \relative c' {
  fis4 r16 a8.-> b4\ff c
}
\addQuote quoteMe \quoteMe

original = \relative c'' {
  c8 d s2
  \once \override NoteColumn #'ignore-collision = ##t
  es8 gis8
}

<<
  \new Staff {
    \set Staff.instrumentName = #"quoteMe"
    \quoteMe
  }
  \new Staff {
    \set Staff.instrumentName = #"orig"
    \original
  }
  \new Staff \relative c'' <<
    \set Staff.instrumentName = #"orig+quote"
    \set Staff.quotedEventTypes =
      #'(note-event articulation-event)
    \original
    \new Voice {
      s4
      \set fontSize = #-4
      \override Stem #'length-fraction = #(magstep -4)
      \quoteDuring #"quoteMe" { \skip 2. }
    }
  >>
>>
