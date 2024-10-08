import QtQuick 2.15
import QtQuick.Controls 2.15

TextField {
	id: userField
	echoMode: TextInput.Normal
	selectionColor: config.fgColor
	renderType: Text.NativeRendering
	font {
		family: config.Font
		pixelSize: config.FontSize
		bold: false
	}
	color: config.fgColor
	horizontalAlignment: Text.AlignHLeft
	placeholderText: "Username"
	placeholderTextColor: config.placeholderColor
	text: userModel.lastUser
	rightPadding: config.FontSize
	leftPadding: config.FontSize
	topPadding: config.FontSize / 2
	bottomPadding: config.FontSize / 2
	background: Rectangle {
		id: userFieldBackground
		color: config.bgColor
		border.color: config.fgColor
		border.width: 1
	}
	states: [
		State {
			name: "focus"
			when: userField.focus || userField.hovered
			PropertyChanges {
				target: userFieldBackground
				border.color: config.placeholderColor
			}
		}
	]
}
