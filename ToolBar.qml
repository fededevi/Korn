import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Dialogs 1.0

Rectangle {
    id:buttonBar


    width: 200
    Column {
        spacing: 10
        anchors.fill: parent
        anchors.horizontalCenter: parent.horizontalCenter

        LabelSlider {
            id: sizeSlider
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Sqares Size"
            stepSize: 2
            from: 10
            value: size
            to: 100
            onMoved: {
                size = sizeSlider.value
                kgrid.requestPaint()
            }
        }

        LabelSlider {
            id: baseXSlider
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Horizontal Repeat Size"
            stepSize: 1
            from: 1
            value: baseX
            to: 10
            onMoved: {
                baseX = baseXSlider.value
                kgrid.requestPaint()
            }
        }

        LabelSlider {
            id: baseYSlider
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Vertical Repeat Size"
            stepSize: 1
            from: 1
            value: baseY
            to: 10
            onMoved: {
                baseY = baseYSlider.value
                kgrid.requestPaint()
            }
        }

        LabelSlider {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Line Size"
            stepSize: 0.25
            from: 0.5
            value: kgrid.lineWidth
            to: 5
            onMoved: {
                kgrid.lineWidth = value
                kgrid.requestPaint()
            }
        }

        Button {
            anchors.horizontalCenter: parent.horizontalCenter
            width: 150
            height: 35
            text: "Save to Image"
            onClicked: {
                fileDialog.visible = true;
            }
            FileDialog {
                id: fileDialog
                visible: false
                selectExisting : false
                defaultSuffix :".png"
                title: "Please choose how to save the image"
                folder: shortcuts.home

                onAccepted: {
                    console.log("You chose: " + fileDialog.fileUrl)
                    var str = "" + fileDialog.fileUrl;
                    str = str.substring(8)
                    kgrid.save(str);
                }
                onRejected: {}
            }
        }
        Button {
            anchors.horizontalCenter: parent.horizontalCenter
            width: 150
            height: 35
            text: "Clear"
            onClicked: {
                lines = []
                kgrid.requestPaint()
            }
        }
        Button {
            anchors.horizontalCenter: parent.horizontalCenter
            width: 150
            height: 35
            text: "Undo"
            onClicked: {
                lines.pop();
                kgrid.requestPaint()
            }
        }
        CheckBox {
            anchors.horizontalCenter: parent.horizontalCenter
            height: 40
            width: 150
            text: "Horizontal Repeat"
            checked: true
            onCheckedChanged: {
                kgrid.hRepeat = checked
                kgrid.requestPaint()
            }
        }
        CheckBox {
            anchors.horizontalCenter: parent.horizontalCenter
            height: 40
            width: 150
            text: "Vertical Repeat"
            checked: true
            onCheckedChanged: {
                kgrid.vRepeat = checked
                kgrid.requestPaint()
            }
        }
    }
}

