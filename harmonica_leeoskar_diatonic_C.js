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

          // 60 C   C#    D     D#    E      F         F#    G        G#    A      A#    B   
var holes = ["+1",  "",   "-1", "",   "+2",  "-2\"",   "",  "+3",  "",  "-3\"", "",   "-3",
            "+4",   "",   "-4", "",   "+5",  "-5",     "",  "+6",     "",  "-6",   "",   "-7",
             "+7",  "",   "-8",  "",  "+8",  "-9",     "",  "+9",     "",  "-10",  "",   "+10'",
             "+10"
];

var shift = 60;
      
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
      menu: 'Plugins.Harmonica Tablature.Lee Oskar, Diatonic C',
      init: init,
      run:  run
      };

mscorePlugin;

