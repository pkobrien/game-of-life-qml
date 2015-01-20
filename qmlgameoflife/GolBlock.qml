import QtQuick 2.4

GolBlockForm {
    id: block
    border.color: Qt.lighter(color)

    signal born(int index, var blocks)
    signal died
    signal init
    signal reset

    onBorn: {
        state = "NEWBORN";
        // New born cells always have 3 previously live neighbors.
        var liveNeighbors = game.previously_live_neighbors(index);
        block.color.r = blocks[liveNeighbors[0]].color.r;
        block.color.g = blocks[liveNeighbors[1]].color.g;
        block.color.b = blocks[liveNeighbors[2]].color.b;
    }

    onDied: state = "DEAD";

    onInit: {
        state = "LIVE";
        color.r = Math.random();
        color.g = Math.random();
        color.b = Math.random();
    }

    onReset: state = "EMPTY";
}
