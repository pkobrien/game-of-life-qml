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


from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine

import gameoflife as gol
import qmlgameoflife as qmlgol
import random


def _bug_fix():
    paths = ['C:/Users/Patrick/code/qml-game-of-life/env/Lib/site-packages/PyQt5/plugins']
    import PyQt5.QtCore
    PyQt5.QtCore.QCoreApplication.setLibraryPaths(paths)


if __name__ == '__main__':
    _bug_fix()
    import os
    import sys
    app = QGuiApplication(sys.argv)
    qml_filename = os.path.join(os.path.dirname(__file__), 'main.qml')
    engine = QQmlApplicationEngine(qml_filename)
#    view = QQuickView()
#    view.setResizeMode(QQuickView.SizeRootObjectToView)
#    view.setSource(QUrl.fromLocalFile(
#        os.path.join(os.path.dirname(__file__), 'app.qml')))
#    view.show()
    sys.exit(app.exec_())
