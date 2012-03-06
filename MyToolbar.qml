import QtQuick 1.0

Item {
    id: toolbar
    width: parent.width
    height: 23

    signal clicked()

    MyButton {
        id: button
        defaultImage: "btn_add.png"
        pressedImage: "btn_add.png"
        disabledImage: "btn_add.png"

        anchors.right: parent.right
        anchors.verticalAlignment: parent.verticalCenter

        onClicked: toolbar.clicked()
    }
}
