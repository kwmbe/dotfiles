import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Controls

import "./../"

Item {
  id: root
  
  implicitWidth: 25
  implicitHeight: 25

  property PwNode sink: Pipewire.defaultAudioSink
  
  PwObjectTracker {
    objects: [ sink ]
  }

  function getVolumeIcon() {
    if (!Pipewire.ready) return "󰝟"
    if (sink.audio.muted) return "󰖁"

    var vol = sink.audio.volume

    if (vol >= 0.67) {
      return "󰕾"
    } else if (vol >= 0.33) {
      return "󰖀"
    } else {
      return "󰕿"
    }
  }

  function getTooltipText() {
    return (sink.description ? sink.description + " · " : "") + (sink.audio.muted ? "Muted" : Math.round(sink.audio.volume * 100) + "%")
  }

  Text {
    id: volumeText
    anchors.centerIn: parent
    text: getVolumeIcon()
    font.family: "IntoneMono Nerd Font"
    font.pixelSize: 12
    color: "black"
  }

  MouseArea {
    id: mouseArea
    anchors.fill: parent
    hoverEnabled: true

    onClicked: (event) => {
      sink.audio.muted = !sink.audio.muted
    }
  }

  ContextPopup {
    popupVisible: mouseArea.containsMouse

    Text {
      font.family: "Nunito"
      font.weight: Font.DemiBold
      anchors.centerIn: parent
      text: getTooltipText()
      color: "black"
    }
  }
}
