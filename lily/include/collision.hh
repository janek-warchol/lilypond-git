/*
  collision.hh -- declare Collision

  source file of the GNU LilyPond music typesetter

  (c)  1997--2000 Han-Wen Nienhuys <hanwen@cs.uu.nl>
*/


#ifndef COLLISION_HH
#define COLLISION_HH

#include "lily-proto.hh"
#include "lily-guile.hh"


/**
  Resolve conflicts between various Note_columns (chords).
  
  TODO 

  * multistaff support (see Chlapik: equal noteheads should be on the
  same hpos.)  

  * Make interface of this, similar to align-interface.
  
  Properties:

  elements -- (see Axis_group_interface)

  merge-differently-dotted -- merge black noteheads with differing dot count.

  horizontal-shift -- integer that identifies ranking of note-column for horizontal shifting.
  
  force-hshift -- amount of collision_note_width that overides automatic collision settings.
  Read and removed from elements.

  note-width -- unit for horizontal translation, measured in staff-space.
  
*/
class Collision			// interface
{
public:
  static SCM automatic_shift (Score_element*);
  static SCM forced_shift (Score_element*);
  static SCM force_shift_callback (SCM element, SCM axis);
  static void do_shifts (Score_element*);
  static void add_column (Score_element*me,Score_element*ncol_l);
};
#endif // COLLISION_HH
