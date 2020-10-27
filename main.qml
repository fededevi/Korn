import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

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
                from: 40
                value: 10
                to: 100
                onMoved: size = sizeSlider.value
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
            anchors.fill: parent
            id: kgrid
            wgrid: size
            wBorder: size / 2 + 0.5
            baseX: 5
            baseY: 5
            lines: win.lines
        }


        Repeater {
            model: tileX * tileY
            Item {
                id: area
                property int edge: 21
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

