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
    property bool snapToGrid: true;

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


        MouseArea {

            function getMouseIndex(mouse) {
                var xIndex = (mouse.x - size*0.5) / size
                var yIndex = (mouse.y - size*0.5) / size
                if (snapToGrid) {
                    xIndex = Math.round(xIndex)
                    yIndex = Math.round(yIndex)
                }
                return{"x":xIndex,"y":yIndex}
            }

            anchors.fill: parent
            property bool draggingLine: false

            onPressed: {
                draggingLine = true;

                lastPoint = getMouseIndex(mouse);
                console.log(lastPoint.x,lastPoint.y)
            }
            onReleased: {
                if (!draggingLine) return;
                draggingLine = false;
                var line = {"s":lastPoint,"f":getMouseIndex(mouse)};
                lines.push(line);
                console.log(line.s.x,line.s.y,line.f.x,line.f.y)
                kgrid.requestPaint()
            }



        }


    }
}

