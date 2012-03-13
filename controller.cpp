#include "controller.h"
#include <QDebug>
#include <qlandmarksaverequest.h>
#include <qlandmarkmanager.h>

Controller::Controller(QObject *parent)
    : QObject(parent)
    , m_manager(0)
    , m_request(0)
    , m_save(0)
{
    init();
}

Controller::~Controller()
{
}

void Controller::init()
{
    m_manager = new QLandmarkManager(this);
    if(m_manager->error() == QLandmarkManager::InvalidManagerError) {
        qDebug() << __func__ << "Manager is invalid!!";
        return;
    }
    m_request = new QLandmarkFetchRequest(m_manager, this);
    connect(m_request, SIGNAL(stateChanged(QLandmarkAbstractRequest::State)),
            this, SLOT(onStateChanged(QLandmarkAbstractRequest::State)));
    connect(m_request, SIGNAL(resultsAvailable()), this, SLOT(onResultsAvailable()));

    m_request->setLimit(20);
    m_request->setOffset(0);
    m_request->setSorting(QLandmarkNameSort(Qt::AscendingOrder));
    /*if(!m_request->start() && m_request->error() == QLandmarkManager::InvalidManagerError) {
        qDebug() << __func__ << "Manager is invalid!";
        return;
    }*/

    m_save = new QLandmarkSaveRequest(m_manager, this);
    connect(m_save, SIGNAL(stateChanged(QLandmarkAbstractRequest::State)),
            this, SLOT(onStateChanged(QLandmarkAbstractRequest::State)));
    connect(m_save, SIGNAL(resultsAvailable()), this, SLOT(onResultsAvailable()));
    /*if (!m_save->start() && m_save->error() == QLandmarkManager::InvalidManagerError) {
        qDebug() << __func__ << "Landmark save request error: " << m_save->error();
        return;
    }*/
}

void Controller::onStateChanged(QLandmarkAbstractRequest::State state)
{
    if (state == QLandmarkAbstractRequest::FinishedState) {
        QLandmarkAbstractRequest *request = qobject_cast<QLandmarkAbstractRequest *>(sender());
        if(!request) {
            qDebug() << __func__ << "Request Manager is invalid!";
            return;
        }
        if(request->type() == QLandmarkAbstractRequest::LandmarkFetchRequest) {
            if (m_request->error() == QLandmarkManager::NoError) {
                qDebug() << __func__ << "Fetching landmarks ok";
            }

        } else if (request->type() == QLandmarkAbstractRequest::LandmarkSaveRequest) {
            if (m_save->error() == QLandmarkManager::NoError) {
                qDebug() << __func__ << "Save request sucess!!";
                //fetchLandmarks();
            } else {
                qDebug() << "Error when trying save a landmark: " << m_save->errorString();
            }
        }
    }
}

void Controller::fetchLandmarks()
{
    if (!m_request) {
        qDebug() << __func__ << "Request manager is invalid!!";
        return;
    }

    if (!m_request->isActive()) {
        m_request->start();
        QList<QLandmark> landmarks = m_request->landmarks();
        qDebug() << __func__ << "landmarks.count: " << landmarks.count();
        foreach(QLandmark landmark, landmarks) {
            qDebug() << "Landmark name: " << landmark.name() << " -- lat: " << landmark.coordinate().latitude() << " -- long: " << landmark.coordinate().longitude();
        }
    } else {
        qDebug() << __func__ << "Request manager already started.";
    }
}

void Controller::saveLandmark(qreal latitude, qreal longitude, QString name)
{
    if (!m_save) {
        qDebug() << __func__ << "Landmark save request is invalid!!";
        return;
    }

    m_save->start();
    QGeoCoordinate coordinate;
    coordinate.setLatitude(latitude);
    coordinate.setLongitude(longitude);
    QLandmark landmark;
    landmark.setName(name);
    landmark.setCoordinate(coordinate);
    landmark.setRadius(100);

    m_save->setLandmark(landmark);
}

void Controller::onResultsAvailable()
{
    if(!m_request) {
        qDebug() << __func__ << "Request manager is unavailable.";
        return;
    }

    //fetchLandmarks();
    qDebug() << __func__ << "request->error: " << m_request->errorString() << " -- " << m_request->error();
    qDebug() << __func__ << "save->error: " << m_save->errorString() << " -- " << m_save->error();
    //fetchLandmarks();
}
