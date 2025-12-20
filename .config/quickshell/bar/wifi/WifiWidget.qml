import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Controls

import "./../"

Item {
  id: root
  
  implicitWidth: wifiText.implicitWidth + 10
  implicitHeight: wifiText.implicitHeight

  property int strength: 0
  property string network: ""

  property bool viewNetworks: false

  function getWifiIcon() {
    if (!network) return "󰤭"

    if (strength >= 90) {
      return "󰤨"
    } else if (strength >= 70) {
      return "󰤥"
    } else if (strength >= 40) {
      return "󰤢"
    } else if (strength >= 10) {
      return "󰤟"
    } else {
      return "󰤯"
    }
  }

  function getTooltipText() {
    return root.network + " · " + root.strength + "%"
  }

  Process {
    id: setStrength
    // use mmcli or qmicli for modem
    command: ["sh", "-c", "nmcli -f IN-USE,SIGNAL device wifi|grep '*'|grep -o '[0-9]*'"]
    running: true
    stdout: StdioCollector {
      onStreamFinished: root.strength = this.text.trim()
    }
  }

  Process {
    id: setNetwork
    command: ["sh", "-c", "nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2"]
    running: true
    stdout: StdioCollector {
      onStreamFinished: root.network = this.text.trim()
    }
  }

  Timer {
    interval: 60000
    running: true
    repeat: true

    onTriggered: {
      setStrength.running = true
      setNetwork.running = true
    }
  }

  Text {
    id: wifiText
    anchors.centerIn: parent
    text: getWifiIcon()
    font.family: "IntoneMono Nerd Font"
    font.pixelSize: 12
    color: "black"
  }

  MouseArea {
    id: mouseArea
    anchors.fill: parent
    hoverEnabled: true

    onClicked: (event) => {
      root.viewNetworks = !root.viewNetworks
    }
  }

  ContextPopup {
    popupVisible: mouseArea.containsMouse || root.viewNetworks

    Text {
      font.family: "Nunito"
      font.weight: Font.DemiBold
      anchors.centerIn: parent
      text: getTooltipText()
      color: "black"
    }
  }
}
