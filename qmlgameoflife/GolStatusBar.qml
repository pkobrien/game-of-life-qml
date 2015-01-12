import QtQuick 2.4

GolStatusBarForm {
    area: qsTr("Area: %L1 cells").arg(game.width * game.height)
    gens: qsTr("Generations: %L1").arg(game.generations)
    pops: qsTr("Population: %L1 Living, %L2 Dead").arg(game.live_count).arg(game.dead_count)
    born: qsTr("Nursery: %L1 Newborn").arg(game.new_born_count)
    died: qsTr("Cemetery: %L1 Deceased").arg(game.new_dead_count)
}
