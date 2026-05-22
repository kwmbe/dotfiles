import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Controls

import "./../"

Item {
  id: root
  
  implicitWidth: 25
  implicitHeight: 25

  property bool oskEnabled: false;

  function getOskIcon() {
    if (oskEnabled) return "󰌐"
    return "󰌌"
  }

  function getTooltipText() {
    return (oskEnabled ? "Disable" : "Enable") + " on screen keyboard"
  }

  Process {
    id: killOsk
    command: ["pkill", "wvkbd-azerty"]
    onExited: (code) => {
      if (code !== 0) launchOsk.running = true
      else oskEnabled = false
    }
  }
  
  Process {
    id: launchOsk
    command: ["/home/salt/Projects/wvkbd/wvkbd-azerty"]
    onRunningChanged: if (running) oskEnabled = true
  }

  Text {
    id: oskText
    anchors.centerIn: parent
    text: getOskIcon()
    font.family: "IntoneMono Nerd Font"
    font.pixelSize: 12
    color: "#80000000"
  }

  MouseArea {
    id: mouseArea
    anchors.fill: parent
    hoverEnabled: true

    onClicked: killOsk.running = true
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
