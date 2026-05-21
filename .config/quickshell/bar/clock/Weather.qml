pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
  id: root

  readonly property string weather: _weather
  property string _weather: ""

  Process {
    id: fetch
    command: ["curl", "-sf", "wttr.in/?format=%t|%C"]
    stdout: StdioCollector {
      onStreamFinished: {
        var parts = text.trim().split("|")
        var temp  = parts[0].replace(/^\+/, "")
        var icon  = root.conditionIcon(parts[1] || "")
        root._weather = icon + "  " + temp
      }
    }
  }

  function isNight() {
    var h = new Date().getHours()
    return h >= 21 || h < 7
  }

  function conditionIcon(condition) {
    var c = condition.toLowerCase()

    if (c.includes("thunder"))    return "󰖓"
    if (c.includes("blizzard"))   return "󰼶"
    if (c.includes("snow"))       return "󰖘"
    if (c.includes("sleet"))      return "󰙿"
    if (c.includes("heavy rain")
     || c.includes("torrential")) return "󰖖"
    if (c.includes("rain")
     || c.includes("drizzle")
     || c.includes("shower"))     return "󰖗"
    if (c.includes("fog")
     || c.includes("mist"))       return "󰖑"
    if (c.includes("overcast"))   return "󰖐"
    if (c.includes("cloudy")
     || c.includes("partly"))     return isNight ? "󰼱" : "󰖕"
    if (c.includes("clear")
     || c.includes("sunny"))      return isNight ? "󰖔" : "󰖙"

    return "󰖙"
  }

  Timer {
    interval: 900000
    running: true
    repeat: true
    triggeredOnStart: true
    onTriggered: fetch.running = true
  }
}

