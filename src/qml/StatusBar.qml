import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1

StatusBar {
    anchors.fill: parent

    RowLayout {
        anchors.fill: parent
        Label { text: "Area: %L1 cells".arg(game.width * game.height) }
        Label { text: "Generations: %L1".arg(game.generations) }
        Label { text: "Population: %L1 Living, %L2 Dead".arg(game.live_count)
                                                        .arg(game.dead_count) }
        Label { text: "Nursery: %L1 Newborn".arg(game.new_born_count) }
        Label { text: "Cemetery: %L1 Deceased".arg(game.new_dead_count) }
    }
}
