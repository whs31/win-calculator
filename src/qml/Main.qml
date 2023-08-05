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

    component CalculatorButton : Button {
        property string __text: ""
        property bool __accented: false

        text: __text
        font {
            pixelSize: 15
            weight: Font.Bold
        }
        Layout.fillWidth: true
        Layout.fillHeight: true
        Material.background: __accented ? accented_color : default_color
    }

    ColumnLayout {
        anchors.fill: parent
        // Input ...

        // Row ...

        GridLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true

            columns: 4

            CalculatorButton {
                __text: "%"
            }

            CalculatorButton {
                __text: "CE"
            }

            CalculatorButton {
                __text: "C"
            }

            CalculatorButton {
                __text: "<<"
            }

            CalculatorButton {
                __text: "1/x"
            }

            CalculatorButton {
                __text: "x^2"
            }

            CalculatorButton {
                __text: "sqrt(x)"
            }

            CalculatorButton {
                __text: "/"
            }

            CalculatorButton {
                __text: "7"
            }

            CalculatorButton {
                __text: "8"
            }

            CalculatorButton {
                __text: "9"
            }

            CalculatorButton {
                __text: "X"
            }

            CalculatorButton {
                __text: "4"
            }

            CalculatorButton {
                __text: "5"
            }

            CalculatorButton {
                __text: "6"
            }

            CalculatorButton {
                __text: "-"
            }

            CalculatorButton {
                __text: "1"
            }

            CalculatorButton {
                __text: "2"
            }

            CalculatorButton {
                __text: "3"
            }

            CalculatorButton {
                __text: "+"
            }

            CalculatorButton {
                __text: "+-"
            }

            CalculatorButton {
                __text: "0"
            }

            CalculatorButton {
                __text: ","
            }

            CalculatorButton {
                __text: "="
            }
        }
    }
}
