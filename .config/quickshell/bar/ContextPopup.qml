import Quickshell
import QtQuick

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

      width: contentItem.implicitWidth + contentItem.anchors.margins * 2
      height: contentItem.implicitHeight + contentItem.anchors.margins * 2

      Item {
        id: contentItem
        anchors.fill: parent
        anchors.margins: 4

        implicitWidth: childrenRect.width
        implicitHeight: childrenRect.height
      }
    }
  }
}
