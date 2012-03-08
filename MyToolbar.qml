import QtQuick 1.0

Item {
    id: toolbar
    width: parent.width
    height: 50

    signal addPosition()
    signal zoomIn()
    signal zoomOut()

    Rectangle {
        id: background
        opacity: 0.5
        color: "#343434"
        anchors.fill: parent
    }

    MyButton {
        id: addButton
        state: "enabled"
        defaultImage: "qrc:/btn_add.png"
        pressedImage: "qrc:/btn_add.png"
        disabledImage: "qrc:/btn_add.png"

        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter

        onClicked: toolbar.addPosition()
    }

    MyButton {
        id: zoomIn
        state: "enabled"
        defaultImage: "qrc:/btn_plus.png"
        pressedImage: "qrc:/btn_plus.png"
        disabledImage: "qrc:/btn_plus.png"

        anchors.right: addButton.left
        anchors.rightMargin: 20
        anchors.verticalCenter: parent.verticalCenter

        onClicked: toolbar.zoomIn();
    }

    MyButton {
        id: zoomOut
        state: "enabled"
        defaultImage: "qrc:/btn_minus.png"
        pressedImage: "qrc:/btn_minus.png"
        disabledImage: "qrc:/btn_minus.png"

        anchors.right: zoomIn.left
        anchors.rightMargin: 20
        anchors.verticalCenter: parent.verticalCenter

        onClicked: toolbar.zoomOut()
    }
}
