import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQml.Models 2.15

Item {
	property var session: sessionList.currentIndex
	property alias sessionButton: sessionButton
	property alias sessionList: sessionList
	property var userField
	implicitHeight: sessionButton.height
	implicitWidth: sessionButton.width

	DelegateModel {
		id: sessionWrapper
		model: sessionModel
		delegate: ItemDelegate {
			id: sessionEntry
			height: config.FontSize * 2.5
			width: parent.width
			highlighted: sessionList.currentIndex == index

			contentItem: Text {
				renderType: Text.NativeRendering
				font.family: config.Font
				font.pixelSize: config.FontSize
				horizontalAlignment: Text.AlignHCenter
				verticalAlignment: Text.AlignVCenter
				color: config.fgColor
				text: name
			}

			background: Rectangle {
				id: sessionEntryBackground
				color: config.bgColor
				border.color: config.bgColor
				border.width: 1
			}

			states: [
				State {
					name: "hovered"
					when: sessionEntry.hovered || sessionEntry.down || sessionEntry.highlighted
					PropertyChanges {
						target: sessionEntryBackground
						border.color: config.fgColor
						border.width: 1
					}
				}
			]

			MouseArea {
				anchors.fill: parent
				cursorShape: Qt.PointingHandCursor
				onClicked: {
					sessionList.currentIndex = index
					sessionPopup.close()
				}
			}
		}
	}

	CustomButton {
		id: sessionButton
		iconSource: "../icons/settings.svg"
		additionalFocusState: sessionPopup.visible
		onButtonClicked: sessionPopup.visible ? sessionPopup.close() : sessionPopup.open()
	}

	Popup {
		id: sessionPopup
		width: inputWidth
		x: -(inputWidth)
		y: -(contentHeight + padding * 2)
		padding: config.FontSize / 2

		background: Rectangle {
			color: config.bgColor
			border.color: config.fgColor
			border.width: 1
		}

		contentItem: ListView {
			id: sessionList
			implicitHeight: contentHeight
			spacing: config.FontSize / 2
			model: sessionWrapper
			currentIndex: sessionModel.lastIndex
			clip: true
			focus: true // Ensure ListView is focusable
			Keys.onPressed: {
				switch (event.key) {
				case Qt.Key_Up:
					sessionList.currentIndex = Math.max(sessionList.currentIndex - 1, 0);
					break
				case Qt.Key_Down:
					sessionList.currentIndex = Math.min(sessionList.currentIndex + 1, sessionList.count - 1);
					break
				case Qt.Key_Return:
				case Qt.Key_Enter:
					sessionPopup.close(); // Confirm selection
					userField.forceActiveFocus();
					break
				}
			}

			// Set focus to ListView when the popup opens
			onVisibleChanged: {
				if (sessionPopup.visible) {
					sessionList.forceActiveFocus();
				} else if (userField) {
					userField.forceActiveFocus();
				}
			}

			Component.onCompleted: {
				sessionList.forceActiveFocus(); // Ensure ListView gains focus when initialized
			}
		}
	}
}
