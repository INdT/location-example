import QtQuick 1.0

Item {
    id: toolbar
    width: parent.width
    height: 23

    signal clicked()

    MyButton {
        id: button
        defaultImage: "qrc:/btn_add.png"
        pressedImage: "qrc:/btn_add.png"
        disabledImage: "qrc:/btn_add.png"

        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter

        onClicked: toolbar.clicked()
    }
}
