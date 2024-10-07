import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
  implicitHeight: powerButton.height
  implicitWidth: powerButton.width
  Button {
    id: powerButton
    height: config.FontSize * 2
    width: config.FontSize * 2
    hoverEnabled: true
    icon {
      source: Qt.resolvedUrl("../icons/power.svg")
      color: config.textDefault
    }
    background: Rectangle {
      id: powerButtonBackground
      color: config.bgColor
      border.color: config.fgColor
      border.width: 1
    }
    onClicked: sddm.powerOff()
  }
}
