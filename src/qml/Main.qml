import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15

import "qrc:/js/catpuccin.js" as Catpuccin

ApplicationWindow {
    id: root

    Material.theme: Material.Dark
    Material.accent: Catpuccin.mocha.blue.hex
    Material.primary: Catpuccin.mocha.mauve.hex
    Material.foreground: Catpuccin.mocha.text.hex
    Material.background: Catpuccin.mocha.base.hex

    title: "Windows Calculator Demo"
    minimumWidth: 330
    minimumHeight: 500
    width: 330
    height: 500
    visible: true
    color: Catpuccin.mocha.base.hex

    property color default_color: Catpuccin.mocha.surface0.hex
    property color accented_color: Catpuccin.mocha.surface1.hex
    property color unique_color: Catpuccin.mocha.overlay0.hex
    property color contrast_color: Catpuccin.mocha.text.hex

    component CalculatorButton : RoundButton {
        property string __icon: ""
        property bool __accented: false
        property bool __unique: false

        radius: 4

        icon {
            color: contrast_color
            source: __icon
        }

        Layout.fillWidth: true
        Layout.fillHeight: true
        Material.background: __accented ? __unique ? unique_color : accented_color : default_color
    }

    ColumnLayout {
        anchors.fill: parent
        // Input ...

        // Row ...

        GridLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true

            rowSpacing: -7
            columnSpacing: rowSpacing
            columns: 4

            Repeater {
                model: ListModel {
                    ListElement { ico: "qrc:/icons/percent.svg"; accented: false }
                    ListElement { ico: "qrc:/icons/ce.svg"; accented: false }
                    ListElement { ico: "qrc:/icons/c.svg"; accented: false }
                    ListElement { ico: "qrc:/icons/backspace.svg"; accented: false }
                    ListElement { ico: "qrc:/icons/invert.svg"; accented: false }
                    ListElement { ico: "qrc:/icons/square.svg"; accented: false }
                    ListElement { ico: "qrc:/icons/sqrt.svg"; accented: false }
                    ListElement { ico: "qrc:/icons/divide.svg"; accented: false }
                    ListElement { ico: "qrc:/icons/seven.svg"; accented: true }
                    ListElement { ico: "qrc:/icons/eight.svg"; accented: true }
                    ListElement { ico: "qrc:/icons/nine.svg"; accented: true }
                    ListElement { ico: "qrc:/icons/multiply.svg"; accented: false }
                    ListElement { ico: "qrc:/icons/four.svg"; accented: true }
                    ListElement { ico: "qrc:/icons/five.svg"; accented: true }
                    ListElement { ico: "qrc:/icons/six.svg"; accented: true }
                    ListElement { ico: "qrc:/icons/minus.svg"; accented: false }
                    ListElement { ico: "qrc:/icons/one.svg"; accented: true }
                    ListElement { ico: "qrc:/icons/two.svg"; accented: true }
                    ListElement { ico: "qrc:/icons/three.svg"; accented: true }
                    ListElement { ico: "qrc:/icons/plus.svg"; accented: false }
                    ListElement { ico: "qrc:/icons/plus-minus.svg"; accented: true }
                    ListElement { ico: "qrc:/icons/zero.svg"; accented: true }
                    ListElement { ico: "qrc:/icons/dot.svg"; accented: true }
                }

                delegate: CalculatorButton {
                    __icon: ico
                    __accented: accented
                }
            }

            CalculatorButton { __icon: "qrc:/icons/equal.svg"; __accented: true; __unique: true }
        }
    }
}
