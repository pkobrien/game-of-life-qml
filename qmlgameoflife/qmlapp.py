# -*- coding: utf-8 -*-
"""
Main application for PyQt QML Game Of Life.

Hosted at https://github.com/pkobrien/qml-game-of-life
"""

from PyQt5.QtCore import Qt, QTimer
from PyQt5.QtGui import QBrush, QKeySequence, QPen
from PyQt5.QtWidgets import (QAction, QApplication, QGraphicsRectItem,
                             QGraphicsScene, QGraphicsView,
                             QHBoxLayout,
                             QLabel, QMainWindow, QMessageBox,
                             QPushButton,
                             QVBoxLayout, QWidget)

import gameoflife as gol
import qmlgameoflife as qmlgol
import random


def sample_population1():
    """Return a sample population of cells."""
    return (gol.offset(gol.GLIDER, 0, 0) | 
            gol.offset(gol.BEACON, 2, 10) | 
            gol.offset(gol.BLINKER, 10, 2))


def sample_population2():
    """Return a sample population of cells."""
    glideright = {(0, 0), (1, 0), (1, 2), (2, 0), (2, 1)}
    return (gol.offset(gol.GLIDER, 0, 0) | 
            gol.offset(gol.BEACON, 2, 10) | 
            gol.offset(gol.BLINKER, 10, 2) |
            gol.offset(gol.GLIDER, 20, 7) |
            gol.offset(glideright, 37, 0))


def random_population1(width, height):
    """Return a random population of cells."""
    area = width * height
    count = random.randint(area/4, area/2)
    return {(random.randint(0, width-1), random.randint(0, height-1))
            for n in range(count)}


class MainWindow(QMainWindow):

    def __init__(self):
        super(MainWindow, self).__init__()
        self.setWindowTitle('PyQt QML Game Of Life')
        self.resize(700, 700)


def _bug_fix():
    paths = ['C:/Users/Patrick/code/qml-game-of-life/env/Lib/site-packages/PyQt5/plugins']
    import PyQt5.QtCore
    PyQt5.QtCore.QCoreApplication.setLibraryPaths(paths)


if __name__ == '__main__':
    _bug_fix()
    import sys
    app = QApplication(sys.argv)
    win = MainWindow()
    win.show()
    sys.exit(app.exec_())
