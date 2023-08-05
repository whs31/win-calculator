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

    Behavior on color { ColorAnimation { } }
    Behavior on bg_color { ColorAnimation { } }
    Behavior on default_color { ColorAnimation { } }
    Behavior on accented_color { ColorAnimation { } }
    Behavior on unique_color { ColorAnimation { } }
    Behavior on contrast_color { ColorAnimation { } }

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
                text: "123123"
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
