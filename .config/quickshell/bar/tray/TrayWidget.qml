import Quickshell
import QtQuick
import QtQuick.Controls
import Quickshell.Services.SystemTray;
import QtQuick.Layouts

import "."
import "./.."

Item {
  id: root

  implicitWidth:  rowLayout.implicitWidth
  implicitHeight: rowLayout.implicitHeight

  RowLayout {
    id: rowLayout
    spacing: 9 // 9 + 16 = 25
    layoutDirection: Qt.RightToLeft

    anchors {
      right: parent.right
      rightMargin: 4
      verticalCenter: parent.verticalCenter
    }

    Repeater {
      model: SystemTray.items;

      Rectangle {
        id: item

	  		Layout.preferredWidth:  16
	  		Layout.preferredHeight: 16

        color: "transparent"

        QsMenuAnchor {
          id: menuAnchor
          anchor.item: item
          anchor.gravity: Edges.Bottom | Edges.Left
          menu: modelData.menu
        }

        MouseArea {
          id: mouseArea

          hoverEnabled: true
          anchors.fill: parent
          acceptedButtons: Qt.LeftButton | Qt.RightButton
          onClicked: (event) => {
            console.log(event)
            switch (event.button) {
              case Qt.LeftButton:
                  modelData.activate();
                  break;
              case Qt.RightButton:
                  menuAnchor.open()
                  break;
            }
            event.accepted = true;
          }
        }

        Image {
	  	  	 width:             parent.width
	  	  	 height:            parent.height
	  	  	 antialiasing:      true
	  	  	 source:            modelData.icon
	  	  	 sourceSize.width:  width
	  	  	 sourceSize.height: height
           anchors.centerIn:  parent
	  	  }
      }
    }
  }
}
