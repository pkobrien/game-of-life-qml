import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1

Rectangle {
    id: board
    width: 300
    height: 300

    property int columns: 20
    property int rows: 20

    Connections {
        target: game
        onCellInit: {
            universe.children[index].color = universe.liveColor
        }
        onCellBorn: {
            universe.children[index].color = universe.liveColor
        }
        onCellDied: {
            universe.children[index].color = universe.deadColor
        }
        onReset: {
            for (var i = 0; i < universe.columns * universe.rows; i++) {
                universe.children[i].color = universe.emptyColor
            }
        }
    }

    Grid {
        id: universe
        anchors.fill: parent
        columns: board.columns
        rows: board.rows

        property color emptyColor: "#999999"
        property color deadColor: "#ffffff"
        property color liveColor: "#000000"

        Repeater {
            model: universe.columns * universe.rows

            Rectangle {
                width: board.width / universe.columns
                height: board.height / universe.rows
                border.color: "#cccccc"
                color: universe.emptyColor
            }
        }
    }
}
