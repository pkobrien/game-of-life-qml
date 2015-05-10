import QtQuick 2.4
import QtQuick.Controls 1.3

Grid {
    id: board

    columns: 0
    rows: 0

    function reset() {
        children = []
        var component = Qt.createComponent("Block.qml");
        for (var i = 0, len = board.columns * board.rows; i < len; i++) {
            var block = component.createObject(board);
            block.height = Qt.binding(
                        function() { return board.height / board.rows });
            block.width = Qt.binding(
                        function() { return board.width / board.columns });
        }
    }

    function setSize(columns, rows) {
        if (board.columns !== columns || board.rows !== rows) {
            board.columns = columns;
            board.rows = rows;
            reset();
        }
    }

    Connections {
        target: game
        onCellsBorn: {
            for (var i = 0, len = indices.length; i < len; i++) {
                var index = indices[i];
                var block = children[index];
                block.born(index, children);
            }
        }
        onCellsDied: {
            for (var i = 0, len = indices.length; i < len; i++) {
                children[indices[i]].died();
            }
        }
        onCellsInit: {
            for (var i = 0, len = indices.length; i < len; i++) {
                children[indices[i]].init();
            }
        }
        onReset: {
            for (var i = 0, len = columns * rows; i < len; i++) {
                children[i].reset();
            }
        }
    }
}
