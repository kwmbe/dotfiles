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

      margins {
        left: 4
        right: 4
        top: 4
      }
    
      implicitHeight: 25
    
      ClockWidget {
        anchors.centerIn: parent
      }
    }
  }
}
