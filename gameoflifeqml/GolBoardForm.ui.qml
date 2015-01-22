import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1

Rectangle {
    id: board
    width: 300
    height: 300

    property alias blocks: grid.children

    property int columns: 20
    property int rows: 20

    Grid {
        id: grid
        anchors.fill: parent
        columns: board.columns
        rows: board.rows

        Repeater {
            model: board.columns * board.rows

            GolBlock {
                width: board.width / board.columns
                height: board.height / board.rows
            }
        }
    }
}
