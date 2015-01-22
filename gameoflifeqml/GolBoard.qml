import QtQuick 2.4

GolBoardForm {
    id: board

    Connections {
        target: game
        onCellsBorn: {
            for (var i = 0; i < indices.length; i++) {
                var index = indices[i];
                var block = blocks[index];
                block.born(index, blocks);
            }
        }
        onCellsDied: {
            for (var i = 0; i < indices.length; i++) {
                blocks[indices[i]].died();
            }
        }
        onCellsInit: {
            for (var i = 0; i < indices.length; i++) {
                blocks[indices[i]].init();
            }
        }
        onReset: {
            for (var i = 0; i < columns * rows; i++) {
                blocks[i].reset();
            }
        }
    }
}
