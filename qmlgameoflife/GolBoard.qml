import QtQuick 2.4

GolBoardForm {
    id: board

    Connections {
        target: game
        onCellInit: {
            board.blocks[index].color = board.liveColor
        }
        onCellBorn: {
            board.blocks[index].color = board.liveColor
        }
        onCellDied: {
            board.blocks[index].color = board.deadColor
        }
        onReset: {
            for (var i = 0; i < board.columns * board.rows; i++) {
                board.blocks[i].color = board.emptyColor
            }
        }
    }
}
