import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Controls

import "./../"

Item {
  id: root
  
  implicitWidth: 25
  implicitHeight: 25

  property bool rotated: false;

  function getRotationIcon() {
    if (rotated) return ""
    return ""
  }

  function getTooltipText() {
    return "Rotate " + (rotated ? "back" : "screen")
  }

  Process {
    id: getSreenRotation
    command: ["sh", "-c", "swaymsg -t get_outputs | jq -r '.[] | select(.name == \"eDP-1\") | .transform'"]
    running: true
    stdout: StdioCollector {
      onStreamFinished: {
        var rotation = this.text.trim()
        rotated = rotation != "normal"
      }
    }
  }

  Process {
    id: rotateProcess
    command: ["sh", "-c", Qt.resolvedUrl("./rotate.sh").toString().replace("file://", "")]
    onExited: (code) => {
      console.log(code)
      if (code === 0) rotated = !rotated
    }
  }

  Text {
    id: rotationText
    anchors.centerIn: parent
    text: getRotationIcon()
    font.family: "IntoneMono Nerd Font"
    font.pixelSize: 12
    color: "#80000000"
  }

  MouseArea {
    id: mouseArea
    anchors.fill: parent
    hoverEnabled: true

    onClicked: rotateProcess.running = true
  }

  ContextPopup {
    popupVisible: mouseArea.containsMouse

    Text {
      font.family: "Nunito"
      font.weight: Font.DemiBold
      anchors.centerIn: parent
      text: getTooltipText()
      color: "black"
    }
  }
}
