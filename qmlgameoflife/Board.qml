import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1

Rectangle {
    id: board
    width: 300
    height: 300

    property alias blocks: universe.children

    property int columns: 20
    property int rows: 20

    property color emptyColor: "#999999"
    property color deadColor: "#ffffff"
    property color liveColor: "#000000"

    Grid {
        id: universe
        anchors.fill: parent
        columns: board.columns
        rows: board.rows

        Repeater {
            model: universe.columns * universe.rows

            Rectangle {
                width: board.width / universe.columns
                height: board.height / universe.rows
                border.color: "#cccccc"
                color: board.emptyColor
            }
        }
    }
}
