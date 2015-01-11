# -*- coding: utf-8 -*-
"""
Main application for PyQt QML Game Of Life.

Hosted at https://github.com/pkobrien/qml-game-of-life
"""

#from PyQt5.QtCore import QTimer
#
#from PyQt5.QtCore import pyqtProperty, QRectF, Qt, QUrl
#from PyQt5.QtGui import QBrush, QColor, QGuiApplication, QPainter, QPen
#from PyQt5.QtQml import qmlRegisterType, QQmlComponent, QQmlEngine
#from PyQt5.QtQuick import QQuickPaintedItem, QQuickView


from PyQt5.QtCore import (pyqtProperty, pyqtSignal, pyqtSlot,
                          QObject, QTimer, QUrl)
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtQuick import QQuickView

import gameoflife as gol
#import qmlgameoflife as qmlgol
import random


def sample_population():
    """Return a sample population of cells."""
    glideright = {(0, 0), (1, 0), (1, 2), (2, 0), (2, 1)}
    return (gol.offset(gol.GLIDER, 0, 0) | 
            gol.offset(gol.BEACON, 2, 10) | 
            gol.offset(gol.BLINKER, 10, 2) |
            gol.offset(gol.GLIDER, 20, 7) |
            gol.offset(glideright, 37, 0))


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

    @property
    def dead_count(self):
        return self._grid.dead_count

    @property
    def generations(self):
        return self._grid.generations

    @property
    def height(self):
        return self._grid.height

    @property
    def live_count(self):
        return self._grid.live_count

    @property
    def new_born_count(self):
        return self._grid.new_born_count

    @property
    def new_dead_count(self):
        return self._grid.new_dead_count

    @property
    def stabilized(self):
        return self._stabilized

    @property
    def width(self):
        return self._grid.width

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

    @pyqtSlot()
    def populate(self, width=0, height=0, population=None):
        self.stop()
        self._grid.width = width
        self._grid.height = height
        if population is None:
            self._grid.width = 40
            self._grid.height = 40
            population = sample_population()
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

#    qml_filename = os.path.join(os.path.dirname(__file__), 'main.qml')
#    engine = QQmlApplicationEngine(qml_filename)

    view = QQuickView()
    view.setResizeMode(QQuickView.SizeRootObjectToView)
    game = Game()
    context = view.rootContext()
    context.setContextProperty('game', game)
    qml_filename = os.path.join(os.path.dirname(__file__), 'MainForm.ui.qml')
    view.setSource(QUrl(qml_filename))
    view.show()

    sys.exit(app.exec_())
