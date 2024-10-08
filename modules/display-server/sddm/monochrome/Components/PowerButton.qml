import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
	implicitHeight: powerButton.height
	implicitWidth: powerButton.width
	property alias powerButton: powerButton
	Button {
		id: powerButton
		height: config.FontSize * 2.5
		width: config.FontSize * 2.5
		hoverEnabled: true
		icon {
			source: Qt.resolvedUrl("../icons/power.svg")
			color: config.fgColor
		}
		onClicked: sddm.powerOff()
		MouseArea {
			id: mouseArea
			anchors.fill: parent
			cursorShape: Qt.PointingHandCursor
			onClicked: sddm.powerOff()
		}
		background: Rectangle {
			id: powerButtonBackground
			color: config.bgColor
			border.color: config.fgColor
			border.width: 1
		}
		states: [
			State {
				name: "focus"
				when: powerButton.focus || powerButton.hovered
				PropertyChanges {
					target: powerButtonBackground
					border.color: config.placeholderColor
				}
			}
		]
	}
}
