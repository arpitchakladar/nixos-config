import QtQuick 2.15
import QtQuick.Controls 2.15

TextField {
  id: passwordField
  focus: true
  selectByMouse: true
  placeholderText: "Password"
  placeholderTextColor: config.placeholderColor
  echoMode: TextInput.Password
  passwordCharacter: "*"
  selectionColor: config.fgColor
  renderType: Text.NativeRendering
  font.family: config.Font
  font.pixelSize: config.FontSize
  font.bold: false
  color: config.fgColor
  horizontalAlignment: TextInput.AlignHLeft
  rightPadding: config.FontSize
  leftPadding: config.FontSize
  topPadding: config.FontSize / 2
  bottomPadding: config.FontSize / 2
  background: Rectangle {
    id: passFieldBackground
    color: config.bgColor
    border.color: config.fgColor
    border.width: 1
  }
}
