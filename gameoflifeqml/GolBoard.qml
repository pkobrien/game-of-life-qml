import QtQuick 2.4

GolBoardForm {
    id: board

    function setSize(columns, rows) {
        var reset = false;
        if (board.columns !== columns || board.rows !== rows)
            reset = true;
        board.columns = columns;
        board.rows = rows;
        if (reset)
            resetGrid();
    }

    function resetGrid() {
        for (var i = board.blocks.length - 1; i >= 0; i--) {
            board.blocks[i].destroy();
        }
        board.grid.children = []
        blockAnimationX.duration = (Math.random() * 200) + 2000;
        blockAnimationY.duration = (Math.random() * 200) + 2000;
        blockAnimationX.easing.overshoot = (Math.random() * 20) + 10;
        blockAnimationY.easing.overshoot = (Math.random() * 20) + 10;
        blockAnimationX.from = Math.random() * board.width;
        blockAnimationY.from = Math.random() * board.height;
        var component = Qt.createComponent("GolBlock.qml");
        for (var i = 0; i < board.columns * board.rows; i++) {
            var block = component.createObject(board.grid);
            block.height = Qt.binding(function() { return board.height / board.rows });
            block.width = Qt.binding(function() { return board.width / board.columns });
        }
    }

    grid.add: Transition {
        NumberAnimation {
            id: blockAnimationX
            properties: "x"
            easing.type: Easing.OutInBack
        }
        NumberAnimation {
            id: blockAnimationY
            properties: "y"
            easing.type: Easing.InOutBack
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
