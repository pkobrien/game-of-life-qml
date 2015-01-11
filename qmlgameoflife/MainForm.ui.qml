import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1

Rectangle {
    id: page
    width: 400
    height: 500

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
    }

    ColumnLayout {
        id: mainLayout
        anchors.fill: parent

        RowLayout {
        id: buttonLayout

            Button {
                id: populateButton
                text: qsTr("Populate")
                onClicked: game.populate()
            }

            Button {
                id: startButton
                text: qsTr("Start")
                onClicked: game.start()
            }
        }

        Rectangle {
            id: board
            width: 400
            height: 400

            Grid {
                id: universe
                anchors.fill: parent
                rows: 40
                columns: 40

                Repeater {
                    model: universe.rows * universe.columns

                    Rectangle {
                        id: block
                        width: board.width / universe.rows
                        height: board.height / universe.columns
                        border.color: "lightGray"
                        color: "gray"
                    }
                }
            }
        }
    }
}
