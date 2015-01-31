import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1

Rectangle {
    id: board
    width: 30
    height: 30

    property int columns: 0
    property int rows: 0

    property alias blocks: grid.children
    property alias grid: grid

    Grid {
        id: grid
        anchors.fill: parent
        columns: board.columns
        rows: board.rows
    }
}
