import Quickshell
import QtQuick
import Quickshell.Widgets

Item {
  id: root

  implicitWidth:  16
  implicitHeight: 16

  // children go here
  default property alias content: contentItem.children
  property alias popupVisible: popup.visible

  Rectangle {
    anchors.fill: parent
    color: "transparent"

    PopupWindow {
      id: popup
      anchor.item: root
      anchor.edges: Edges.Bottom | Edges.Right
      anchor.gravity: Edges.Bottom | Edges.Left
      anchor.adjustment: PopupAdjustment.FlipY
      color: "white"

      implicitWidth: contentItem.implicitWidth + 8
      implicitHeight: contentItem.implicitHeight + 8

      WrapperItem {
        id: contentItem
        anchors.centerIn: parent
      }
    }
  }
}
