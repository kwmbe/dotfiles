import Quickshell
import QtQuick
import QtQuick.Controls
import Quickshell.I3
import QtQuick.Layouts

import "."

Item {
  id: root

  implicitWidth:  rowLayout.implicitWidth
  implicitHeight: rowLayout.implicitHeight

  RowLayout {
    id: rowLayout
    spacing: 0
    anchors.fill: parent

    Repeater {
      model: I3.workspaces

      Rectangle {
        id: item

	  		Layout.preferredWidth:  26
	  		Layout.preferredHeight: 16

        color: "transparent"

				TapHandler {
					onTapped: {
						modelData.activate()
					}
				}

        Text { 
          text: modelData.name 
          font.family: "Nunito"
          font.weight: modelData.focused ? Font.Bold : Font.DemiBold
          color: modelData.urgent ? "red" : "black"
          anchors.centerIn: parent
        }
      }
    }
  }
}
