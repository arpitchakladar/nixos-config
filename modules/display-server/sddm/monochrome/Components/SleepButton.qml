import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
	implicitHeight: sleepButton.height
	implicitWidth: sleepButton.width
	property alias sleepButton: sleepButton
	Button {
		id: sleepButton
		height: config.FontSize * 2.5
		width: config.FontSize * 2.5
		hoverEnabled: true
		icon {
			source: Qt.resolvedUrl("../icons/sleep.svg")
			color: config.fgColor
		}
		onClicked: sddm.suspend()
		MouseArea {
			id: mouseArea
			anchors.fill: parent
			cursorShape: Qt.PointingHandCursor
			onClicked: sddm.suspend()
		}
		background: Rectangle {
			id: sleepButtonBackground
			color: config.bgColor
			border.color: config.fgColor
			border.width: 1
		}
		states: [
			State {
				name: "focus"
				when: sleepButton.focus || sleepButton.hovered
				PropertyChanges {
					target: sleepButtonBackground
					border.color: config.placeholderColor
				}
			}
		]
	}
}
