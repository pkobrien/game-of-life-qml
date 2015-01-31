import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1

ToolBar {
    anchors.fill: parent
    width: 300

    property alias cycleButton: cycleButton
    property alias random50Button: random50Button
    property alias random100Button: random100Button
    property alias random150Button: random150Button
    property alias random200Button: random200Button
    property alias startButton: startButton

    RowLayout {
        ToolButton {
            id: random50Button
            text: qsTr("Random 50x50")
        }
        ToolButton {
            id: random100Button
            text: qsTr("Random 100x100")
        }
        ToolButton {
            id: random150Button
            text: qsTr("Random 150x150")
        }
        ToolButton {
            id: random200Button
            text: qsTr("Random 200x200")
        }
        ToolButton {
            id: startButton
            text: startText
            property string startText: qsTr("Start")
            property string stopText: qsTr("Stop")
        }
        ToolButton {
            id: cycleButton
            text: qsTr("Cycle")
        }
    }
}
