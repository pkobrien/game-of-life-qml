import QtQuick 2.4

GolBoardForm {
    id: board

    Connections {
        target: game
        onCellsBorn: {
            for (var i = 0; i < indices.length; i++) {
                var index = indices[i];
                var block = blocks[index]
                // New born cells always have 3 previously live neighbors.
                var liveNeighbors = game.previously_live_neighbors(index);
                block.color.r = blocks[liveNeighbors[0]].color.r;
                block.color.g = blocks[liveNeighbors[1]].color.g;
                block.color.b = blocks[liveNeighbors[2]].color.b;
            }
        }
        onCellsDied: {
            for (var i = 0; i < indices.length; i++) {
                blocks[indices[i]].color = deadColor;
            }
        }
        onCellsInit: {
            for (var i = 0; i < indices.length; i++) {
                blocks[indices[i]].color.r = Math.random();
                blocks[indices[i]].color.g = Math.random();
                blocks[indices[i]].color.b = Math.random();
            }
        }
        onReset: {
            for (var i = 0; i < columns * rows; i++) {
                blocks[i].color = emptyColor;
            }
        }
    }
}
