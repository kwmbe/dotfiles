import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Controls

import "./../"

Item {
  id: root
  
  implicitWidth: 25
  implicitHeight: 25

  property bool showNotifications: false;

  Text {
    id: oskText
    anchors.centerIn: parent
    text: "󰂚"
    font.family: "IntoneMono Nerd Font"
    font.pixelSize: 12
    color: "#80000000"
  }

  MouseArea {
    id: mouseArea
    anchors.fill: parent
    hoverEnabled: true

    onClicked: (event) => {
      showNotifications = !showNotifications
    }
  }
}

