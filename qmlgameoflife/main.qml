import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QtQuick.Window 2.2

ApplicationWindow {
    title: qsTr("Game Of Life")
    width: 700
    height: 700
    visible: true

    menuBar: MenuBar {
        Menu {
            title: qsTr("&File")
            MenuItem {
                text: qsTr("E&xit")
                onTriggered: Qt.quit();
            }
        }
    }

    toolBar: GolToolBar {
        anchors.fill: parent
    }

    GolBoard {
        id: board
        anchors.fill: parent
        columns: 50
        rows: 50
    }

    statusBar: GolStatusBar {
        anchors.fill: parent
    }
}
