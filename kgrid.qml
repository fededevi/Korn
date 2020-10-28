import QtQuick 2.15

Canvas {
    id: root
    property int wgrid: 30
    property real wBorder: 0
    property real lineWidth: 2
    property int baseX: 4
    property int baseY: 4
    property color color: "#662222AA"
    property variant lines: []
    property color lineColor: "#99000000"
    property int hRepeat: 100
    property int vRepeat: 100
    property bool repeatBox: true
    property bool showGrid: true

    onPaint: {
        var ctx = getContext("2d")
        ctx.reset();

        if (showGrid)
        drawBaseGrid();

        if (repeatBox)
        drawBaseCOntour(baseX, baseY);

        var blockSizeX = wgrid * baseX;
        var blockSizeY = wgrid * baseY;

        var blockCountX = Math.floor(root.width / blockSizeX)
        var blockCountY = Math.floor(root.height / blockSizeY)

        drawLines(0, 0);

        for(var i=0; i < blockCountX; i++){
            for(var j=0; j < blockCountY; j++){
                if (i === 0 && j === 0) continue;
                if (i >= hRepeat) continue;
                if (j >= vRepeat) continue;
                drawLines(blockSizeX*i, blockSizeY*j, true);
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

    function drawLines(xOffset,yOffset, dashed) {
        var ctx = getContext("2d")
        ctx.lineWidth = lineWidth
        ctx.strokeStyle = lineColor
        ctx.beginPath()
        if (dashed)
            ctx.setLineDash([0,1,2]);
        for(var i=0; i < root.lines.length; i++){
            var s = lines[i].s;
            var f = lines[i].f;
            ctx.moveTo(s.x*wgrid+wBorder+xOffset, s.y*wgrid+wBorder+yOffset);
            ctx.lineTo(f.x*wgrid+wBorder+xOffset, f.y*wgrid+wBorder+yOffset);
        }
        ctx.setLineDash([]);
        ctx.stroke()
    }
}



