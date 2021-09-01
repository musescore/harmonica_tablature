//=============================================================================
//  MuseScore
//  Music Composition & Notation
//
//  Harmonica Tabs Plugin
//
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the GNU General Public License version 2
//  as published by the Free Software Foundation and appearing in
//  the file LICENCE.GPL
//=============================================================================

import QtQuick 2.9
import QtQuick.Controls 1.5
import QtQuick.Layouts 1.3
import MuseScore 3.0

MuseScore {
    version: "3.0"
    description: "Harmonica Tab plugin"
    menuPath: "Plugins.Harmonica Tablature"
    pluginType: "dialog"

// ------ OPTIONS -------
    property string sep : "\n"     // change to "," if you want tabs horizontally
    property string bendChar : "'" // change to "b" if you want bend to be noted with b
// ------ OPTIONS -------

    id: window
    width:280
    height: 250
    ColumnLayout {
        id: column
        anchors.margins : 10
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 90

        RowLayout
        {
            Label {
                text: "Key"
            }
            ComboBox {
                currentIndex: 17
                model: ListModel {
                    id: keylist
                    property var key
                    ListElement { text: "Low G"; harpkey: 43 }
                    ListElement { text: "Low Ab"; harpkey: 44 }
                    ListElement { text: "Low A"; harpkey: 45 }
                    ListElement { text: "Low Bb"; harpkey: 46 }
                    ListElement { text: "Low B"; harpkey: 47 }
                    ListElement { text: "Low C"; harpkey: 48 }
                    ListElement { text: "Low C#"; harpkey: 49 }
                    ListElement { text: "Low D"; harpkey: 50 }
                    ListElement { text: "Low Eb"; harpkey: 51 }
                    ListElement { text: "Low E"; harpkey: 52 }
                    ListElement { text: "Low F"; harpkey: 53 }
                    ListElement { text: "Low F#"; harpkey: 52 }
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
        }
        RowLayout
        {
            Label {
                text: "Tuning"

            }
            ComboBox {
                currentIndex: 0
                model: ListModel {
                    id: harp
                    property var tuning
                    ListElement { text: "Blues Harp (Richter)"; tuning: 1 }
                    ListElement { text: "Richter valved"; tuning: 2 }
                    ListElement { text: "Paddy Richter (Brendan Power), valved"; tuning: 10 }
                    ListElement { text: "Natural Minor"; tuning: 7 }
                    ListElement { text: "Melody Maker"; tuning: 8 }
                    ListElement { text: "Country"; tuning: 3 }
                    ListElement { text: "Circular (Seydel), valved"; tuning: 5 }
                    ListElement { text: "Circular (Inversed for blow 1), valved "; tuning: 9 }
                    ListElement { text: "TrueChromatic Diatonic, valved"; tuning: 6 }
                    ListElement { text: "Power Bender (Brendan Power)"; tuning: 13 }
                    ListElement { text: "Power Bender (Brendan Power), half valved"; tuning: 11 }
                    ListElement { text: "Power Draw (Brendan Power)"; tuning: 14 }
                    ListElement { text: "Power Draw (Brendan Power), half valved"; tuning: 12 }
                    ListElement { text: "Standard Chromatic"; tuning: 4 }
                }
                width: 100
                onCurrentIndexChanged: {
                    console.debug(harp.get(currentIndex).text + ", " + harp.get(currentIndex).tuning)
                    harp.tuning = harp.get(currentIndex).tuning
                }
            }
        }
        RowLayout
        {
            Label {
                text: "Placement"
            }
            ComboBox {
                currentIndex: 1
                model: ListModel {
                    id: placetext
                    property var position
                    ListElement { text: "Above staff"; position: "above" }
                    ListElement { text: "Below staff"; position: "below" }
                }
                width: 100
                onCurrentIndexChanged: {
                    console.debug(placetext.get(currentIndex).text + ", " + placetext.get(currentIndex).position)
                    placetext.position = placetext.get(currentIndex).position
                }
            }
        }
        ColumnLayout {
                Label {
                    text: "Breath Indicator"
                    font.underline: true
                }
                RowLayout {

                Label {
                    text: "Position"
                }
                ComboBox {
                    currentIndex: 0
                    model: ListModel {
                        id: breathtext
                        property var position
                        ListElement { text: "Left of Hole #"; position: "left" }
                        ListElement { text: "Right of Hole #"; position: "right" }
                    }
                    width: 100
                    onCurrentIndexChanged: {
                        console.debug(breathtext.get(currentIndex).text + ", " + breathtext.get(currentIndex).position)
                        breathtext.position = breathtext.get(currentIndex).position
                    }
                }
            }
            RowLayout {
                Label {
                    text: "Shown"
                }
                ComboBox {
                    currentIndex: 0
                    model: ListModel {
                        id: breathIndicator
                        property var mode
                        ListElement { text: "Both"; mode: "both" }
                        ListElement { text: "Blow Only"; mode: "blow_only" }
                        ListElement { text: "Draw Only"; mode: "draw_only" }
                    }
                    width: 100
                    onCurrentIndexChanged: {
                        console.debug(breathIndicator.get(currentIndex).text + ", " + breathIndicator.get(currentIndex).mode)
                        breathIndicator.mode = breathIndicator.get(currentIndex).mode
                    }
                }
            }
        }
        RowLayout {
            anchors.horizontalCenter: parent.horizontalCenter
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
    }



    function tabNotes(notes, text) {

        var richter = ["+1",  "-1b",  "-1", "+1o", "+2",  "-2bb",   "-2b",  "-2",   "-3bbb", "-3bb",  "-3b",   "-3",
        "+4",   "-4b",  "-4", "+4o", "+5",  "-5",     "+5o",  "+6",   "-6b",   "-6",    "+6o",   "-7",
        "+7",   "-7o",  "-8", "+8b", "+8",  "-9",     "+9b",  "+9",   "-9o",  "-10",   "+10bb",  "+10b",
        "+10", "-10o" ];    //Standard Richter tuning with overbends

        var richterValved = ["+1",  "-1b",  "-1", "+2b", "+2",  "-2bb",   "-2b",  "-2",   "-3bbb", "-3bb",  "-3b",   "-3",
        "+4",   "-4b",  "-4", "+5b", "+5",  "-5",     "+6b",  "+6",   "-6b",   "-6",    "-7b",   "-7",
        "+7",   "-8b",  "-8", "+8b", "+8",  "-9",     "+9b",  "+9",   "-10b",  "-10",   "+10bb",  "+10b",
        "+10" ];
        richterValved[-2] = "+1bb"; richterValved[-1] = "+1b"; //Two notes below the key at blow 1

        var paddyRichter = ["+1",  "-1b",  "-1", "+2b", "+2",  "-2bb",   "-2b",  "-2",   "+3b", "+3",  "-3b",   "-3",
        "+4",   "-4b",  "-4", "+5b", "+5",  "-5",     "+6b",  "+6",   "-6b",   "-6",    "-7b",   "-7",
        "+7",   "-8b",  "-8", "+8b", "+8",  "-9",     "+9b",  "+9",   "-10b",  "-10",   "+10bb",  "+10b",
        "+10" ];
        paddyRichter[-2] = "+1bb"; paddyRichter[-1] = "+1b"; //Two notes below the key at blow 1
                // Brendan Power's tuning, half valved

        var country = ["+1",  "-1b",  "-1", "+1o", "+2",  "-2bb",   "-2b",  "-2",   "-3bbb", "-3bb",  "-3b",   "-3",
        "+4",   "-4b",  "-4", "+4o", "+5",  "-5b",     "-5",  "+6",   "-6b",   "-6",    "+6o",   "-7",
        "+7",   "-7o",  "-8", "+8b", "+8",  "-9",     "+9b",  "+9",   "-9o",  "-10",   "+10bb",  "+10b",
        "+10", "-10o" ];

        var standardChromatic = ["+1", '+1s', "-1", "-1s", "+2", "-2", "-2s", "+3", "+3s", "-3", "-3s","-4",
        "+4", "+4s", "-5", "-5s", "+6", "-6", "-6s", "+7",  "+7s", "-7", "-7s", "-8",
        "+8", "+8s", "-9", "-9s", "+10", "-10", "-10s", "+11", "+11s", "-11", "-11s", "-12",
        "+12", "+12s", "-12", "-12s" ];

        var zirkValved = ["+1", "-1b", "-1", "+2b", "+2", "-2", "+3b", "+3", "-3b", "-3", "+4", "-4b",
        "-4", "+5b", "+5", "-5b", "-5", "+6", "-6b", "-6", "+7b", "+7", "-7", "+8b",
        "+8", "-8b", "-8", "+9b", "+9", "-9", "10b", "+10", "-10b", "-10" ]; // Circular/Spiral tuned diatonic
                // Key per Seydel "G"on blow 1, C major at draw 2, A minor at draw 1

        var trueChrom = ["+1", "-1b", "-1", "+2", "-2b", "-2", "+3b", "+3", "-3b", "-3", "+4", "-4b",
        "-4", "+5b", "+5", "-5b", "-5", "+6", "-6b", "-6", "+7b", "+7", "-7b", "-7",
        "+8", "-8b", "-8", "+9b", "+9", "-9b", "-9", "+10", "-10b", "-10" ];  //True Chromatic diatonic, valves
            //Another side of the spiral logic is expanded in the “True Chromatic” tuning, designed by Eugene Ivanov.
            //All chords can be arranged in a continuous, looped progression on major and minor triads:
            //C Eb G Bb D F A C E G B D Gb A Db E Ab B Eb Gb Bb Db F Ab C (and looped on C minor after that).

        var naturalMinor = ["+1",  "-1b",  "-1", "+2", "-2bbb",  "-2bb",   "-2b",  "-2",   "-3bb", "-3b",  "-3",   "+3o",
        "+4",   "-4b",  "-4", "+5", "-5b",  "-5",     "+5o",  "+6",   "-6b",   "-6",    "-7",   "+7b",
        "+7",   "-7o",  "-8", "+8", "-8o",  "-9",     "+9b",  "+9",   "-9o",  "-10",   "+10bb",  "+10b",
        "+10", "-10o" ];  //Labeled by blow 1 like Hohner. Seydel and Lee Okar labels by draw 2

        var melodyMaker = [ , , , , , // label by draw 2
        "+1", "-1b", "-1", "+1o","+2", "-2bb","-2b", "-2", "+2o", "+3",  "-3b",   "-3",
        "+4",   "-4b",  "-4", "+4o", "+5",  "-5b",     "-5",  "+6",   "-6b",   "-6",    "+6o",   "-7",
        "+7",   "-7o",  "-8", "+8b", "+8",  "-8o",     "-9",  "+9",   "-9o",  "-10",   "+10bb",  "+10b",
        "+10", "-10o" ];

        var spiral_b1 = ["+1", "-1b", "-1", "+2b", "+2", "-2", "+3b", "+3", "-3b", "-3", "+4b", "+4",
        "-4", "+5b", "+5", "-5b", "-5", "+6", "-6b", "-6", "+7b", "+7b", "-7", "-7",
        "+8", "-8b", "-8", "+9b", "+9", "-9", "+10b", "+10", "-10b", "-10" ]; // Circular/Spiral tuned diatonic
                // Inversed for Blow 1. Key of C major scale starts at blow 1

        var powerBenderHalfValved = ["+1",  "-1b",  "-1", "+2b", "+2",  "-2bb",   "-2b",  "-2",   "-3bbb", "-3bb",  "-3b",   "-3",
        "+4",   "-4b",  "-4", "-5b", "-5",  "+6",     "-6b",  "-6",   "+7b",   "+7",    "-7b",   "-7",
        "+8",   "-8b",  "-8", "+9b", "+9",  "-9bb",     "-9b",  "-9",   "+10b",  "+10",   "-10bb",  "-10b",
        "-10" ];
        powerBenderHalfValved[-2] = "+1bb"; powerBenderHalfValved[-1] = "+1b"; //Two notes below the key at blow 1
                // Brendan Power's tuning, half valved

        var powerBender = ["+1", "-1b","-1",  "+1o", "+2",  "-2bb",   "-2b",  "-2", "-3bbb", "-3bb",  "-3b",   "-3",
        "+4",   "-4b",  "-4", "-5b", "-5",  "+6", "-6b",  "-6", , "+6o", "+7",  "-7b",   "-7",
        "+8",   "-8b",  "-8","+8o", "+9",  "-9bb", "-9b",  "-9", "+9o", "+10",   "-10bb",  "-10b",
        "-10","+10o" ];

        var powerDraw = ["+1",  "-1b",  "-1", "+1o", "+2",  "-2bb",   "-2b",  "-2",   "-3bbb", "-3bb",  "-3b",   "-3",
        "+4",   "-4b",  "-4", "+4o", "+5",  "-5",     "+5o",  "+6",   "-6b",   "-6",    "+6o", "+7",  "-7b",   "-7",
        "+8",   "-8b",  "-8","+8o", "+9",  "-9bb", "-9b",  "-9", "+9o", "+10",   "-10bb",  "-10b",
        "-10", "+10o"];

        var powerDrawHalfValved = ["+1",  "-1b",  "-1", "+2b", "+2",  "-2bb",   "-2b",  "-2",   "-3bbb", "-3bb",  "-3b",   "-3",
        "+4",   "-4b",  "-4", "+5b", "+5",  "-5",     "+6b",  "+6",   "-6b",   "-6",    "-7b",   "-7",
        "+8",   "-8b",  "-8", "+9b", "+9",  "-9bb",     "-9b",  "-9",   "+10b",  "+10",   "-10bb",  "-10b",
        "-10" ];
        powerDrawHalfValved[-2] = "+1bb"; powerDrawHalfValved[-1] = "+1b"; //Two notes below the key at blow 1
                // Brendan Power's tuning, half valved

        var tuning = richter
        switch (harp.tuning) {
            case 1: tuning = richter; break;
            case 2: tuning = richterValved; break;
            case 3: tuning = country; break;
            case 4: tuning = standardChromatic; break;
            case 5: tuning = zirkValved; break;
            case 6: tuning = trueChrom; break;
            case 7: tuning = naturalMinor; break;
            case 8: tuning = melodyMaker; break;
            case 9: tuning = spiral_b1; break;
            case 10: tuning = paddyRichter; break;
            case 11: tuning = powerBenderHalfValved; break;
            case 12: tuning = powerDrawHalfValved; break;
            case 13: tuning = powerBender; break;
            case 14: tuning = powerDraw; break;
            default: tuning = richter; break;
        }

        var harpkey = keylist.key
        console.log("harpkey set to  " + keylist.key)

        for (var i = 0; i < notes.length; i++) {

            if ( i > 0 )
                text.text = sep + text.text;

            if (typeof notes[i].pitch === "undefined") // just in case
                return
            var tab = tuning[notes[i].pitch - harpkey];
            if (typeof tab === "undefined")
                text.text = "X";
            else {
                if (bendChar !== "b")
                    tab = tab.replace(/b/g, bendChar);
                tab = applyStyleToTabNotes(tab);
                text.text = tab + text.text;
                }
        }
    }

    function positionBreathIndicator(tab) {
         if(breathtext.position !== "right")
            return tab;
        // MuseScore doesn't appear to have a Regex library
        // So, we do this a naive way.
        // Assumes harmonicas have 1-99 holes.
        var symbol = tab[0];
        var isDoubleDigit = false;
        if(tab.length >= 3)
        {
              // Is the third character a digit? 
              for(var number = 0; number <= 9; number++) {
                    isDoubleDigit = isDoubleDigit || tab[2] == number;
              }                        
        }            
        
        var newBreathIndex = isDoubleDigit ? 2 : 1;
        var newString ="";
        for(var index = 1; index < tab.length; index++) {
            newString += tab[index]
            if(index == newBreathIndex)
                newString += symbol;
         }
        return newString;
    }
    function applyStyleToTabNotes(rawTab) {        
        var finalTab = rawTab;
                
        finalTab = positionBreathIndicator(finalTab);

        switch(breathIndicator.mode) {
            case "draw_only": finalTab = finalTab.replace("+", ""); break;
            case "blow_only": finalTab = finalTab.replace("-", ""); break;
            default: finalTab = finalTab; break;
        }

        return finalTab;
    }


    function applyToSelection(func) {
        if (typeof curScore === 'undefined')
            Qt.quit();
        var cursor = curScore.newCursor();
        var startStaff;
        var endStaff;
        var endTick;
        var fullScore = false;

        var textposition = (placetext.position === "above" ? Placement.ABOVE : Placement.BELOW);

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
                                // TODO: deal with placement of grace note on the x axis
                                text.placement = textposition
                                text.offset = Qt.point(-40 * (graceChords.length - i), 0)
                                cursor.add(text);
                                // new text for next element
                                text  = newElement(Element.STAFF_TEXT);
                            }

                            var notes = cursor.element.notes;
                            tabNotes(notes, text);
                            text.placement = textposition

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
