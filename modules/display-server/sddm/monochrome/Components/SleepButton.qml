import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
  implicitHeight: sleepButton.height
  implicitWidth: sleepButton.width
  Button {
    id: sleepButton
    height: config.FontSize * 2
    width: config.FontSize * 2
    hoverEnabled: true
    icon {
      source: Qt.resolvedUrl("../icons/sleep.svg")
      color: config.textDefault
    }
    background: Rectangle {
      id: sleepButtonBackground
      color: config.bgColor
      border.color: config.fgColor
      border.width: 1
    }
    onClicked: sddm.suspend()
  }
}
