import Quickshell
import QtQuick
import Quickshell.Services.SystemTray
import QtQuick.Layouts
import "."
import "./.."

Item {
  id: root

  property bool expanded: false

  implicitWidth: 25
  implicitHeight: 25

  ContextPopup {
    id: trayPopup

    anchors.centerIn: parent
    popupVisible: root.expanded

    RowLayout {
      id: trayIcons

      spacing: 9
      layoutDirection: Qt.RightToLeft

      Repeater {
        model: SystemTray.items

        Rectangle {
          id: item

          Layout.preferredWidth: 16
          Layout.preferredHeight: 16
          color: "transparent"

          QsMenuAnchor {
            id: menuAnchor

            anchor.item: item
            anchor.gravity: Edges.Bottom | Edges.Left
            menu: modelData.menu
          }

          MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            acceptedButtons: Qt.LeftButton | Qt.RightButton

            onClicked: event => {
              switch (event.button) {
                case Qt.LeftButton:
                modelData.activate()
                root.expanded = false
                break
                case Qt.RightButton:
                menuAnchor.open()
                break
              }

              event.accepted = true
            }
          }

          Image {
            width: parent.width
            height: parent.height
            antialiasing: true

            source: modelData.icon
            sourceSize.width: width
            sourceSize.height: height

            anchors.centerIn: parent
          }
        }
      }
    }
  }

  Rectangle {
    id: chevronButton

    anchors.fill: parent
    color: mouseArea.containsMouse ? "#16000000" : "transparent"
    radius: 4

    MouseArea {
      id: mouseArea

      anchors.fill: parent
      hoverEnabled: true
      acceptedButtons: Qt.LeftButton
      cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor

      onClicked: {
        root.expanded = !root.expanded
      }
    }

    Item {
      width: 13
      height: 9
      anchors.centerIn: parent

      Rectangle {
        width: 8
        height: 2
        radius: 8
        color: "#222222"
        antialiasing: true

        x: 0
        y: 4
        rotation: root.expanded ? -35 : 35

        Behavior on rotation {
          NumberAnimation {
            duration: 160
            easing.type: Easing.InOutQuad
          }
        }

        Behavior on y {
          NumberAnimation {
            duration: 160
            easing.type: Easing.InOutQuad
          }
        }
      }

      Rectangle {
        width: 8
        height: 2
        radius: 1
        color: "#222222"
        antialiasing: true

        x: 5
        y: 4
        rotation: root.expanded ? 35 : -35

        Behavior on rotation {
          NumberAnimation {
            duration: 160
            easing.type: Easing.InOutQuad
          }
        }

        Behavior on y {
          NumberAnimation {
            duration: 160
            easing.type: Easing.InOutQuad
          }
        }
      }
    }
  }
}
