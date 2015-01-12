import QtQuick 2.4

GolToolBarForm {

    Connections {
        target: game
        onStarted: startButton.text = startButton.stopText
        onStopped: startButton.text = startButton.startText
    }

    Connections {
        target: cycleButton
        onClicked: game.cycle()
    }

    Connections {
        target: populateButton
        onClicked: game.populate(board.columns, board.rows)
    }

    Connections {
        target: startButton
        onClicked: {
            if (startButton.text === startButton.startText) {
                game.start()
            }
            else {
                game.stop()
            }
        }
    }
}

