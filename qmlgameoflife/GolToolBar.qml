import QtQuick 2.4

GolToolBarForm {

    cycleButton.onClicked: game.cycle();
    populateButton.onClicked: game.populate(board.columns, board.rows);
    startButton.onClicked: {
        if (startButton.text == startButton.startText)
            game.start();
        else
            game.stop();
    }

    Connections {
        target: game
        onStarted: startButton.text = startButton.stopText;
        onStopped: startButton.text = startButton.startText;
    }
}
