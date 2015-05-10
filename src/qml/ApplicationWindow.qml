import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import "." as App

ApplicationWindow {
    width: 700
    height: 700
    title: qsTr("Game Of Life")
    visible: true

    menuBar: App.MenuBar { }

    toolBar: App.ToolBar { }

    App.Board {
        id: board
        anchors.fill: parent
    }

    statusBar: App.StatusBar { }
}
