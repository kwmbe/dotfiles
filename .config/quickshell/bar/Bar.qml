import Quickshell         // for PanelWindow
import Quickshell.Io      // for Process
import QtQuick            // for Text

import "./clock/"

Scope {
  Variants {
    model: Quickshell.screens;

    PanelWindow {
      required property var modelData
      screen: modelData

      color: "#bbffffff"

      anchors {
        top: true
        left: true
        right: true
      }
    
      implicitHeight: 25
    
      ClockWidget {
        anchors.centerIn: parent
      }
    }
  }
}
