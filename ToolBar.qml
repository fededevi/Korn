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

        Rectangle {
            width: 150
            height: 150
            border.width: 1
            anchors.horizontalCenter: parent.horizontalCenter
            Column {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                Text {
                    x : 10
                    text: qsTr("Horizontal Repeat:")
                }
                RadioButton {
                    width: 150
                    text: qsTr("No H. Repeat")
                    onCheckedChanged: {
                        if (checked) {
                            kgrid.hRepeat = 1;
                            kgrid.requestPaint()
                        }
                    }
                }
                RadioButton {
                    width: 150
                    text: qsTr("One H. Repeat")
                    onCheckedChanged: {
                        if (checked) {
                            kgrid.hRepeat = 2;
                            kgrid.requestPaint()
                        }
                    }
                }
                RadioButton {
                    width: 150
                    checked: true
                    text: qsTr("Full H. Repeat")
                    onCheckedChanged:  {
                        if (checked) {
                            kgrid.hRepeat = 100;
                            kgrid.requestPaint()
                        }
                    }
                }
            }
        }

        Rectangle {
            width: 150
            height: 150
            border.width: 1
            anchors.horizontalCenter: parent.horizontalCenter
            Column {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                Text {
                    x : 10
                    text: qsTr("Vertical Repeat:")
                }
                RadioButton {
                    width: 150
                    text: qsTr("No V. Repeat")
                    onCheckedChanged: {
                        if (checked) {
                            kgrid.vRepeat = 1;
                            kgrid.requestPaint()
                        }
                    }
                }
                RadioButton {
                    width: 150
                    text: qsTr("One V. Repeat")
                    onCheckedChanged: {
                        if (checked) {
                            kgrid.vRepeat = 2;
                            kgrid.requestPaint()
                        }
                    }
                }
                RadioButton {
                    width: 150
                    checked: true
                    text: qsTr("Full V. Repeat")
                    onCheckedChanged:  {
                        if (checked) {
                            kgrid.vRepeat = 100;
                            kgrid.requestPaint()
                        }
                    }
                }
            }
        }
    }
}

