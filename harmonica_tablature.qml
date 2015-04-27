//=============================================================================
//  MuseScore
//  Music Composition & Notation
//
//  Harmonica Tabs Plugin
//
//  Copyright (C) 2015 Ross Melin
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the GNU General Public License version 2
//  as published by the Free Software Foundation and appearing in
//  the file LICENCE.GPL
//=============================================================================

import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1
import MuseScore 1.0

MuseScore {
    version: "2.0"
    description: "Harmonica Tab plugin"
    menuPath: "Plugins.Harmonica Tablature"
    pluginType: "dialog"
    
    id: window
    width:280
    height: 180
    ColumnLayout {
        id: column
        anchors.margins : 10
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 90
        
        ComboBox {
            currentIndex: 9
            model: ListModel {
                id: keylist
                property var key
                ListElement { text: "Low A"; harpkey: 45 }
                ListElement { text: "Low C"; harpkey: 48 }
                ListElement { text: "Low D"; harpkey: 50 }
                ListElement { text: "Low F"; harpkey: 53 }
                ListElement { text: "G"; harpkey: 55 }
                ListElement { text: "Ab"; harpkey: 56 }
                ListElement { text: "A"; harpkey: 57 }
                ListElement { text: "Bb"; harpkey: 58 }
                ListElement { text: "B"; harpkey: 59 }
                ListElement { text: "C"; harpkey: 60 }
                ListElement { text: "Db"; harpkey: 61 }
                ListElement { text: "D"; harpkey: 62 }
                ListElement { text: "Eb"; harpkey: 63 }
                ListElement { text: "E"; harpkey: 64 }
                ListElement { text: "F"; harpkey: 65 }
                ListElement { text: "F#"; harpkey: 66 }
                ListElement { text: "High G"; harpkey: 67 }
            }
            width: 100
            onCurrentIndexChanged: {
                console.debug(keylist.get(currentIndex).text + ", " + keylist.get(currentIndex).harpkey)
                keylist.key = keylist.get(currentIndex).harpkey
            }
        }
        ComboBox {
            currentIndex: 0
            model: ListModel {
                id: harp
                property var tuning
                ListElement { text: "Richter (Blues Harp)"; tuning: 1 }
                ListElement { text: "Richter half valved"; tuning: 2 }
                ListElement { text: "Country"; tuning: 3 }
                ListElement { text: "Standard Chromatic"; tuning: 4 }
            }
            width: 100
            onCurrentIndexChanged: {
                console.debug(harp.get(currentIndex).text + ", " + harp.get(currentIndex).tuning)
                harp.tuning = harp.get(currentIndex).tuning
            }
        }
        ComboBox {
            currentIndex: 1
            model: ListModel {
                id: placetext
                property var position
                ListElement { text: "Higher"; position: -2 }
                ListElement { text: "Above staff"; position: 0 }
                ListElement { text: "Below staff"; position: 10 }
                ListElement { text: "Lower"; position: 12 }
            }
            width: 100
            onCurrentIndexChanged: {
                console.debug(placetext.get(currentIndex).text + ", " + placetext.get(currentIndex).position)
                placetext.position = placetext.get(currentIndex).position
            }
        }
    }
    RowLayout {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: column.bottom
        height: 70
        Button {
            id: okButton
            text: "Ok"
            onClicked: {
                apply()
                Qt.quit()
            }
        }
        Button {
            id: closeButton
            text: "Close"
            onClicked: { Qt.quit() }
        }
        
    }
    
    function tabNotes(notes, text) {
        
        var richter = ["+1",  "-1b",  "-1", "+1o", "+2",  "-2bb",   "-2b",  "-2",   "-3bbb", "-3bb",  "-3b",   "-3",
        "+4",   "-4b",  "-4", "+4o", "+5",  "-5",     "+5o",  "+6",   "-6b",   "-6",    "+6o",   "-7",
        "+7",   "-7o",  "-8", "+8b", "+8",  "-9",     "+9b",  "+9",   "-9o",  "-10",   "+10bb",  "+10b",
        "+10" ];    //Standard Richter tuning with overbends
        
        
        var richterValved = ["+1",  "-1b",  "-1", "+2b", "+2",  "-2bb",   "-2b",  "-2",   "-3bbb", "-3bb",  "-3b",   "-3",
        "+4",   "-4b",  "-4", "+5b", "+5",  "-5",     "+6b",  "+6",   "-6b",   "-6",    "-7b",   "-7",
        "+7",   "-8b",  "-8", "+8b", "+8",  "-9",     "+9b",  "+9",   "-10b",  "-10",   "+10bb",  "+10b",
        "+10" ];
        richterValved[-2] = "+1bb"; richterValved[-1] = "+1b"; //Two notes below the key at blow 1
        
        var country = ["+1",  "-1b",  "-1", "+1o", "+2",  "-2bb",   "-2b",  "-2",   "+2o", "-3bb",  "-3b",   "-3",
        "+4",   "-4b",  "-4", "+4o", "+5",  "-5b",     "-5",  "+6",   "-6b",   "-6",    "+6o",   "-7",
        "+7",   "-7o",  "-8", "+8b", "+8",  "-9",     "+9b",  "+9",   "-9o",  "-10",   "+10bb",  "+10b",
        "+10" ];
        
        var standardChromatic = ["+1", '+1s', "-1", "+2", "-2", "-2s", "+3", "+3s", "-3", "-3s","-4",
        "+4", "+4s", "-5", "-5s", "+6", "-6", "-6s", "+7",  "+7s", "-7", "-7s", "-8",
        "+8", "+8s", "-9", "-9s", "+10", "-10", "-10s", "+11", "+11s", "-11", "-11s", "-12",
        "+12", "+12s", "-12" ];
        
        var tuning = richter
        switch (harp.tuning) {
            case 1: tuning = richter; break;
            case 2: tuning = richterValved; break;
            case 3: tuning = country; break;
            case 4: tuning = standardChromatic; break;
            default: tuning = richter; break;
        }
        
        
        var harpkey = keylist.key
        console.log("harpkey set to  " +keylist.key)
        
        
        for (var i = 0; i < notes.length; i++) {
            var sep = "\n"; // change to "," if you want them horizontally
            if ( i > 0 )
                text.text = sep + text.text;
            
            if (typeof notes[i].pitch === "undefined") // just in case
                return
                if (typeof tuning[notes[i].pitch - harpkey] === "undefined")
                    text.text = "X";
                else
                    text.text = tuning[notes[i].pitch - harpkey] + text.text;
        }
    }
    
    function applyToSelection(func) {
        if (typeof curScore === 'undefined')
            Qt.quit();
        var cursor = curScore.newCursor();
        var startStaff;
        var endStaff;
        var endTick;
        var fullScore = false;
        var textposition = placetext.position
        console.log("textposition set to " +placetext.position)
        cursor.rewind(1);
        if (!cursor.segment) { // no selection
            fullScore = true;
            startStaff = 0; // start with 1st staff
            endStaff  = curScore.nstaves - 1; // and end with last
        } else {
            startStaff = cursor.staffIdx;
            cursor.rewind(2);
            if (cursor.tick == 0) {
                // this happens when the selection includes
                // the last measure of the score.
                // rewind(2) goes behind the last segment (where
                // there's none) and sets tick=0
                endTick = curScore.lastSegment.tick + 1;
            } else {
                endTick = cursor.tick;
            }
            endStaff   = cursor.staffIdx;
        }
        console.log(startStaff + " - " + endStaff + " - " + endTick)
        
        for (var staff = startStaff; staff <= endStaff; staff++) {
            for (var voice = 0; voice < 4; voice++) {
                cursor.rewind(1); // beginning of selection
                cursor.voice    = voice;
                cursor.staffIdx = staff;
                
                if (fullScore)  // no selection
                    cursor.rewind(0); // beginning of score
                    
                    while (cursor.segment && (fullScore || cursor.tick < endTick)) {
                        if (cursor.element && cursor.element.type == Element.CHORD) {
                            var text = newElement(Element.STAFF_TEXT);
                            
                            var graceChords = cursor.element.graceNotes;
                            for (var i = 0; i < graceChords.length; i++) {
                                // iterate through all grace chords
                                var notes = graceChords[i].notes;
                                tabNotes(notes, text);
                                // there seems to be no way of knowing the exact horizontal pos.
                                // of a grace note, so we have to guess:
                                text.pos.x = -2.5 * (graceChords.length - i);
                                text.pos.y = textposition;
                                cursor.add(text);
                                // new text for next element
                                text  = newElement(Element.STAFF_TEXT);
                            }
                            
                            var notes = cursor.element.notes;
                            tabNotes(notes, text);
                            text.pos.y = textposition;
                            
                            if ((voice == 0) && (notes[0].pitch > 83))
                                text.pos.x = 1;
                            cursor.add(text);
                        } // end if CHORD
                        cursor.next();
                    } // end while segment
            } // end for voice
        } // end for staff
        Qt.quit();
    } // end applyToSelection()
    
    function apply() {
        curScore.startCmd()
        applyToSelection(tabNotes)
        curScore.endCmd()          
    }
    
    onRun: {
        if (typeof curScore === 'undefined')
            Qt.quit();
    }
}