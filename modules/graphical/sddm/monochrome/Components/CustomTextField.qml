import QtQuick 2.15
import QtQuick.Controls 2.15

TextField {
	selectionColor: config.fgColor
	renderType: Text.NativeRendering
	height: config.FontSize * 2.5
	font {
		family: config.Font
		pixelSize: config.FontSize
		bold: false
	}
	color: config.fgColor
	horizontalAlignment: Text.AlignHLeft
	placeholderTextColor: config.placeholderColor
	rightPadding: config.FontSize
	leftPadding: config.FontSize
	topPadding: config.FontSize / 2
	bottomPadding: config.FontSize / 2
	background: Rectangle {
		id: customTextFieldBackground
		color: config.bgColor
		border.color: config.fgColor
		border.width: 1
	}
	states: [
		State {
			name: "focus"
			when: focus
			PropertyChanges {
				target: customTextFieldBackground
				border.color: config.placeholderColor
			}
		}
	]
}
