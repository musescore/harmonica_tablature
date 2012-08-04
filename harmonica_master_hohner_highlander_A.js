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

          // 57A    A#  B     C   C#     D      D#     E      F    F#     G      G#
var holes = ["+1",  "", "-2", "", "+3",  ""   , "",    "-4",  "",  "",    "-6",  "",
             "+7",  "", "-8", "", "+9",  "-10", "",    "+11", "",  "-12", "-14", "",
             "+13", "", "-16","", "+15", "",    "-18", "+17", "",  "-20", "",    "",
             "+19"
];

var shift = 57;


function applyFingerings(score, fingerings, shift) 
      {
      var cursor   = new Cursor(score);
      cursor.staff = 0;
      cursor.voice = 0;
      cursor.rewind();  // set cursor to first chord/rest
      while (!cursor.eos()) {
            if (cursor.isChord()) {
                  var pitch = cursor.chord().topNote().pitch;
                  var index = pitch - shift;
                  if(index >= 0 && index < fingerings.length){   
                      var textString = fingerings[index];
                      if (textString.length > 0) {
                          var text  = new Text(curScore);
                          text.text = textString;
                          text.yOffset = 6;
                          text.xOffset = -1;
                          cursor.putStaffText(text);
                          }
                      }
                  }
            cursor.next();
            }
      }
      
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
      menu: 'Plugins.Harmonica Tablature.Hohner Highlander, A side',
      init: init,
      run:  run
      };

mscorePlugin;

