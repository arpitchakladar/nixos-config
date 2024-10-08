import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
	implicitHeight: rebootButton.height
	implicitWidth: rebootButton.width
	property alias rebootButton: rebootButton
	Button {
		id: rebootButton
		height: config.FontSize * 2.5
		width: config.FontSize * 2.5
		hoverEnabled: true
		icon {
			source: Qt.resolvedUrl("../icons/reboot.svg")
			color: config.fgColor
		}
		onClicked: sddm.reboot()
		MouseArea {
			id: mouseArea
			anchors.fill: parent
			cursorShape: Qt.PointingHandCursor
			onClicked: sddm.reboot()
		}
		background: Rectangle {
			id: rebootButtonBackground
			color: config.bgColor
			border.color: config.fgColor
			border.width: 1
		}
		states: [
			State {
				name: "focus"
				when: rebootButton.focus || rebootButton.hovered
				PropertyChanges {
					target: rebootButtonBackground
					border.color: config.placeholderColor
				}
			}
		]
	}
}
