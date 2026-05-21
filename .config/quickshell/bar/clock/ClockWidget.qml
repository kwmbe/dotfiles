import QtQuick

import "."

Text {
  color: "black"
  font.family: "Nunito"
  font.weight: Font.DemiBold
  text: Weather.weather ? Time.time + "  ·   " + Weather.weather : Time.time
}
