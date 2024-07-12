import QtQuick 2.3


Rectangle {
    property real pitchAngle:       0
    property real rollAngle:        0
    property real size:             100
    property real _reticleHeight:   1
    property real _reticleSpacing:  size * 0.15
    property real _reticleSlot:     _reticleSpacing + _reticleHeight
    property real _longDash:        size * 0.35
    property real _shortDash:       size * 0.25
    property real _fontSize:        10 * 0.75

    height: size
    width:  size
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter:   parent.verticalCenter
    clip: true
    Item {
        height: parent.height
        width:  parent.width
        Column{
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter:   parent.verticalCenter
            spacing: _reticleSpacing
            Repeater {
                model: 36
                Rectangle {
                    property int _pitch: -(modelData * 5 - 90)
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: (_pitch % 10) === 0 ? _longDash : _shortDash
                    height: _reticleHeight
                    color: "white"
                    antialiasing: true
                    smooth: true
                    LGCLabel {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.horizontalCenterOffset: -(_longDash)
                        anchors.verticalCenter: parent.verticalCenter
                        smooth: true
                        font.family: "Consolas"
                        font.pointSize: _fontSize
                        text: _pitch
                        color: "white"
                        visible: (_pitch != 0) && ((_pitch % 10) === 0)
                    }
                    LGCLabel {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.horizontalCenterOffset: (_longDash)
                        anchors.verticalCenter: parent.verticalCenter
                        smooth: true
                        font.family: "Consolas"
                        font.pointSize: _fontSize
                        text: _pitch
                        color: "white"
                        visible: (_pitch != 0) && ((_pitch % 10) === 0)
                    }
                }
            }
        }
        transform: [ Translate {
                y: (pitchAngle * _reticleSlot / 5) - (_reticleSlot / 2)
                }]
    }
    transform: [
        Rotation {
            origin.x: width  / 2
            origin.y: height / 2
            angle:    -rollAngle
            }
    ]
}