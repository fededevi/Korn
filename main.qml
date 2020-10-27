import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Dialogs 1.0

Window {
    id: win
    visible: true
    title: "s"
    width: 800
    height: 1000

    property int baseX: 4
    property int baseY: 4

    property int size: 40
    property variant lines: []

    property int tileX: width / size
    property int tileY: height / size

    property variant lastPoint;
    property int lineFinished: 1;

    Rectangle {
        id:buttonBar
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 40
        Row {
            spacing: 10
            anchors.fill: parent
            anchors.verticalCenter: parent.verticalCenter
            Slider {
                anchors.verticalCenter: parent.verticalCenter
                id: sizeSlider
                width: 150
                from: 10
                value: size
                to: 100
                onMoved: {
                    size = sizeSlider.value
                    kgrid.requestPaint()
                }
            }
            Slider {
                anchors.verticalCenter: parent.verticalCenter
                id: baseXSlider
                width: 150
                stepSize: 1
                from: 1
                value: baseX
                to: 10
                onMoved: {
                    baseX = baseXSlider.value
                    kgrid.requestPaint()
                }
            }
            Slider {
                anchors.verticalCenter: parent.verticalCenter
                id: baseYSlider
                width: 150
                stepSize: 1
                from: 1
                value: baseY
                to: 10
                onMoved: {
                    baseY = baseYSlider.value
                    kgrid.requestPaint()
                }
            }
            Button {
                anchors.verticalCenter: parent.verticalCenter
                width: 100
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
                anchors.verticalCenter: parent.verticalCenter
                width: 50
                height: 35
                text: "Clear"
                onClicked: {
                    lines = []
                    kgrid.requestPaint()
                }
            }
            CheckBox {
                height: 40
                text: "Hor."
                checked: true
                onCheckedChanged: {
                    kgrid.hRepeat = checked
                    kgrid.requestPaint()
                }
            }
            CheckBox {
                height: 40
                text: "Ver."
                checked: true
                onCheckedChanged: {
                    kgrid.vRepeat = checked
                    kgrid.requestPaint()
                }
            }
        }
    }
    Item {

        anchors.top: buttonBar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        Kgrid {
            id: kgrid
            anchors.fill: parent
            wgrid: size
            wBorder: size / 2 + 0.5
            baseX: win.baseX
            baseY: win.baseY
            lines: win.lines
        }


        Repeater {
            model: tileX * tileY
            Item {
                id: area
                property int edge: size
                property int xCount: index%tileX
                property int yCount: Math.floor(index/tileX)
                x: xCount* size + size/2 - edge/2 +1
                y: yCount* size + size/2 - edge/2 +1
                height: edge
                width: edge
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (lineFinished === 0) {
                            lineFinished = 1
                            var point = {"x":xCount,"y":yCount}
                            var line = {"s":lastPoint,"f":point};
                            lines.push(line);
                            console.log(line.s.x)
                            kgrid.requestPaint()
                        } else {
                            lastPoint = {"x":xCount,"y":yCount};
                            lineFinished = 0
                        }

                    }
                }
            }
        }


    }
}

