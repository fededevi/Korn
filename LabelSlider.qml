import QtQuick 2.15
import QtQuick.Controls 2.15

Slider {
    id: slider
    y:10

    property string text: ""

    width: 150
    height: 60

    Text {
        x : 10
        anchors.top: slider.top
        text: qsTr(slider.text)
    }
}
