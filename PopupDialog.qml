import QtQuick 1.0
import Qt.labs.components.native 1.0

Item {
    id: popupContainer
    height: 100
    width: 200

    property real latitude: 0.0
    property real longitude: 0.0
    property alias inputText: inputName.text

    signal popupOk(string text)

    Rectangle {
        id: background
        anchors.fill: parent
        color: "white"
        border.width: 2
        border.color: "black"
    }

    Text {
        id: dscText
        text: "Write the landmark name"
        color: "#616161"
        font.pixelSize: 15
        font.bold: true
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 10
    }

    TextField {
        id: inputName
        width: parent.width
        font.pixelSize: 12
        anchors.left: parent.left
        anchors.top: dscText.bottom
        anchors.topMargin: 20

        MyButton {
            id: okButton
            state: "enabled"
            defaultImage: "qrc:/bt_ok_on.png"
            pressedImage: "qrc:/bt_ok_off.png"
            disabledImage: "qrc:/bt_ok_disabled.png"
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter

            onClicked: {
                popupContainer.popupOk(inputName.text)
            }
        }
    }
}
