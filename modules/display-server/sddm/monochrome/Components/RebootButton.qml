import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
  implicitHeight: rebootButton.height
  implicitWidth: rebootButton.width
  Button {
    id: rebootButton
    height: config.FontSize * 2
    width: config.FontSize * 2
    hoverEnabled: true
    icon {
      source: Qt.resolvedUrl("../icons/reboot.svg")
      color: config.textDefault
    }
    background: Rectangle {
      id: rebootButtonBackground
      color: config.bgColor
      border.color: config.fgColor
      border.width: 1
    }
    onClicked: sddm.reboot()
  }
}
