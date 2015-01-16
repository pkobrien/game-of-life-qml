import QtQuick 2.4

GolBoardForm {
    id: board

    Connections {
        target: game
        onCellsBorn: {
            for (var i = 0; i < indices.length; i++) {
                board.blocks[indices[i]].color = board.liveColor
            }
        }
        onCellsDied: {
            for (var i = 0; i < indices.length; i++) {
                board.blocks[indices[i]].color = board.deadColor
            }
        }
        onCellsInit: {
            for (var i = 0; i < indices.length; i++) {
                board.blocks[indices[i]].color = board.liveColor
            }
        }
        onReset: {
            for (var i = 0; i < board.columns * board.rows; i++) {
                board.blocks[i].color = board.emptyColor
            }
        }
    }
}
