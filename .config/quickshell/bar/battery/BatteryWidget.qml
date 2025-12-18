import Quickshell
import Quickshell.Services.UPower
import QtQuick
import QtQuick.Controls

Item {
  id: root
  
  implicitWidth: batteryText.implicitWidth + 10
  implicitHeight: batteryText.implicitHeight

  property var battery: UPower.displayDevice

  function getBatteryIcon() {
    if (!battery) return "󰂑"

    if (battery.state === UPowerDeviceState.Charging || battery.state === UPowerDeviceState.FullyCharged) {
      return "󰂄"
    }

    var percentage = battery.percentage

    if (percentage >= 0.9) {
      return "󰁹"
    } else if (percentage >= 0.7) {
      return "󰂀"
    } else if (percentage >= 0.5) {
      return "󰁾"
    } else if (percentage >= 0.3) {
      return "󰁼"
    } else if (percentage >= 0.1) {
      return "󰁺"
    } else {
      return "󰂎"
    }
  }

  function getBatteryColor() {
    if (!battery) return "red"
    
    var isCharging = battery.state === UPowerDevice.Charging || battery.state === UPowerDevice.FullyCharged
    
    if (percentage < 20 && !isCharging) {
      return "red"
    }
    return "black"
  }

  function formatTime(seconds) {
    if (seconds <= 0) return "Unknown"

    var hours = Math.floor(seconds / 3600)
    var minutes = Math.floor((seconds % 3600) / 60)

    if (hours > 0) {
      return hours + "h " + minutes + "m"
    } else {
      return minutes + "m"
    }
  }

  function getTooltipText() {
    if (!battery) return "No battery detected"
    
    var percentage = Math.round(battery.percentage * 100)
    var tooltipText = percentage + "%"
    
    if (battery.state === UPowerDeviceState.Charging) {
      if (battery.timeToFull > 0) {
        tooltipText += " - " + formatTime(battery.timeToFull) + " until full"
      }
    } else if (battery.state === UPowerDeviceState.Discharging) {
      if (battery.timeToEmpty > 0) {
        tooltipText += " - " + formatTime(battery.timeToEmpty) + " remaining"
      }
    }
    
    return tooltipText
  }

  Text {
    id: batteryText
    anchors.centerIn: parent
    text: getBatteryIcon()
    font.family: "IntoneMono Nerd Font"
    font.pixelSize: 12
    color: getBatteryColor()
  }

  MouseArea {
    id: mouseArea
    anchors.fill: parent
    hoverEnabled: true
  }

  ToolTip {
    visible: mouseArea.containsMouse
    text: getTooltipText()
    delay: 500
  }
}
