import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1

StatusBar {
    id: status
    width: 700

    property string area: qsTr("Area: %L1 cells")
    property string gens: qsTr("Generations: %L1")
    property string pops: qsTr("Population: %L1 Living, %L2 Dead")
    property string born: qsTr("Nursery: %L1 Newborn")
    property string died: qsTr("Cemetery: %L1 Deceased")

    RowLayout {
        anchors.fill: parent
        Label { id: area; text: status.area }
        Label { id: gens; text: status.gens }
        Label { id: pops; text: status.pops }
        Label { id: born; text: status.born }
        Label { id: died; text: status.died }
    }
}
