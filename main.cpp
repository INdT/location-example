#include <QApplication>
#include <QDeclarativeView>
#include <QDeclarativeContext>
#include <QDeclarativeEngine>
#include <QUrl>

#include "landmarkmanager.h"

int main (int argc, char *argv[])
{
    QApplication app(argc, argv);
    LandmarkManager manager;

    QDeclarativeView view;
    view.setSource(QUrl("main.qml"));
    view.resize(480, 854);

    view.engine()->rootContext()->setContextProperty("manager", &manager);

    view.show();

    return app.exec();
}
