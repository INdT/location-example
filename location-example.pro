TEMPLATE = app
TARGET = location-example
INCLUDEPATH += .

QT += declarative
CONFIG += mobility
MOBILITY += location


HEADERS += landmarkmanager.h
SOURCES += landmarkmanager.cpp \
           main.cpp

RESOURCES += qml.qrc

contains(MEEGO_EDITION,harmattan) {
    target.path = /opt/location-example/bin
    INSTALLS += target
}
