import QtQuick 1.0
import QtMobility.location 1.2

Item {
    id: main
    width: 480
    height: 854

    PositionSource {
        id: positionSource
        updateInterval: 1000
        active: true
    }

    MainMap {
        id: mainMap

        onClicked: {
            if (mouse.button == Qt.LeftButton || mouse.button == Qt.RightButton && popupDialog.visible) {
                popupDialog.visible = false
                popupDialog.inputText = ""
            } else if (mouse.button == Qt.MiddleButton) {
                popupDialog.x = mouse.x
                popupDialog.y = mouse.y
                popupDialog.latitude = mouse.coordinate.latitude
                popupDialog.longitude = mouse.coordinate.longitude
                popupDialog.visible = !popupDialog.visible
            }
        }

        MapCircle {
            id: currentPosition
            radius: 500
            color: "red"
            center: positionSource.position.coordinate
        }

        Component.onCompleted: {
            controller.init()
            controller.landmarks()
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

    MyToolbar {
        id: myToolbar

        anchors.bottom: parent.bottom
        onClicked: {
            popupDialog.center = mainMap.toScreenPostion(positionSource.position.coordinate)
            popupDialog.latitude = positionSource.position.coordinate.latitude
            popupDialog.longitude = positionSource.position.coordinate.longitude
            popupDialog.visible = !popupDialog.visible
        }
    }
}
