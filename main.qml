import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Dialogs 1.0

Window {
    id: win
    visible: true
    title: "Korn - Federico Devigili - https://github.com/fededevi - federicodevigili@lgmail.com"
    width:  1040
    height: 891

    property int baseX: 4
    property int baseY: 4

    property int size: 40
    property variant lines: []

    property int tileX: width / size
    property int tileY: height / size

    property variant lastPoint;
    property int lineFinished: 1;

    Item {
        id: buttonBar
        width: 200
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        ToolBar {
            anchors.topMargin: 20
            anchors.fill: parent
        }
    }

    Item {
        anchors.left: buttonBar.right
        anchors.top: parent.top
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

