/*   
	measure-grouping-spanner.cc --  implement Measure_grouping

	source file of the GNU LilyPond music typesetter

	(c) 2002--2004 Han-Wen Nienhuys <hanwen@cs.uu.nl>

 */

#include "output-def.hh"
#include "spanner.hh"
#include "measure-grouping-spanner.hh"
#include "lookup.hh" 
#include "item.hh"
#include "staff-symbol-referencer.hh"

MAKE_SCHEME_CALLBACK (Measure_grouping, print, 1);
SCM 
Measure_grouping::print (SCM grob)
{
  Spanner * me = dynamic_cast<Spanner*> (unsmob_grob (grob));

  /*
    TODO: robustify.
   */
  SCM which = me->get_property ("style");
  Real height = robust_scm2double (me->get_property ("height"), 1);

  Real t = Staff_symbol_referencer::line_thickness (me) * robust_scm2double (me->get_property ("thickness"), 1);
  Grob *common = me->get_bound (LEFT)->common_refpoint (me->get_bound (RIGHT),
						       X_AXIS);

  Interval rext = me->get_bound (RIGHT)->extent (common, X_AXIS);
  Real w =robust_relative_extent (me->get_bound (RIGHT),
				  common, X_AXIS).linear_combination (CENTER);
    - me->get_bound (LEFT)->relative_coordinate (common, X_AXIS);

  Interval iv (0,w);

  Stencil m;

  /*
    TODO: use line interface
   */
  if (which == ly_symbol2scm ("bracket"))
    {
      m = Lookup::bracket (X_AXIS, iv, t, -height, t);
    }
  else if (which == ly_symbol2scm ("triangle"))
    {
      m = Lookup::triangle (iv, t, height);
    }

  m.align_to (Y_AXIS, DOWN);
  return m.smobbed_copy ();
}

ADD_INTERFACE (Measure_grouping,"measure-grouping-interface",
	       "This objectt indicates groups of beats. "
	       "Valid choices for @code{style} are @code{bracket} and @code{triangle}.",
	       "thickness style height");

  
