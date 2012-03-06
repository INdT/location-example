import QtQuick 1.0
import QtMobility.location 1.2

Item {
    id: mapContainer

    width: parent.width
    height: parent.height

    signal clicked(variant mouse)

    Coordinate {
        id: initialCoordinate
        latitude: -3.0607
        longitude: -60.0130
    }

    LandmarkModel {
        id: allLandmarksModel
        autoUpdate: true
        sortBy: LandmarkModel.NameSort
        sortOrder: LandmarkModel.AscendingOrder
        limit: 100
    }

    Map {
        id: map
        plugin: Plugin { name: "nokia" }
        zoomLevel: 10
        center: initialCoordinate

        anchors.fill: parent
        size.width: parent.width
        size.height: parent.height

        MapObjectView {
            id: allLandmarks
            model: allLandmarksModel
            delegate: Component {
                id: landDelegate
                MapGroup {
                    id: groupDelegate
                    MapText {
                        id: text
                        text: landmark.name
                        font.pixelSize: 12
                        font.bold: true
                        font.capitalization: Font.Capitalize
                        color: "#616161"
                        coordinate: landmark.coordinate
                        offset.y: -10
                    }
                    MapImage {
                        id: image
                        source: "landmarkstar.png"
                        coordinate: landmark.coordinate
                    }
                }
            }
        }

        MapMouseArea {
            id: mapMouseArea

            property int lastX: -1
            property int lastY: -1

            onClicked: {
                mapContainer.clicked(mouse)
            }
            onPressed: {
                allLandmarksModel.autoUpdate = false
                lastX = mouse.x
                lastY = mouse.y
            }
            onReleased: {
                allLandmarksModel.autoUpdate = true
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
