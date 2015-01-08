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


from PyQt5.QtCore import QUrl
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtQuick import QQuickView

#import gameoflife as gol
#import qmlgameoflife as qmlgol
import random


def _bug_fix():
    """PyQt needs help finding plugins directory in a virtual environment."""
    paths = [os.path.abspath(os.path.join(os.path.dirname(__file__), '..', 
             'env/Lib/site-packages/PyQt5/plugins'))]
    import PyQt5.QtCore
    PyQt5.QtCore.QCoreApplication.setLibraryPaths(paths)


if __name__ == '__main__':
    import os
    import sys
    _bug_fix()
    app = QGuiApplication(sys.argv)
    qml_filename = os.path.join(os.path.dirname(__file__), 'main.qml')
    engine = QQmlApplicationEngine(qml_filename)
    sys.exit(app.exec_())
