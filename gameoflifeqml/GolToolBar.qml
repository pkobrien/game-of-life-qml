import QtQuick 2.4

GolToolBarForm {

    cycleButton.onClicked: game.cycle();
    random50Button.onClicked: {
        board.setSize(50, 50);
        game.populate(board.columns, board.rows);
    }
    random100Button.onClicked: {
        board.setSize(100, 100);
        game.populate(board.columns, board.rows);
    }
    random150Button.onClicked: {
        board.setSize(150, 150);
        game.populate(board.columns, board.rows);
    }
    random200Button.onClicked: {
        board.setSize(200, 200);
        game.populate(board.columns, board.rows);
    }
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
