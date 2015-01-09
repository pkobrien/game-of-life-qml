import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1

Rectangle {
    id: page
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
                width: page.width / universe.rows
                height: page.height / universe.columns
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
    Component.onCompleted: mediator.setup(universe)
}
