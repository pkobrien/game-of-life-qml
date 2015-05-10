import QtQuick 2.4

Rectangle {
    id: block

    border.color: Qt.lighter(color)

    signal born(int index, var blocks)
    signal died()
    signal init()
    signal reset()

    onBorn: {
        // New born cells always have 3 previously live neighbors.
        var liveNeighbors = game.previously_live_neighbors(index);
        color.r = blocks[liveNeighbors[0]].color.r;
        color.g = blocks[liveNeighbors[1]].color.g;
        color.b = blocks[liveNeighbors[2]].color.b;
    }

    onDied: color = "#ffffff";

    onInit: color = Qt.rgba(Math.random(), Math.random(), Math.random(), 1.0);

    onReset: color = "#eeeeee";
}
