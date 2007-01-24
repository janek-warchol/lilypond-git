\version "2.10.12"

\header { texidoc = "
<p>The eighth notes may be seemingly attached to different
    beams, and the corresponding notes connected by ties. 
    Such a situation may occur, for example, in the cello suites.
" }

wipeNote = {
    \once \override NoteHead #'transparent = ##t
    \once \override Stem #'transparent = ##t 
}
\layout { raggedright = ##t }


\relative c''<< {
    c8[~
       \wipeNote
       c8
       c8~
       \wipeNote
       c
       c]~
    \wipeNote
    c\noBeam
}\\
   { s8 c8 [ s c s c] }

   
>>

