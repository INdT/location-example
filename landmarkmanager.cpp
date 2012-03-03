#include "landmarkmanager.h"

#include <qlandmarkmanager.h>
#include <qlandmark.h>
#include <QObject>
#include <QString>
#include <QStringList>
#include <QDebug>
#include <QList>

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
    m_manager = new QLandmarkManager("com.nokia.qt.landmarks.engines.sqlite");
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

void LandmarkManager::landmarks()
{
    if (!m_manager)
        return;
    QList<QLandmark> landmarks = m_manager->landmarks();
    foreach (QLandmark landmark, landmarks) {
        qDebug() << __func__ << "landmark name: " << landmark.name() << " -- location: " << landmark.coordinate().latitude() << " , " << landmark.coordinate().longitude();
    }
}

bool LandmarkManager::cleanLandmarks()
{
    bool result = false;

    if (!m_manager)
        return result;

    QList<QLandmark> lms = m_manager->landmarks();
    if (lms.count() > 0)
        result = m_manager->removeLandmarks(lms);
    return result;
}
