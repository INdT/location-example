import QtQuick 1.0
import QtMobility.location 1.2

Item {
    id: main
    width: 480
    height: 854

    PositionSource {
        id: positionSource
        updateInterval: 1000
    }

    MainMap {
        id: mainMap
        Component.onCompleted: {
            controller.init()
            controller.cleanLandmarks()
            controller.landmarks()
        }

        onAddLandmark: {
           popupDialog.x = mouseObject.x
           popupDialog.y = mouseObject.y
           popupDialog.latitude = mouseObject.coordinate.latitude
           popupDialog.longitude = mouseObject.coordinate.longitude
           popupDialog.visible = !popupDialog.visible
        }
    }

    PopupDialog {
        id: popupDialog
        visible: false

        onPopupOk: {
            controller.saveLandmark(popupDialog.latitude, popupDialog.longitude, text)
            popupDialog.visible = !popupDialog.visible
            popupDialog.inputText = ""
        }
    }
}
