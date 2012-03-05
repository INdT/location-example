#include "landmarkmanager.h"

#include <qlandmarkmanager.h>
#include <qlandmark.h>
#include <qgeocoordinate.h>
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
    m_manager = new QLandmarkManager;
}

void LandmarkManager::saveLandmark(double latitude, double longitude, QString name)
{
    if (!m_manager)
        return;

    QGeoCoordinate coordinate;
    coordinate.setLatitude(latitude);
    coordinate.setLongitude(longitude);
    QLandmark landmark;
    landmark.setName(name);
    landmark.setCoordinate(coordinate);

    m_manager->saveLandmark(&landmark);
}

void LandmarkManager::landmarks()
{
    if (!m_manager)
        return;

    m_manager->landmarks();
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
