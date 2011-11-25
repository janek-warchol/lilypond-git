/*
  This file is part of LilyPond, the GNU music typesetter.

  Copyright (C) 2011 Mike Solomon <mike@apollinemike.com>

  LilyPond is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  LilyPond is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with LilyPond.  If not, see <http://www.gnu.org/licenses/>.
*/

#include <map>
#include <algorithm>

#include "grob.hh"
#include "item.hh"
#include "pointer-group-interface.hh"
#include "pure-from-neighbor-interface.hh"
#include "engraver.hh"

class Pure_from_neighbor_engraver : public Engraver
{
  vector<Grob *> pure_relevants_;
  vector<Grob *> need_pure_heights_from_neighbors_;

public:
  TRANSLATOR_DECLARATIONS (Pure_from_neighbor_engraver);
protected:
  DECLARE_ACKNOWLEDGER (pure_from_neighbor);
  DECLARE_ACKNOWLEDGER (item);
  void finalize ();
};

Pure_from_neighbor_engraver::Pure_from_neighbor_engraver ()
{
}

void
Pure_from_neighbor_engraver::acknowledge_item (Grob_info i)
{
  SCM pure_relevant_p = ly_lily_module_constant ("pure-relevant?");
  if (!Pure_from_neighbor_interface::has_interface (i.item ())
      && to_boolean (scm_call_1 (pure_relevant_p, i.item ()->self_scm ())))
    pure_relevants_.push_back (i.item ());
}

void
Pure_from_neighbor_engraver::acknowledge_pure_from_neighbor (Grob_info i)
{
  need_pure_heights_from_neighbors_.push_back (i.item ());
}

void
Pure_from_neighbor_engraver::finalize ()
{
  if (!need_pure_heights_from_neighbors_.size ())
    return;

  vector_sort (need_pure_heights_from_neighbors_, Grob::less);
  vector_sort (pure_relevants_, Grob::less);

  /*
    first, clump need_pure_heights_from_neighbors into
    vectors of grobs that have the same column.
  */

  vsize l = 0;
  vector<vector<Grob *> > need_pure_heights_from_neighbors;
  do
    {
      vector<Grob *> temp;
      temp.push_back (need_pure_heights_from_neighbors_[l]);
      for (;
           (l < need_pure_heights_from_neighbors_.size () - 1
            && (need_pure_heights_from_neighbors_[l]->spanned_rank_interval ()[LEFT]
                == need_pure_heights_from_neighbors_[l + 1]->spanned_rank_interval ()[LEFT]));
           l++)
        temp.push_back (need_pure_heights_from_neighbors_[l + 1]);
      need_pure_heights_from_neighbors.push_back (temp);
      l++;
    }
  while (l < need_pure_heights_from_neighbors_.size ());

  /*
    then, loop through the pure_relevants_ list, adding the items
    to the elements of need_pure_heights_from_neighbors_ on either side.
  */

  int pos[2] = {-1, 0};
  for (vsize i = 0; i < pure_relevants_.size (); i++)
    {
      if (pos[1] < (int) need_pure_heights_from_neighbors.size ()
          && (pure_relevants_[i]->spanned_rank_interval ()[LEFT]
              > need_pure_heights_from_neighbors[pos[1]][0]->spanned_rank_interval ()[LEFT]))
        {
          pos[0] = pos[1];
          pos[1]++;
        }
      for (int j = 0; j < 2; j++)
        if (pos[j] >= 0 && pos[j] < (int) need_pure_heights_from_neighbors.size ())
          for (vsize k = 0; k < need_pure_heights_from_neighbors[pos[j]].size (); k++)
            Pointer_group_interface::add_grob (need_pure_heights_from_neighbors[pos[j]][k], ly_symbol2scm ("neighbors"), pure_relevants_[i]);
    }

  need_pure_heights_from_neighbors_.clear ();
  pure_relevants_.clear ();
}

#include "translator.icc"

ADD_ACKNOWLEDGER (Pure_from_neighbor_engraver, item);
ADD_ACKNOWLEDGER (Pure_from_neighbor_engraver, pure_from_neighbor);
ADD_TRANSLATOR (Pure_from_neighbor_engraver,
                /* doc */
                "Coordinates items that get their pure heights from their neighbors.",

                /* create */
                "",

                /* read */
                "",

                /* write */
                ""
               );
