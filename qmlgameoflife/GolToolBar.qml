import QtQuick 2.4

GolToolBarForm {

    /* These should work, but don't. Bug in PyQt?
    cycleButton.onClicked: game.cycle()
    populateButton.onClicked: game.populate(board.columns, board.rows)
    startButton.onClicked: {
        if (startButton.text === startButton.startText) {
            game.start()
        }
        else {
            game.stop()
        }
    }
    */

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
