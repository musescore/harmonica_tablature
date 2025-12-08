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

import QtQuick 
import QtQuick.Controls 
import QtQuick.Layouts
import MuseScore 3.0

MuseScore {

    version: "4.6"
    description: "Harmonica Tab plugin, cleaned up code, stylized selection box, added text color and size options, added tremolo 24-hole harmonica, added chromatic 10-hole harmonica, updated default selections. Updated by Joshua Buys"
    pluginType: "dialog"
    title: "Harmonica Tablature Setup"
    thumbnailName: "harmonica_tabs.png"

// ------ OPTIONS -------
    property string sep : "\n"     // change to "," if you want tabs horizontally
    property string bendChar : "'" // change to "b" if you want bend to be noted with b
// ------ OPTIONS -------

    id: window
    width: 550
    height: 300

    property var itemTextX1 : 20
    property var itemTextY1 : 20
    property var itemTextY2 : 20
    property var xPositionInit : 0.0
    property var yPositionInit : 0.0
    property color dropdownBase: "lightsteelblue"
    property color dropdownText: "#001B2E"

    Rectangle {
        id: mainInput
        anchors.fill: parent
        color: "#000A57"
        
        function comboStyle() {
        }
        
        Column {
            id: column
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.margins: 10
            spacing: 17
            //z: 5
            anchors.topMargin: 25
            height: parent.height - 70
            
            Row {
                id:keyRow
                spacing: 20
                width: parent.width
                x: 20

                Label {
                    font.pointSize: 14
                    font.family: "Inter"
                    //font.weight: Font.ExtraBold
                    font.bold: true
                    color: "#00C8D7"
                    anchors.verticalCenter: parent.verticalCenter
                    width: parent.width / 4
                    horizontalAlignment: Text.AlignRight
                    text: "Harmonica key:"
                }
                
                ComboBox {
                    id: keyBox
                    anchors.verticalCenter: parent.verticalCenter
                    textRole: "text"
                    implicitWidth: 50
                    implicitHeight: 25
                    
                    background: Rectangle {
                        color: dropdownBase
                        radius: 12
                        clip: true
                    }
                    
                    contentItem: Text {
                        text: keyBox.displayText
                        color: dropdownText
                        font.pointSize: 12
                        font.bold: true
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                        leftPadding: 15
                    }
                    
                    currentIndex: 17
                    model: ListModel {
                        id: keylist
                        property var key: undefined  // Initialize property with default value (updated F# to 54)
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
                        ListElement { text: "Low F#"; harpkey: 54 }
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
                    
                    onCurrentIndexChanged: {
                        // Validate currentIndex
                        if (currentIndex >= 0 && currentIndex < keylist.count) {
                            // Retrieve the current item
                            var currentItem = keylist.get(currentIndex);
                            // Debugging output
                            console.debug("Selected item:", currentItem.text, ", Harpkey:", currentItem.harpkey);
                            // Set the key property
                            keylist.key = currentItem.harpkey;
                        } else {
                            console.error("Invalid currentIndex:", currentIndex);
                        }
                    }

                    Component.onCompleted: {
                        // Set initial harpkey value
                        if (currentIndex >= 0 && currentIndex < keylist.count) {
                            var initialItem = keylist.get(currentIndex);
                            keylist.key = initialItem.harpkey;
                            console.debug("Initial item:", initialItem.text, ", Harpkey:", initialItem.harpkey);
                        } else {
                            console.error("Invalid initial currentIndex:", currentIndex);
                        }
                    }
                }
            }

                    
            Row {
                id:typeRow
                spacing: 20
                width: parent.width
                x: 20
                
                Label {
                    font.pointSize: 14
                    font.family: "Inter"
                    //font.weight: Font.ExtraBold
                    font.bold: true
                    color: "#00C8D7"
                    anchors.verticalCenter: parent.verticalCenter
                    width: parent.width / 4
                    horizontalAlignment: Text.AlignRight
                    text: "Harmonica type:"
                }
                
                ComboBox {
                    id: typeBox
                    anchors.verticalCenter: parent.verticalCenter
                    textRole: "text"
                    implicitWidth: 300
                    implicitHeight: 25
                    
                    background: Rectangle {
                        color: dropdownBase
                        radius: 12
                        clip: true
                    }
                    
                    contentItem: Text {
                        text: typeBox.displayText
                        color: dropdownText
                        font.pointSize: 12
                        font.bold: true
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                        leftPadding: 15
                    }
                    
                    currentIndex: 0
                    model: ListModel {
                        id: harp
                        property var tuning: undefined  // Initialize property with default value, updated list order for consistency through code
                        ListElement { text: "Blues Harp (Richter)"; tuning: 1 }
                        ListElement { text: "Richter valved"; tuning: 2 }
                        ListElement { text: "Country"; tuning: 3 }
                        ListElement { text: "Chromatic 10 Hole"; tuning: 4 }
                        ListElement { text: "Chromatic 12 Hole"; tuning: 5 }
                        ListElement { text: "Chromatic 16 Hole"; tuning: 6 }
                        ListElement { text: "Circular (Seydel), valved"; tuning: 7 }
                        ListElement { text: "TrueChromatic Diatonic, valved"; tuning: 8 }
                        ListElement { text: "Natural Minor"; tuning: 9 }
                        ListElement { text: "Melody Maker"; tuning: 10 }
                        ListElement { text: "Circular (Inversed for blow 1), valved "; tuning: 11 }
                        ListElement { text: "Paddy Richter (Brendan Power), valved"; tuning: 12 }
                        ListElement { text: "Power Bender (Brendan Power), valved"; tuning: 13 }
                        ListElement { text: "Power Draw (Brendan Power), valved"; tuning: 14 }
                        ListElement { text: "Tremolo 24-hole"; tuning: 15 } // (added tremolo 24-hole option)
                    }

                    onCurrentIndexChanged: {
                        // Validate currentIndex
                        if (currentIndex >= 0 && currentIndex < harp.count) {
                            // Retrieve the current item
                            var currentItem = harp.get(currentIndex);
                            // Debugging output
                            console.debug("Selected item:", currentItem.text, ", Tuning:", currentItem.tuning);
                            // Set the tuning property
                            harp.tuning = currentItem.tuning;
                        } else {
                            console.error("Invalid currentIndex:", currentIndex);
                        }
                    }

                    Component.onCompleted: {
                        // Set initial tuning value
                        if (currentIndex >= 0 && currentIndex < harp.count) {
                            var initialItem = harp.get(currentIndex);
                            harp.tuning = initialItem.tuning;
                            console.debug("Initial item:", initialItem.text, ", Tuning:", initialItem.tuning);
                        } else {
                            console.error("Invalid initial currentIndex:", currentIndex);
                        }
                    }
                }
            }
                    
            Row {
                id:positionRow
                spacing: 20
                width: parent.width
                x: 20
                
                Label {
                    font.pointSize: 14
                    font.family: "Inter"
                    //font.weight: Font.ExtraBold
                    font.bold: true
                    color: "#00C8D7"
                    anchors.verticalCenter: parent.verticalCenter
                    width: parent.width / 4
                    horizontalAlignment: Text.AlignRight
                    text: "Position:"
                }
                
                ComboBox {
                    id: positionBox
                    anchors.verticalCenter: parent.verticalCenter
                    textRole: "text"
                    implicitWidth: 125
                    implicitHeight: 25
                    
                    background: Rectangle {
                        color: dropdownBase
                        radius: 12
                        clip: true
                    }
                    
                    contentItem: Text {
                        text: positionBox.displayText
                        color: dropdownText
                        font.pointSize: 12
                        font.bold: true
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                        leftPadding: 15
                    }
                    
                    currentIndex: 0
                    model: ListModel {
                        id: placetext
                        property var position: undefined  // Initialize property with default value
                        ListElement { text: "Above staff"; position: "above" }
                        ListElement { text: "Below staff"; position: "below" }
                    }

                    onCurrentIndexChanged: {
                        // Validate currentIndex
                        if (currentIndex >= 0 && currentIndex < placetext.count) {
                            // Retrieve the current item
                            var currentItem = placetext.get(currentIndex);
                            // Debugging output
                            console.debug("Selected item:", currentItem.text, ", Position:", currentItem.position);
                            // Set the position property
                            placetext.position = currentItem.position;
                        } else {
                            console.error("Invalid currentIndex:", currentIndex);
                        }
                    }

                    Component.onCompleted: {
                        // Set initial position value
                        if (currentIndex >= 0 && currentIndex < placetext.count) {
                            var initialItem = placetext.get(currentIndex);
                            placetext.position = initialItem.position;
                            console.debug("Initial item:", initialItem.text, ", Position:", initialItem.position);
                        } else {
                            console.error("Invalid initial currentIndex:", currentIndex);
                        }
                    }
                }
            }
                    
            Row {
                id:colorRow
                spacing: 20
                width: parent.width
                x: 20
                
                Label {
                    font.pointSize: 14
                    font.family: "Inter"
                    //font.weight: Font.ExtraBold
                    font.bold: true
                    color: "#00C8D7"
                    anchors.verticalCenter: parent.verticalCenter
                    width: parent.width / 4
                    horizontalAlignment: Text.AlignRight
                    text: "Color:"
                }
                
                ComboBox {
                    id: colorBox
                    anchors.verticalCenter: parent.verticalCenter
                    textRole: "text"
                    implicitWidth: 100
                    implicitHeight: 25
                    
                    background: Rectangle {
                        color: dropdownBase
                        radius: 12
                        clip: true
                    }
                    
                    contentItem: Text {
                        text: colorBox.displayText
                        color: dropdownText
                        font.pointSize: 12
                        font.bold: true
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                        leftPadding: 15
                    }
                    
                    currentIndex: 2
                    model: ListModel {
                        id: colorlist
                        property var textColor: undefined  // Initialize property with default value (added color option)
                        ListElement { text: "Black"; colorkey: "black" }
                        ListElement { text: "Brown"; colorkey: "brown" }
                        ListElement { text: "Red"; colorkey: "red" }
                        ListElement { text: "Pink"; colorkey: "deeppink" }
                        ListElement { text: "Orange"; colorkey: "orange" }
                        ListElement { text: "Green"; colorkey: "green" }
                        ListElement { text: "Blue"; colorkey: "blue" }
                        ListElement { text: "Purple"; colorkey: "purple" }
                    }

                    onCurrentIndexChanged: {
                        // Validate currentIndex
                        if (currentIndex >= 0 && currentIndex < colorlist.count) {
                            // Retrieve the current item
                            var currentItem = colorlist.get(currentIndex);
                            // Debugging output
                            console.debug("Selected item:", currentItem.text, ", Color:", currentItem.colorkey);
                            // Set the color property
                            colorlist.textColor = currentItem.colorkey;
                        } else {
                            console.error("Invalid currentIndex:", currentIndex);
                        }
                    }

                    Component.onCompleted: {
                        // Set initial color value
                        if (currentIndex >= 0 && currentIndex < colorlist.count) {
                            var initialItem = colorlist.get(currentIndex);
                            colorlist.textColor = initialItem.colorkey;
                            console.debug("Initial item:", initialItem.text, ", Color:", initialItem.colorkey);
                        } else {
                            console.error("Invalid initial currentIndex:", currentIndex);
                        }
                    }
                }
            }
                    
            Row {
                id: sizeRow
                spacing: 20
                width: parent.width
                x: 20
                
                Label {
                    font.pointSize: 14
                    font.family: "Inter"
                    //font.weight: Font.ExtraBold
                    font.bold: true
                    color: "#00C8D7"
                    anchors.verticalCenter: parent.verticalCenter
                    width: parent.width / 4
                    horizontalAlignment: Text.AlignRight
                    text: "Font Size:"
                }
            
                ComboBox {
                    id: sizeBox
                    anchors.verticalCenter: parent.verticalCenter
                    textRole: "text"
                    implicitWidth: 50
                    implicitHeight: 25
                    
                    background: Rectangle {
                        color: dropdownBase
                        radius: 12
                        clip: true
                    }
                    
                    contentItem: Text {
                        text: sizeBox.displayText
                        color: dropdownText
                        font.pointSize: 12
                        font.bold: true
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                        leftPadding: 15
                    }
                    
                    currentIndex: 1
                    model: ListModel {
                        id: sizelist
                        property var textSize: undefined  // Initialize property with default value (added font size option)
                        ListElement { text: "10"; sizekey: 10 }
                        ListElement { text: "12"; sizekey: 12 }
                        ListElement { text: "14"; sizekey: 14 }
                        ListElement { text: "16"; sizekey: 16 }
                        ListElement { text: "18"; sizekey: 18 }
                    }

                    onCurrentIndexChanged: {
                        // Validate currentIndex
                        if (currentIndex >= 0 && currentIndex < sizelist.count) {
                            // Retrieve the current item
                            var currentItem = sizelist.get(currentIndex);
                            // Debugging output
                            console.debug("Selected item:", currentItem.text, ", Color:", currentItem.sizekey);
                            // Set the color property
                            sizelist.textSize = currentItem.sizekey;
                        } else {
                            console.error("Invalid currentIndex:", currentIndex);
                        }
                    }

                    Component.onCompleted: {
                        // Set initial font size value
                        if (currentIndex >= 0 && currentIndex < sizelist.count) {
                            var initialItem = sizelist.get(currentIndex);
                            sizelist.textSize = initialItem.sizekey;
                            console.debug("Initial item:", initialItem.text, ", Color:", initialItem.sizekey);
                        } else {
                            console.error("Invalid initial currentIndex:", currentIndex);
                        }
                    }
                }    
            }
        }
    }

    Row {
        id: buttonRow
        height: 40
        anchors.bottomMargin: 20
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 20
        
        Button {
            id: applyButton
            width: 110
            height: 40
            text: "Apply"
            background: Rectangle {
                color: "#49A26E"
                anchors.fill: parent
                radius: 18
            }
            
            contentItem: Text {
                text: applyButton.text
                color: "#003D12"
                font.pointSize: 18
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            
            onClicked: {
                apply()
                quit()
            }
        }
        
        Button {
            id: cancelButton
            width: 110
            height: 40
            text: "Cancel"
            background: Rectangle {
                color: "#E56579"
                anchors.fill: parent
                radius: 18
            }
            
            contentItem: Text {
                text: cancelButton.text
                color: "#680000"
                //color: "#315611"
                font.pointSize: 18
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            onClicked: { 
                quit()
            }
        }
    }

    function tabNotes(notes, text) { // updated order for consistency throughout code

        var richter = ["+1",  "-1b",  "-1", "+1o", "+2",  "-2bb",   "-2b",  "+3",   "-3bbb", "-3bb",  "-3b",   "-3",
        "+4",   "-4b",  "-4", "+4o", "+5",  "-5",     "+5o",  "+6",   "-6b",   "-6",    "+6o",   "-7",
        "+7",   "-7o",  "-8", "+8b", "+8",  "-9",     "+9b",  "+9",   "-9o",  "-10",   "+10bb",  "+10b",
        "+10", "-10o" ];    //Standard Richter tuning with overbends (updated -2 to +3 (same note) as it's used more often)

        var richterValved = ["+1",  "-1b",  "-1", "+2b", "+2",  "-2bb",   "-2b",  "-2",   "-3bbb", "-3bb",  "-3b",   "-3",
        "+4",   "-4b",  "-4", "+5b", "+5",  "-5",     "+6b",  "+6",   "-6b",   "-6",    "-7b",   "-7",
        "+7",   "-8b",  "-8", "+8b", "+8",  "-9",     "+9b",  "+9",   "-10b",  "-10",   "+10bb",  "+10b",
        "+10" ];
        richterValved[-2] = "+1bb"; richterValved[-1] = "+1b"; //Two notes below the key at blow 1

        var country = ["+1",  "-1b",  "-1", "+1o", "+2",  "-2bb",   "-2b",  "-2",   "-3bbb", "-3bb",  "-3b",   "-3",
        "+4",   "-4b",  "-4", "+4o", "+5",  "-5b",     "-5",  "+6",   "-6b",   "-6",    "+6o",   "-7",
        "+7",   "-7o",  "-8", "+8b", "+8",  "-9",     "+9b",  "+9",   "-9o",  "-10",   "+10bb",  "+10b",
        "+10", "-10o" ];

        var chromatic10hole = ["+1", '+1s', "-1", "-1s", "+2", "-2", "-2s", "+3", "+3s", "-3", "-3s","-4",
        "+5", "+5s", "-5", "-5s", "+6", "-6", "-6s", "+7",  "+7s", "-7", "-7s", "-8",
        "+8", "+8s", "-9", "-9s", "+9", "-10", "-10s", "+10", "+10s" ];

        var standardChromatic = ["+1", '+1s', "-1", "-1s", "+2", "-2", "-2s", "+3", "+3s", "-3", "-3s","-4",
        "+5", "+5s", "-5", "-5s", "+6", "-6", "-6s", "+7",  "+7s", "-7", "-7s", "-8",
        "+8", "+8s", "-9", "-9s", "+10", "-10", "-10s", "+11", "+11s", "-11", "-11s", "-12",
        "+12", "+12s", "-12", "-12s" ]; // updated +4 to +5 (same note) as it's used more often

        var chromatic16H = ["+1.", "+1.s", "-1.", "-1.s", "+2.", "-2.", "-2.s", "+3.", "+3.s", "-3.", "-3.s","-4.",
         "+1", "+1<", "-1", "-1s", "+2", "-2", "-2s", "+3", "+3s", "-3", "-3s","-4",
        "+4", "+5s", "-5", "-5s", "+6", "-6", "-6s", "+7",  "+7s", "-7", "-7s", "-8",
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

        var paddyRichter = ["+1",  "-1b",  "-1", "+2b", "+2",  "-2bb",   "-2b",  "-2",   "+3b", "+3",  "-3b",   "-3",
        "+4",   "-4b",  "-4", "+5b", "+5",  "-5",     "+6b",  "+6",   "-6b",   "-6",    "-7b",   "-7",
        "+7",   "-8b",  "-8", "+8b", "+8",  "-9",     "+9b",  "+9",   "-10b",  "-10",   "+10bb",  "+10b",
        "+10" ];
        paddyRichter[-2] = "+1bb"; paddyRichter[-1] = "+1b"; //Two notes below the key at blow 1
                // Brendan Power's tuning, half valved
                
        var powerBender = ["+1",  "-1b",  "-1", "+2b", "+2",  "-2bb",   "-2b",  "-2",   "-3bbb", "-3bb",  "-3b",   "-3",
        "+4",   "-4b",  "-4", "-5b", "-5",  "+6",     "-6b",  "-6",   "+7b",   "+7",    "-7b",   "-7",
        "+8",   "-8b",  "-8", "+9b", "+9",  "-9bb",     "-9b",  "-9",   "+10b",  "+10",   "-10bb",  "-10b",
        "-10" ];
        powerBender[-2] = "+1bb"; powerBender[-1] = "+1b"; //Two notes below the key at blow 1
                // Brendan Power's tuning, half valved

        var powerDraw = ["+1",  "-1b",  "-1", "+2b", "+2",  "-2bb",   "-2b",  "-2",   "-3bbb", "-3bb",  "-3b",   "-3",
        "+4",   "-4b",  "-4", "+5b", "+5",  "-5",     "+6b",  "+6",   "-6b",   "-6",    "-7b",   "-7",
        "+8",   "-8b",  "-8", "+9b", "+9",  "-9bb",     "-9b",  "-9",   "+10b",  "+10",   "-10bb",  "-10b",
        "-10" ];
        powerDraw[-2] = "+1bb"; powerDraw[-1] = "+1b"; //Two notes below the key at blow 1
                // Brendan Power's tuning, half valved
                
        var tremolo24 = ["+3",  "-2b",  "-2", "+3o", "+5",  "-4",     "+7o",  "+7",   "-6b",   "-6",    "-8b",   "-8",
        "+9",   "-10b",  "-10", "+11o", "+11",  "-12",     "+13o",  "+13",   "-14b",   "-14",    "-16b",   "-16",
        "+15",   "-16o",  "-18", "+17b", "+17",  "-20",     "+19b",  "+19",   "-20o",  "-22",   "+24b",  "+24",
        "+21", "-22o" ];    //Standard Richter tuning with overbends (added tremolo24 notes)

        
        var tuning = richter
        switch (harp.tuning) {
            case 1: tuning = richter; break;
            case 2: tuning = richterValved; break;
            case 3: tuning = country; break;
            case 4: tuning = chromatic10hole; break;
            case 5: tuning = standardChromatic; break;
            case 6: tuning = chromatic16H; break;
            case 7: tuning = zirkValved; break;
            case 8: tuning = trueChrom; break;
            case 9: tuning = naturalMinor; break;
            case 10: tuning = melodyMaker; break;
            case 11: tuning = spiral_b1; break;
            case 12: tuning = paddyRichter; break;
            case 13: tuning = powerBender; break;
            case 14: tuning = powerDraw; break;
            case 15: tuning = tremolo24; break; // (added tremolo24 option)
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
                text.text = tab + text.text;
            }
        }
    }

    function applyToSelection(func) {
        if (typeof curScore === 'undefined')
            quit();
        var cursor = curScore.newCursor();
        var startStaff;
        var endStaff;
        var endTick;
        var fullScore = false;
        var textposition = (placetext.position === "above" ? Placement.ABOVE : Placement.BELOW);
        var textcolor = colorlist.textColor // added color option
        var textsize = sizelist.textSize // added font size option
        
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
                            var text = newElement(Element.LYRICS);

                            var graceChords = cursor.element.graceNotes;
                            for (var i = 0; i < graceChords.length; i++) {
                                // iterate through all grace chords
                                var notes = graceChords[i].notes;
                                tabNotes(notes, text);
                                // TODO: deal with placement of grace note on the x axis
                                text.placement = textposition
                                text.color = textcolor // added color option
                                text.offset = Qt.point(-2 * (graceChords.length - i), 0)
                                text.fontSize = textsize // added font size option
                                cursor.add(text);
                                // new text for next element
                                text  = newElement(Element.LYRICS);
                            }

                            var notes = cursor.element.notes;
                            tabNotes(notes, text);
                            text.placement = textposition
                            text.fontSize = textsize // added font size option
                            text.color = textcolor // added color option

                            cursor.add(text);
                        } // end if CHORD
                        cursor.next();
                    } // end while segment
            } // end for voice
        } // end for staff
       quit();
    } // end applyToSelection()

    function apply() {
        curScore.startCmd()
        applyToSelection(tabNotes)
        curScore.endCmd()
    }

    onRun: {
        if (typeof curScore === 'undefined')
            quit();
    }
}


