import Quickshell         // for PanelWindow
import Quickshell.Io      // for Process
import QtQuick            // for Text
import QtQuick.Layouts

import Quickshell.Services.SystemTray

import "./clock/"
import "./battery/"
import "./tray/"
import "./workspace/"
import "./wifi/"
import "./volume/"

import "."

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

      RowLayout {
        layoutDirection: Qt.RightToLeft
        spacing: 10

        anchors {
          left: parent.left
          leftMargin: 10
          verticalCenter: parent.verticalCenter
        }

        WorkspaceWidget { }
      }

      RowLayout {
        layoutDirection: Qt.LeftToRight
        spacing: 10

        anchors {
          right: parent.right
          rightMargin: 10
          verticalCenter: parent.verticalCenter
        }

        // ContextPopup {
        //   popupVisible: true
        //   Text { text: "test" }
        // }

        TrayWidget { }

        VolumeWidget { }

        WifiWidget { }

        BatteryWidget { }
      }
    
      ClockWidget {
        anchors.centerIn: parent
      }
    }
  }
}
