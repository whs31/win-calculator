import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15

import "qrc:/js/catpuccin.js" as Catpuccin

ApplicationWindow {
    id: root

    property bool light_mode: false

    Material.theme: light_mode ? Material.Light : Material.Dark
    Material.accent: light_mode ? Catpuccin.latte.blue.hex : Catpuccin.mocha.blue.hex
    Material.primary: light_mode ? Catpuccin.latte.mauve.hex : Catpuccin.mocha.mauve.hex
    Material.foreground: light_mode ? Catpuccin.latte.text.hex : Catpuccin.mocha.text.hex
    Material.background: light_mode ? Catpuccin.latte.base.hex : Catpuccin.mocha.base.hex

    title: "Windows Calculator Demo"
    minimumWidth: 330
    minimumHeight: 500
    width: 330
    height: 500
    visible: true
    color: Material.background

    property color bg_color: light_mode ? Catpuccin.latte.base.hex : Catpuccin.mocha.base.hex
    property color default_color: light_mode ? Catpuccin.latte.surface0.hex : Catpuccin.mocha.surface0.hex
    property color accented_color: light_mode ? Catpuccin.latte.surface1.hex : Catpuccin.mocha.surface1.hex
    property color unique_color: light_mode ? Catpuccin.latte.overlay0.hex : Catpuccin.mocha.overlay0.hex
    property color contrast_color: light_mode ? Catpuccin.latte.text.hex : Catpuccin.mocha.text.hex

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

    component CalculatorMemBarButton : RoundButton {
        property string __text: ""

        radius: 2
        flat: true

        font {
            pixelSize: 14
            weight: Font.DemiBold
        }
        text: __text
        Layout.fillWidth: true
        Material.background: bg_color
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: -7

        ColumnLayout {
            Layout.fillWidth: true

            Text {
                font {
                    pixelSize: 24
                }
                color: accented_color
                text: "23+1"
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignRight
            }

            TextField {
                Layout.fillWidth: true
                id: input
                selectByMouse: true
                inputMethodHints: Qt.ImhFormattedNumbersOnly
                horizontalAlignment: Text.AlignRight
                font {
                    pixelSize: 42
                    weight: Font.DemiBold
                }
                text: "123123"
            }
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: -7

            CalculatorMemBarButton { __text: "MC"; enabled: false }
            CalculatorMemBarButton { __text: "MR"; enabled: false }
            CalculatorMemBarButton { __text: "M+" }
            CalculatorMemBarButton { __text: "M-" }
            CalculatorMemBarButton { __text: "MS" }
            CalculatorMemBarButton { __text: "M˅"; enabled: false }
        }

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
