import QtQuick 2.4

Rectangle {
    id: cell

    property var grid
    property int index
    property var neighbors: grid.getNeighbors(index)

    width: grid.width / grid.columns
    height: grid.height / grid.rows

    x: (index % grid.columns) * width
    y: Math.floor(index / grid.columns) * height

    color: "Black"
}
