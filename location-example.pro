TEMPLATE = app
TARGET = location-example
INCLUDEPATH += .

QT += declarative
CONFIG += mobility
MOBILITY += location


HEADERS += landmarkmanager.h
SOURCES += landmarkmanager.cpp \
           main.cpp

