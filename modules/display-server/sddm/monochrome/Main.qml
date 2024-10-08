import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import SddmComponents 2.0
import "Components"

Item {
	id: root
	height: Screen.height
	width: Screen.width
	Rectangle {
		id: background
		anchors.fill: parent
		height: parent.height
		width: parent.width
		z: 0
		color: config.bgColor
	}
	Item {
		id: mainPanel
		z: 3
		anchors {
			fill: parent
			leftMargin: Screen.width * 0.02
			rightMargin: Screen.width * 0.02
			bottomMargin: Screen.height * 0.02
		}
		Clock {
			id: time
			color: config.fgColor
			timeFont.family: config.Font
			dateFont.family: config.Font

			anchors {
				topMargin: parent.height * 0.12
				top: parent.top
				horizontalCenter: parent.horizontalCenter
			}
		}
		LoginPanel {
			id: loginPanel
			anchors.fill: parent
		}
	}
}
