#include "landmarkmanager.h"

#include <qlandmarkmanager.h>
#include <qlandmark.h>
#include <QObject>
#include <QString>
#include <QStringList>
#include <QDebug>

QTM_USE_NAMESPACE

LandmarkManager::LandmarkManager (QObject *parent)
    : QObject(parent)
    , m_manager(0)
{
}

LandmarkManager::~LandmarkManager()
{
}

void LandmarkManager::init()
{
    m_manager = new QLandmarkManager("com.nokia.qt.landmarks.engine.sqlite");
    QStringList managers = QLandmarkManager::availableManagers();
    foreach (QString manager, managers) {
        qDebug() << __func__ << " -- manager: " << manager;
    }
}

void LandmarkManager::saveLandmark(QLandmark *landmark)
{
    if (!m_manager)
        return;
    Q_UNUSED(landmark);
}
