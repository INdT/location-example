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

contains(MEEGO_EDITION, harmattan) {
    DEFINES += MEEGO_EDITION_HARMATTAN

    target.path = /opt/location-example/bin

    landmarks.path = /opt/location-example
    landmarks.files = mylandmarks.lmx

    INSTALLS += target landmarks
}

OTHER_FILES += \
    qml/*
