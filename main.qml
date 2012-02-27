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

    Map {
        id: map
        plugin: Plugin { name: "nokia" }
        zoomLevel: 10
        center: Coordinate {
            latitude: -3.0607
            longitude: -60.0130
        }

        size.width: parent.width
        size.height: parent.height

        MapMouseArea {
            property int lastX: -1
            property int lastY: -1

            onPressed: {
                lastX = mouse.x
                lastY = mouse.y
            }
            onReleased: {
                lastX = -1
                lastY = -1
            }
            onPositionChanged: {
                if (mouse.button == Qt.LeftButton) {
                    if (lastX != -1 && lastY != -1) {
                        var dx = mouse.x - lastX
                        var dy = mouse.y - lastY

                        map.pan(-dx, -dy)
                    }
                    lastX = mouse.x
                    lastY = mouse.y
                }
            }
            onDoubleClicked: {
                map.center = mouse.coordinate
                lastX = -1
                lastY = -1
                if (mouse.button == Qt.LeftButton)
                    map.zoomLevel += 1
                if (mouse.button == Qt.RightButton)
                    map.zoomLevel -= 1
            }
        }
        Behavior on zoomLevel {
            NumberAnimation { duration: 500; easing.type: Easing.OutQuad }
        }
    }
}
