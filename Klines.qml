import QtQuick 2.15

Canvas {
    id: root

    property variant lines: []
    property color color: "#000000"
    property int baseX: 4
    property int baseY: 4

    onPaint: {
        //console.log(lines)
        var ctx = getContext("2d")
        ctx.lineWidth = 2
        ctx.strokeStyle = color
        ctx.beginPath()
        for(var i=0; i < root.lines.length; i++){
            var s = lines[i].s;
            var f = lines[i].f;
            ctx.moveTo(s.x, s.y);
            ctx.lineTo(f.x, f.y);
        }
        ctx.stroke()
    }


}



