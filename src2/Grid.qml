import QtQuick 2.4
import "." as App

Rectangle {
    id: grid

    property int columns: 150
    property int rows: 75

    property var cellComp: Qt.createComponent("Cell.qml")
    property var cells: []  // sparse array.
    property int generations: 0
    property alias interval: timer.interval
    property var living: []

    color: "Silver"

    focus: true

    Keys.onDeletePressed: repopulate();
    Keys.onRightPressed: { if (!timer.running) cycle(); }
    Keys.onSpacePressed: timer.running = !timer.running;

    function birth(index) {
        cells[index] = cellComp.createObject(grid,
                                             {"grid": grid, "index": index});
    }

    function cycle() {
        if (!living.length) {
            return;
        }
        generations += 1;
        var cell;
        var count;
        var i, j, len;
        var index;
        var nearby;
        var neighbors;
        var nextgen = [];
        var recalc = [];
        for (i = 0, len = living.length; i < len; i++) {
            index = living[i];
            nearby = [index].concat(cells[index].neighbors);
            for (j = 0; j < 9; j++) {
                if (recalc.indexOf(nearby[j]) === -1) {
                    recalc.push(nearby[j]);
                }
            }
        }
        for (i = 0, len = recalc.length; i < len; i++) {
            count = 0;
            index = recalc[i];
            cell = cells[index];
            if (cell !== undefined) {
                neighbors = cell.neighbors;
            } else {
                neighbors = getNeighbors(index);
            }
            for (j = 0; j < 8; j++) {
                if (living.indexOf(neighbors[j]) !== -1) {
                    count++;
                }
            }
            if (count === 3 || (count === 2 && living.indexOf(index) !== -1)) {
                if (nextgen.indexOf(index) === -1) {
                    nextgen.push(index);
                    if (living.indexOf(index) === -1) {
                        birth(index);
                    }
                }
            }
        }
        for (i = 0, len = living.length; i < len; i++) {
            index = living[i];
            if (nextgen.indexOf(index) === -1) {
                death(index);
            }
        }
        living = nextgen;
    }

    function death(index) {
        if (cells[index] === undefined) {
            // This only happens when we use: delete cells[index];
            print(index, living.indexOf(index), living.length);
            return;
        }
        cells[index].destroy();
//        delete cells[index];  // Causes QML to act flaky on large grids.
        cells[index] = undefined;
    }

    function getNeighbors(index) {
        var x = index % grid.columns;
        var y = Math.floor(index / grid.columns);
        var neighbors = [];
        var i, j;
        for (i = -1; i < 2; i++) {
            for (j = -1; j < 2; j++) {
                if (i === 0 && j === 0) {
                    continue;
                }
                neighbors.push(toroidX(x + i) + toroidY(y + j) * grid.columns);
            }
        }
        return neighbors;
    }

    function populate() {
        living = randomPopulation();
        living.forEach(birth);
    }

    function randomInt(min, max) {
        return Math.floor(Math.random() * (max - min)) + min;
    }

    function randomPopulation() {
        var area = grid.columns * grid.rows;
        var count = randomInt(Math.floor(area / 20), Math.floor(area / 6));
        var index;
        var population = [];
        for (var i = 0; i < count; i++) {
            index = randomInt(0, area - 1);
            if (population.indexOf(index) === -1) {
                population.push(index);
            }
        }
        return population;
    }

    function repopulate() {
        reset();
        populate();
    }

    function reset() {
        timer.stop();
        cells = [];
        children = [];
        generations = 0;
    }

    function toroidN(constraint) {
        return function(n) {
            if (n >= 0) {
                if (n < constraint) {
                    return n;
                }
                return n - constraint;
            }
            return n + constraint;
        };
    }

    property var toroidX: toroidN(grid.columns)
    property var toroidY: toroidN(grid.rows)

    Timer {
        id: timer
        interval: 1
        repeat: true
        running: false
        onTriggered: cycle()
    }
}
