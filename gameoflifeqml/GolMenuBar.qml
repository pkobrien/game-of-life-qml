import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1

MenuBar {
    Menu {
        title: qsTr("&File")
        MenuItem {
            text: qsTr("Acorn")
            onTriggered: game.sample_acorn(board.columns, board.rows);
        }
        MenuItem {
            text: qsTr("E&xit")
            onTriggered: Qt.quit();
        }
    }
}
