//=============================================================================
//  MuseScore
//  Harmonica plugin
//
//  Copyright (C)2012 lasconic
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the GNU General Public License version 2.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program; if not, write to the Free Software
//  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
//=============================================================================

          // 54F#   G      G#  A         A#   B      C    C#     D       D#   E      F
var holes = ["+1",  "",    "", "-2",     "",  "",    "",  "-4",  "+5",   "",  "-6",  "",
             "+7",  "-8",  "", "+9",     "",  "-10", "",  "-12", "+11",  "",  "-14", "",
             "+13", "-16", "", "+15",    "",  "-18", "",  "-20", "+17",  "",  "",    "",
             "+19"
];

var shift = 54;
      
//---------------------------------------------------------
//    init
//---------------------------------------------------------

function init()
      {
      }

//-------------------------------------------------------------------
//    run
//-------------------------------------------------------------------

function run()
      {
      applyFingerings(curScore, holes, shift);
      }

var mscorePlugin = {
      menu: 'Plugins.Harmonica Tablature.Hohner Highlander, D side',
      init: init,
      run:  run
      };

mscorePlugin;

