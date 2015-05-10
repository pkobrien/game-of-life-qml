import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1

ToolBar {
    anchors.fill: parent
    width: 300

    RowLayout {
        ToolButton {
            text: qsTr("Random 50x50")
            onClicked: {
                board.setSize(50, 50);
                game.populate(board.columns, board.rows);
            }
        }
        ToolButton {
            text: qsTr("Random 100x100")
            onClicked: {
                board.setSize(100, 100);
                game.populate(board.columns, board.rows);
            }
        }
        ToolButton {
            text: qsTr("Random 150x150")
            onClicked: {
                board.setSize(150, 150);
                game.populate(board.columns, board.rows);
            }
        }
        ToolButton {
            text: qsTr("Random 200x200")
            onClicked: {
                board.setSize(200, 200);
                game.populate(board.columns, board.rows);
            }
        }
        ToolButton {
            id: startButton
            text: startText
            property string startText: qsTr("Start")
            property string stopText: qsTr("Stop")
            onClicked: {
                if (text === startText)
                    game.start();
                else
                    game.stop();
            }
        }
        ToolButton {
            text: qsTr("Cycle")
            onClicked: game.cycle();
        }
    }

    Connections {
        target: game
        onStarted: startButton.text = startButton.stopText;
        onStopped: startButton.text = startButton.startText;
    }
}
