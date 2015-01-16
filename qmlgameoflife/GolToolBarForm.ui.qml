import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1

ToolBar {

    property alias cycleButton: cycleButton
    property alias populateButton: populateButton
    property alias startButton: startButton

    width: 300

    RowLayout {
        ToolButton {
            id: populateButton
            text: qsTr("Populate")
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
