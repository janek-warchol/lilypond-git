%% Do not edit this file; it is auto-generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.11.49"

\header {
  lsrtags = "pitches"

  texidoc = "
This Scheme-based snippet generates 24 random notes (or as many as
required), based on the current time (or any randomish number specified
instead, in order to obtain the same random notes each time): i.e., to
get different random note patterns, just change this number.

"
  doctitle = "Generating random notes"
} % begin verbatim
\score {
  { #(let ((random-state (seed->random-state (current-time))))
    (ly:export
     (make-music 'SequentialMusic 'elements
      (map (lambda x
           (let ((idx (random 12 random-state)))
            (make-music 'EventChord
             'elements (list (make-music 'NoteEvent
                              'duration (ly:make-duration 2 0 1 1)
                              'pitch (ly:make-pitch (quotient idx 7)
                                      (remainder idx 7)
                                      0))))))
       (make-list 24)))))
  }
}
