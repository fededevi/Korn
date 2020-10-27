import QtQuick 2.15

Canvas {
    id: root
    property int wgrid: 40
    property real wBorder: 0
    property int baseX: 4
    property int baseY: 4
    property color color: "#662222AA"
    property variant lines: []
    property color lineColor: "#EE000000"

    onPaint: {
        var ctx = getContext("2d")
        ctx.reset();
        drawBaseGrid();
        drawBaseCOntour(baseX, baseY);

        var blockSizeX = wgrid * baseX;
        var blockSizeY = wgrid * baseY;

        for(var i=0; i < 10; i++){
            for(var j=0; j < 10; j++){
                drawLines(blockSizeX*i, blockSizeY*j);
            }
        }

    }

    function drawBaseCOntour(x, y) {
        var ctx = getContext("2d")
        ctx.lineWidth = 3
        ctx.strokeStyle = color
        ctx.beginPath()
        ctx.moveTo(0+wBorder, 0+wBorder);
        ctx.lineTo(wgrid*x+wBorder, 0+wBorder);
        ctx.lineTo(wgrid*x+wBorder, wgrid*y+wBorder);
        ctx.lineTo(0+wBorder, wgrid*y+wBorder);
        ctx.closePath()
        ctx.stroke()
    }

    function drawBaseGrid() {
        var ctx = getContext("2d")
        ctx.lineWidth = 1
        ctx.strokeStyle = color
        ctx.beginPath()
        var nrows = height/wgrid;
        for(var i=0; i < nrows+1; i++){
            ctx.moveTo(0, wgrid*i+wBorder);
            ctx.lineTo(width, wgrid*i+wBorder);
        }
        var ncols = width/wgrid
        for(var j=0; j < ncols+1; j++){
            ctx.moveTo(wgrid*j+wBorder, 0);
            ctx.lineTo(wgrid*j+wBorder, height);
        }
        ctx.closePath()
        ctx.stroke()
    }

    function drawLines(xOffset,yOffset) {
        var ctx = getContext("2d")
        ctx.lineWidth = 3
        ctx.strokeStyle = lineColor
        ctx.beginPath()
        for(var i=0; i < root.lines.length; i++){
            var s = lines[i].s;
            var f = lines[i].f;
            ctx.moveTo(s.x+xOffset, s.y+yOffset);
            ctx.lineTo(f.x+xOffset, f.y+yOffset);
        }
        ctx.stroke()
    }
}



