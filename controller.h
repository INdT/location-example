#ifndef CONTROLLER_H
#define CONTROLLER_H

#include <QObject>
#include <qlandmarkmanager.h>
#include <qlandmarkfetchrequest.h>
#include <qlandmarksaverequest.h>

QTM_USE_NAMESPACE

class Controller : public QObject
{
    Q_OBJECT
public:
    Controller(QObject *parent = 0);
    ~Controller();
    void init();

public slots:
    void saveLandmark(qreal latitude, qreal longitude, QString name);
    void fetchLandmarks();

private slots:
    void onStateChanged(QLandmarkAbstractRequest::State state);

private:
    QLandmarkManager *m_manager;
    QLandmarkFetchRequest *m_request;
    QLandmarkSaveRequest *m_save;
};
#endif
