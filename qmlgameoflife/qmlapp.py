# -*- coding: utf-8 -*-
"""
Main application for PyQt QML Game Of Life.

Hosted at https://github.com/pkobrien/qml-game-of-life
"""


from PyQt5.QtCore import pyqtProperty, pyqtSignal, pyqtSlot, QObject, QTimer
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine

import gameoflife as gol
import random


def random_population(width, height):
    """Return a set containing a random population of cells."""
    area = width * height
    count = random.randint(area//20, area//2)
    return {(random.randint(0, width-1), random.randint(0, height-1))
            for n in range(count)}


class Game(QObject):
    
    cellInit = pyqtSignal(int, arguments=['index'])
    cellBorn = pyqtSignal(int, arguments=['index'])
    cellDied = pyqtSignal(int, arguments=['index'])
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
        if self._check_history():
            self.stop()
            self._stabilized = True
        for cell in self._grid.new_born:
            self.cellBorn.emit(self.index(cell))
        for cell in self._grid.new_dead:
            self.cellDied.emit(self.index(cell))
        self.cycled.emit()
        self._grid.cycle()

    def index(self, cell):
        x, y = cell
        index = x + (y * self.width)
        return index

    @pyqtSlot(int, int)
    def populate(self, width, height, population=None):
        self.stop()
        self._grid.width = width
        self._grid.height = height
        if population is None:
            population = random_population(width, height)
        self._grid.populate(population)
        self._reset()
        self.reset.emit()
        for cell in self._grid.living:
            self.cellInit.emit(self.index(cell))
        self.populated.emit()
        self.cycle()

    @pyqtSlot()
    def start(self, msec_delay=0):
        self._timer.start(msec_delay)
        self.started.emit()

    @pyqtSlot()
    def stop(self):
        self._timer.stop()
        self.stopped.emit()

    def _check_history(self):
        if len(self._history) > 5:
            self._history.pop()
        if self._grid.living in self._history:
            return True
        self._history.insert(0, self._grid.living)

    def _on_time(self):
        self.cycle()

    def _reset(self):
        self._history = []
        self._stabilized = False


def _bug_fix():
    """PyQt needs help finding plugins directory in a virtual environment."""
    paths = [os.path.abspath(os.path.join(os.path.dirname(__file__),
             os.path.pardir, 'env/Lib/site-packages/PyQt5/plugins'))]
    import PyQt5.QtCore
    PyQt5.QtCore.QCoreApplication.setLibraryPaths(paths)


if __name__ == '__main__':
    import os
    import sys
    _bug_fix()
    app = QGuiApplication(sys.argv)
    game = Game()
    engine = QQmlApplicationEngine()
    context = engine.rootContext()
    context.setContextProperty('game', game)
    qml_filename = os.path.join(os.path.dirname(__file__), 'main.qml')
    engine.load(qml_filename)
    sys.exit(app.exec_())
