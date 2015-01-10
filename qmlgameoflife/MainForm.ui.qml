import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1

Rectangle {
    id: page
    width: 400
    height: 500

    function setup(cells) {
        console.log("setup");
        console.log(cells);
    }

    function setup_cell(cell) {
        console.log(cell);
    }

    Component.onCompleted: {
        game.cellsInit.connect(setup);
    }

    Connections {
        target: game
        onCellsInit: {
            console.log("onCellsInit");
        }
    }

    ColumnLayout {
        id: layout
        anchors.fill: parent

        Button {
            id: button1
            x: 0
            y: 0
            text: qsTr("Populate")
            anchors.top: parent.top
            onClicked: game.populate();
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
                        border.color: "white"
                        gradient: Gradient {
                            GradientStop {
                                position: 0
                                color: "#ffffff"
                            }

                            GradientStop {
                                position: 1
                                color: "#000000"
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true

                        }
                    }
                }
            }
        }
    }
}
