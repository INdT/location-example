#ifndef LANDMARKMANAGER_H
#define LANDMARKMANAGER_H

#include <QObject>
#include <qlandmark.h>
#include <qlandmarkmanager.h>

QTM_USE_NAMESPACE

class LandmarkManager : public QObject
{
    Q_OBJECT
public:
    LandmarkManager(QObject *parent = 0);
    ~LandmarkManager();

    void init();
    void saveLandmark(QLandmark *landmark);

private:
    QLandmarkManager *m_manager;
};

#endif
