import QtQuick 2.4
import QtQuick.Window 2.2
import "." as App

Window {
    title: "Conway's Game Of Life  [Generations: %1]".arg(grid.generations)

    width: 1200
    height: 800

    visible: true

    App.Grid {
        id: grid

        anchors.fill: parent

        Keys.onEscapePressed: Qt.quit();
    }
}
