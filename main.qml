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
        Row {
            Slider {
                id: sizeSlider
                from: 10
                value: size
                to: 100
                onMoved: {
                    size = sizeSlider.value
                    kgrid.requestPaint()
                }
            }
            Slider {
                id: baseXSlider
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
                id: baseYSlider
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
                text: "Save to Image"
                onClicked: {
                    fileDialog.visible = true;
                    //kgrid.save("C:/Users/fdevigili/Desktop/a.png");
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
                        kgrid.save(fileDialog.fileUrl.replace("file:///",""));
                    }
                    onRejected: {
                        console.log("Canceled")
                    }
                }
            }
        }
        id:buttonBar
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 40
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
                x: index%tileX * size + size/2 - edge/2 +1
                y: Math.floor(index/tileX) * size + size/2 - edge/2 +1
                //color: "#000000"
                height: edge
                width: edge
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        var x = area.x+edge/2-0.5;
                        var y = area.y+edge/2-0.5;
                        if (lineFinished === 0) {
                            lineFinished = 1
                            var point = {"x":x,"y":y}
                            var line = {"s":lastPoint,"f":point};
                            lines.push(line);
                            console.log(line.s.x)
                            kgrid.requestPaint()
                        } else {
                            lastPoint = {"x":x,"y":y};
                            lineFinished = 0
                        }

                    }
                }
            }
        }


    }
}

