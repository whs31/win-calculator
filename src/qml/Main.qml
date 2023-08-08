import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15

import "qrc:/js/catpuccin.js" as Catpuccin

ApplicationWindow {
    id: root

    function colorSelect(light_active, dark_active)
    {
        if(light_mode)
        {
            if(active) return light_active
            return Qt.tint(light_active, "#20000000")
        }
        if(active) return dark_active
        return Qt.tint(dark_active, "#15FFFFFF")
    }

    property bool light_mode: false

    Material.theme: light_mode ? Material.Light : Material.Dark
    Material.accent: colorSelect(Catpuccin.latte.blue.hex, Catpuccin.mocha.blue.hex)
    Material.primary: colorSelect(Catpuccin.latte.mauve.hex, Catpuccin.mocha.mauve.hex)
    Material.foreground: contrast_color
    Material.background: bg_color

    title: "Windows Calculator Demo"
    minimumWidth: 320
    minimumHeight: 470
    width: 320
    height: 470
    visible: true
    color: Material.background

    property color bg_color: colorSelect(Catpuccin.latte.base.hex, Catpuccin.mocha.base.hex)
    property color default_color: colorSelect(Catpuccin.latte.surface0.hex, Catpuccin.mocha.surface0.hex)
    property color accented_color: colorSelect(Catpuccin.latte.surface1.hex, Catpuccin.mocha.surface1.hex)
    property color unique_color: colorSelect(Catpuccin.latte.overlay0.hex, Catpuccin.mocha.overlay0.hex)
    property color contrast_color: colorSelect(Catpuccin.latte.text.hex, Catpuccin.mocha.text.hex)

    Behavior on color { ColorAnimation { easing.type: Easing.InOutQuad } }
    Behavior on bg_color { ColorAnimation { easing.type: Easing.InOutQuad } }
    Behavior on default_color { ColorAnimation { easing.type: Easing.InOutQuad } }
    Behavior on accented_color { ColorAnimation { easing.type: Easing.InOutQuad } }
    Behavior on unique_color { ColorAnimation { easing.type: Easing.InOutQuad } }
    Behavior on contrast_color { ColorAnimation { easing.type: Easing.InOutQuad } }

    header: ToolBar {
        Material.primary: bg_color
        Layout.fillWidth: true

        RowLayout {
            anchors.fill: parent

            ToolButton {
                id: ctrl
                icon {
                    color: contrast_color
                    source: "qrc:/icons/ui/menu.svg"
                }

                onPressed: {
                    anim.start()
                    sidepanel.open()
                }

                SequentialAnimation {
                    id: anim

                    PropertyAnimation {
                        target: ctrl
                        property: "scale"
                        to: 0.8
                        duration: 100
                        easing.type: Easing.InOutQuad
                    }

                    PropertyAnimation {
                        target: ctrl
                        property: "scale"
                        to: 1.0
                        duration: 100
                        easing.type: Easing.InOutQuad
                    }
                }
            }

            Text {
                Layout.fillWidth: true
                text: "Обычный"
                font {
                    pixelSize: 20
                    weight: Font.DemiBold
                }
                color: contrast_color
            }

            ToolButton {
                icon {
                    color: contrast_color
                    source: "qrc:/icons/ui/history.svg"
                }
            }
        }
    }

    Drawer {
        id: sidepanel
        width: parent.width * 0.66
        height: parent.height

        ToolButton {
            id: ctrl2
            icon {
                color: contrast_color
                source: "qrc:/icons/ui/menu.svg"
            }

            onPressed: {
                anim2.start()
                sidepanel.close()
            }

            SequentialAnimation {
                id: anim2

                PropertyAnimation {
                    target: ctrl2
                    property: "scale"
                    to: 0.8
                    duration: 100
                    easing.type: Easing.InOutQuad
                }

                PropertyAnimation {
                    target: ctrl2
                    property: "scale"
                    to: 1.0
                    duration: 100
                    easing.type: Easing.InOutQuad
                }
            }
        }

        ColumnLayout {
            anchors.top: ctrl2.bottom
            anchors.left: parent.left
            anchors.right: parent.right

            Button {
                icon {
                    color: contrast_color
                    source: light_mode ? "qrc:/icons/ui/light.svg" : "qrc:/icons/ui/dark.svg"
                }
                flat: true
                text: "Переключить тему"
                onPressed: light_mode = !light_mode
            }
        }
    }

    component CalculatorButton : RoundButton {
        property string __icon: ""
        property bool __accented: false
        property bool __unique: false
        property Action __action: null

        radius: 4

        icon {
            color: contrast_color
            source: __icon
        }

        action: __action

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
                Layout.topMargin: 10
                Layout.rightMargin: 5
                font {
                    pixelSize: 20
                }
                color: accented_color
                text: "23+1"
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignRight
            }

            TextInput {
                function getInputFontSize(l)
                {
                    if(l <= 13) return 42
                    if(l <= 14) return 40
                    if(l <= 15) return 38
                    if(l <= 16) return 34
                    if(l <= 17) return 33
                    if(l <= 18) return 29
                    return 28
                }

                Layout.fillWidth: true
                Layout.preferredHeight: 60
                id: input
                selectByMouse: true
                maximumLength: 17
                inputMethodHints: Qt.ImhFormattedNumbersOnly
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignBottom
                font {
                    pixelSize: getInputFontSize(length)
                    weight: Font.DemiBold
                }
                text: ""
                readOnly: true
                color: contrast_color
                selectionColor: accented_color
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

            rowSpacing: -9
            columnSpacing: rowSpacing
            columns: 4

            component DigitAction : Action {
                property string value: ""
                property string sequence: ""
                shortcut: sequence
                onTriggered: input.insert(input.length, value)
            }

            CalculatorButton { __icon: "qrc:/icons/percent.svg"; __accented: false }
            CalculatorButton { __icon: "qrc:/icons/ce.svg"; __accented: false; __action: Action { shortcut: "C"; onTriggered: input.clear() } }
            CalculatorButton { __icon: "qrc:/icons/c.svg"; __accented: false; __action: Action { shortcut: "Shift+C"; onTriggered: input.clear() } }
            CalculatorButton { __icon: "qrc:/icons/backspace.svg"; __accented: false; __action: Action { shortcut: "Backspace"; onTriggered: input.remove(input.length - 1, input.length) } }
            CalculatorButton { __icon: "qrc:/icons/invert.svg"; __accented: false }
            CalculatorButton { __icon: "qrc:/icons/square.svg"; __accented: false }
            CalculatorButton { __icon: "qrc:/icons/sqrt.svg"; __accented: false }
            CalculatorButton { __icon: "qrc:/icons/divide.svg"; __accented: false }
            CalculatorButton { __icon: "qrc:/icons/seven.svg"; __accented: true; __action: DigitAction { value: "7"; sequence: "7" } }
            CalculatorButton { __icon: "qrc:/icons/eight.svg"; __accented: true; __action: DigitAction { value: "8"; sequence: "8" } }
            CalculatorButton { __icon: "qrc:/icons/nine.svg"; __accented: true; __action: DigitAction { value: "9"; sequence: "9" } }
            CalculatorButton { __icon: "qrc:/icons/multiply.svg"; __accented: false }
            CalculatorButton { __icon: "qrc:/icons/four.svg"; __accented: true; __action: DigitAction { value: "4"; sequence: "4" } }
            CalculatorButton { __icon: "qrc:/icons/five.svg"; __accented: true; __action: DigitAction { value: "5"; sequence: "5" } }
            CalculatorButton { __icon: "qrc:/icons/six.svg"; __accented: true; __action: DigitAction { value: "6"; sequence: "6" } }
            CalculatorButton { __icon: "qrc:/icons/minus.svg"; __accented: false }
            CalculatorButton { __icon: "qrc:/icons/one.svg"; __accented: true; __action: DigitAction { value: "1"; sequence: "1" } }
            CalculatorButton { __icon: "qrc:/icons/two.svg"; __accented: true; __action: DigitAction { value: "2"; sequence: "2" } }
            CalculatorButton { __icon: "qrc:/icons/three.svg"; __accented: true; __action: DigitAction { value: "3"; sequence: "3" } }
            CalculatorButton { __icon: "qrc:/icons/plus.svg"; __accented: false }
            CalculatorButton { __icon: "qrc:/icons/plus-minus.svg"; __accented: true }
            CalculatorButton { __icon: "qrc:/icons/zero.svg"; __accented: true; __action: DigitAction { value: "0"; sequence: "0" } }
            CalculatorButton { __icon: "qrc:/icons/dot.svg"; __accented: true }
            CalculatorButton { __icon: "qrc:/icons/equal.svg"; __accented: true; __unique: true }
        }
    }
}
