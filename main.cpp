#include <QApplication>
#include <QDeclarativeView>
#include <QDeclarativeContext>
#include <QDeclarativeEngine>
#include <QUrl>

#include "landmarkmanager.h"

int main (int argc, char *argv[])
{
    QApplication app(argc, argv);
    LandmarkManager *manager = new LandmarkManager;;

    QDeclarativeView view;

    view.rootContext()->setContextProperty("controller", manager);
    view.setSource(QUrl("qrc:/main.qml"));
    view.resize(480, 854);
    view.setResizeMode(QDeclarativeView::SizeRootObjectToView);


    view.show();

    return app.exec();
}
