# -*- coding: utf-8 -*-

from setuptools import setup
from codecs import open
from os import path

import qmlgameoflife

here = path.abspath(path.dirname(__file__))

# Get the long description from the relevant file
# with open(path.join(here, 'DESCRIPTION.rst'), encoding='utf-8') as f:
#     long_description = f.read()

setup(
    name='QMLGameOfLife',

    version=qmlgameoflife.__version__,

    description='PyQt QML Game Of Life',
    # long_description=long_description,
    long_description='PyQt QML Game Of Life.',

    url='https://github.com/pkobrien/qml-game-of-life',

    author="Patrick K. O'Brien",
    author_email='patrick.keith.obrien@gmail.com',

    license='GPLv3',

    classifiers=[
        'Development Status :: 4 - Beta',
        'Intended Audience :: Developers',
        'License :: OSI Approved :: GNU General Public License v3 (GPLv3)',
        'Programming Language :: Python :: 2.7',
        'Programming Language :: Python :: 3',
        'Programming Language :: Python :: 3.2',
        'Programming Language :: Python :: 3.3',
        'Programming Language :: Python :: 3.4',
        'Topic :: Games/Entertainment :: Puzzle Games',
    ],

    keywords='pyqt qml conway game of life',

    extras_require={
        'test': ['pytest'],
    },
)
