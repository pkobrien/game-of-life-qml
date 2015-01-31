import QtQuick 2.4

GolBoardForm {
    id: board

    function setSize(columns, rows) {
        var reset = false;
        if (board.columns !== columns || board.rows !== rows)
            reset = true;
        board.columns = columns;
        board.rows = rows;
        if (reset) {
            for (var i = board.blocks.length - 1; i >= 0; i--) {
                board.blocks[i].destroy();
            }
            board.grid.children = []
            var component = Qt.createComponent("GolBlock.qml");
            for (var i = 0; i < board.columns * board.rows; i++) {
                var block = component.createObject(board.grid);
                block.height = Qt.binding(function() { return board.height / board.rows });
                block.width = Qt.binding(function() { return board.width / board.columns });
            }
        }
    }

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
