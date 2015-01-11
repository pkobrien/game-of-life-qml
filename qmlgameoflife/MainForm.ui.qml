import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1

Rectangle {
    id: page
    width: 600
    height: 640

    Connections {
        target: game
        onCellInit: {
            universe.children[index].color = "#000000"
        }
        onCellBorn: {
            universe.children[index].color = "#000000"
        }
        onCellDied: {
            universe.children[index].color = "#ffffff"
        }
        onReset: {
            for (var i = 0; i < universe.rows * universe.columns; i++) {
                universe.children[i].color = "#999999"
            }
        }
    }

    ColumnLayout {
        id: mainLayout
        anchors.fill: parent

        RowLayout {
        id: buttonLayout

            Button {
                id: populateButton
                text: qsTr("Populate")
                onClicked: game.populate(universe.columns, universe.rows)
            }

            Button {
                id: startButton
                text: qsTr("Start")
                onClicked: game.start()
            }
        }

        Rectangle {
            id: board
            width: 600
            height: 600

            Grid {
                id: universe
                anchors.fill: parent
                columns: 100
                rows: 100

                Repeater {
                    model: universe.columns * universe.rows

                    Rectangle {
                        id: block
                        width: board.width / universe.columns
                        height: board.height / universe.rows
                        border.color: "lightGray"
                        color: "#999999"
                    }
                }
            }
        }
    }
}
