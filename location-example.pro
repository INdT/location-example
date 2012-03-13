TEMPLATE = app
TARGET = location-example
INCLUDEPATH += .

QT += declarative
CONFIG += mobility
MOBILITY += location


HEADERS += landmarkmanager.h \
           controller.h
SOURCES += landmarkmanager.cpp \
           controller.cpp \
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
    qml/* \
    qtc_packaging/debian_harmattan/rules \
    qtc_packaging/debian_harmattan/README \
    qtc_packaging/debian_harmattan/manifest.aegis \
    qtc_packaging/debian_harmattan/copyright \
    qtc_packaging/debian_harmattan/control \
    qtc_packaging/debian_harmattan/compat \
    qtc_packaging/debian_harmattan/changelog

