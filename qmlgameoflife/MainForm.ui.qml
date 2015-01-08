import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1

Item {
    width: 400
    height: 400

    Grid {
        id: universe
        x: 0
        y: 0
        width: 400
        height: 400
        rows: 40
        columns: 40

        Repeater {
            model: parent.rows * parent.columns

            Rectangle {
                id: cell
                width: 10
                height: 10
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
