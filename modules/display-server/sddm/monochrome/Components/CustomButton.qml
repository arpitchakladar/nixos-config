import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
	implicitHeight: button.height
	implicitWidth: button.width
	property alias button: button
	property var iconSource
	property var additionalFocusState: false
	signal buttonClicked()
	signal additionalFocusState()

	Button {
		id: button
		height: config.FontSize * 2.5
		width: config.FontSize * 2.5
		hoverEnabled: true
		icon {
			source: Qt.resolvedUrl(iconSource)
			color: config.fgColor
		}
		onClicked: buttonClicked()
		MouseArea {
			id: mouseArea
			anchors.fill: parent
			cursorShape: Qt.PointingHandCursor
			onClicked: buttonClicked()
		}
		background: Rectangle {
			id: buttonBackground
			color: config.bgColor
			border.color: config.fgColor
			border.width: 1
		}
		states: [
			State {
				name: "focus"
				when: button.focus || button.hovered || additionalFocusState
				PropertyChanges {
					target: buttonBackground
					border.color: config.placeholderColor
				}
			}
		]
	}
}
