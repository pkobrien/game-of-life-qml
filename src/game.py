# -*- coding: utf-8 -*-
"""
Main Game class for PyQt QML Game Of Life.

Hosted at https://github.com/pkobrien/qml-game-of-life
"""

from PyQt5.QtCore import (pyqtProperty, pyqtSignal, pyqtSlot, QObject, 
                          QTimer, QVariant)

import gameoflife as gol
import random


def random_population(width, height):
    """Return a set containing a random population of cells."""
    area = width * height
    count = random.randint(area//20, area//2)
    return {(random.randint(0, width-1), random.randint(0, height-1))
            for n in range(count)}


class Game(QObject):
    """Proxy class that handles all interactions with the gol.Grid.
    
    This class does not have any UI elements. Instead it emits signals."""
    
    cellsBorn = pyqtSignal(QVariant, arguments=['indices'])
    cellsDied = pyqtSignal(QVariant, arguments=['indices'])
    cellsInit = pyqtSignal(QVariant, arguments=['indices'])
    cycled = pyqtSignal()
    populated = pyqtSignal()
    reset = pyqtSignal()
    started = pyqtSignal()
    stopped = pyqtSignal()

    def __init__(self):
        super(Game, self).__init__()
        self._grid = gol.Grid()
        self._history = []
        self._stabilized = False
        self._timer = QTimer()
        self._timer.timeout.connect(self._on_time)

    @pyqtProperty(int, notify=cycled)
    def dead_count(self):
        return self._grid.dead_count

    @pyqtProperty(int, notify=cycled)
    def generations(self):
        return self._grid.generations

    @pyqtProperty(int, notify=populated)
    def height(self):
        return self._grid.height

    @pyqtProperty(int, notify=cycled)
    def live_count(self):
        return self._grid.live_count

    @pyqtProperty(int, notify=cycled)
    def new_born_count(self):
        return self._grid.new_born_count

    @pyqtProperty(int, notify=cycled)
    def new_dead_count(self):
        return self._grid.new_dead_count

    @pyqtProperty(bool, notify=cycled)
    def stabilized(self):
        return self._stabilized

    @pyqtProperty(int, notify=populated)
    def width(self):
        return self._grid.width

    @pyqtSlot()
    def cycle(self):
        """Update grid with the next generation of living cells."""
        if self._check_history():
            self.stop()
            self._stabilized = True
        self.cellsBorn.emit(list(map(self.index, self._grid.new_born)))
        self.cellsDied.emit(list(map(self.index, self._grid.new_dead)))
        self.cycled.emit()
        self._grid.cycle()

    def index(self, cell):
        """Return the index value for a given (x, y) cell."""
        x, y = cell
        index = x + (y * self.width)
        return index

    @pyqtSlot(int, result=QVariant)
    def previously_live_neighbors(self, index):
        """Return list of neighbors of cell at index previously alive."""
        y, x = divmod(index, self.width)
        cell = (x, y)
        prev = self._history[1]
        live = [neigh for neigh in self._grid.neighbors(cell) if neigh in prev]
        return list(map(self.index, live))

    @pyqtSlot(int, int)
    def populate(self, width, height, population=None):
        """Seed grid with cells contained in the population set."""
        self.stop()
        self._grid.width = width
        self._grid.height = height
        if population is None:
            population = random_population(width, height)
        self._grid.populate(population)
        self._reset()
        self.reset.emit()
        self.cellsInit.emit(list(map(self.index, self._grid.living)))
        self.populated.emit()
        self.cycle()

    @pyqtSlot(int, int)
    def sample_acorn(self, width, height):
        self.populate(width, height, 
                      gol.offset(gol.ACORN, width//2, height//2))

    @pyqtSlot()
    def start(self, msec_delay=0):
        """Start cycling the grid using a timer with a delay of msec_delay."""
        self._timer.start(msec_delay)
        self.started.emit()

    @pyqtSlot()
    def stop(self):
        """Stop cycling the grid."""
        self._timer.stop()
        self.stopped.emit()

    def _check_history(self):
        """Break simple loops by checking the history."""
        check = False
        if len(self._history) > 5:
            self._history.pop()
        if self._grid.living in self._history:
            check = True
        self._history.insert(0, self._grid.living)
        return check

    def _on_time(self):
        """Cycle the grid."""
        self.cycle()

    def _reset(self):
        """Reset to a clean state."""
        self._history = []
        self._stabilized = False
