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

    toolBar: ToolBar {
        RowLayout {
            anchors.fill: parent
            ToolButton {
                text: qsTr("Populate")
                onClicked: game.populate(board.columns, board.rows)
            }
            ToolButton {
                id: startButton
                text: startText
                property string startText: qsTr("Start")
                property string stopText: qsTr("Stop")
                onClicked: {
                    if (text == startText) {
                        game.start()
                    }
                    else {
                        game.stop()
                    }
                }
            }
            ToolButton {
                text: qsTr("Cycle")
                onClicked: game.cycle()
            }
        }
    }

    Board {
        id: board
        anchors.fill: parent
        columns: 50
        rows: 50
    }

    statusBar: StatusBar {
        RowLayout {
            anchors.fill: parent
            Label { text: qsTr("Area: %L1 cells").arg(game.width * game.height) }
            Label { text: qsTr("Generations: %L1").arg(game.generations) }
            Label { text: qsTr("Population: %L1 Living, %L2 Dead").arg(game.live_count).arg(game.dead_count) }
            Label { text: qsTr("Nursery: %L1 Newborn").arg(game.new_born_count) }
            Label { text: qsTr("Cemetery: %L1 Deceased").arg(game.new_dead_count) }
        }
    }

    Connections {
        target: game
        onStarted: {
            startButton.text = startButton.stopText
        }
        onStopped: {
            startButton.text = startButton.startText
        }
    }
}
