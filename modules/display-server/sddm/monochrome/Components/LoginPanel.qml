import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.2

Item {
	property var user: userField.text
	property var password: passwordField.text
	property var session: sessionPanel.session
	property var inputHeight: config.FontSize * 6
	property var inputWidth: config.FontSize * 16

	Rectangle {
		id: loginBackground
		anchors {
			verticalCenter: parent.verticalCenter
			horizontalCenter: parent.horizontalCenter
		}
		height: inputHeight + config.FontSize * 4
		width: inputWidth + config.FontSize * 4
		visible: true
		color: config.bgColor
		border.color: config.fgColor
		border.width: 1
	}

	// Left Panel (Power, Reboot, Sleep)
	Column {
		spacing: config.FontSize / 2
		anchors {
			bottom: parent.bottom
			left: parent.left
		}

		PowerButton {
			id: powerButton
			Keys.onPressed: {
				switch (event.key)  {
				case Qt.Key_Return:
				case Qt.Key_Enter:
					powerButton.powerButton.clicked()
					break;
				case Qt.Key_Right:
					userField.focus = true
					break;
				case Qt.Key_Left:
					sessionPanel.sessionButton.focus = true
					break
				case Qt.Key_Down:
					rebootButton.rebootButton.focus = true
					break
				case Qt.Key_Up:
					sleepButton.sleepButton.focus = true
					break
				}
			}
		}

		RebootButton {
			id: rebootButton
			Keys.onPressed: {
				switch (event.key) {
				case Qt.Key_Return:
				case Qt.Key_Enter:
					rebootButton.rebootButton.clicked()
					break
				case Qt.Key_Up:
					powerButton.powerButton.focus = true
					break
				case Qt.Key_Down:
					sleepButton.sleepButton.focus = true
					break
				case Qt.Key_Right:
					userField.focus = true
					break
				case Qt.Key_Left:
					sessionPanel.sessionButton.focus = true
					break
				}
			}
		}

		SleepButton {
			id: sleepButton
			Keys.onPressed: {
				switch (event.key) {
				case Qt.Key_Return:
				case Qt.Key_Enter:
					sleepButton.sleepButton.clicked()
					break
				case Qt.Key_Up:
					rebootButton.rebootButton.focus = true
					break
				case Qt.Key_Down:
					powerButton.powerButton.focus = true
					break
				case Qt.Key_Right:
					userField.focus = true
					break
				case Qt.Key_Left:
					sessionPanel.sessionButton.focus = true
					break
				}
			}
		}
	}

	// Right Panel (Session Panel)
	Column {
		spacing: config.FontSize / 2
		anchors {
			bottom: parent.bottom
			right: parent.right
		}

		SessionPanel {
			id: sessionPanel
			userField: userField
			Keys.onPressed: {
				switch (event.key) {
				case Qt.Key_Return:
				case Qt.Key_Enter:
					sessionPanel.sessionButton.clicked()
					break
				case Qt.Key_Left:
					userField.focus = true
					break
				case Qt.Key_Right:
					powerButton.powerButton.focus = true
					break
				}
			}
		}
	}

	// Center Column (User and Password)
	Column {
		id: column
		spacing: config.FontSize
		width: inputWidth
		anchors {
			verticalCenter: parent.verticalCenter
			horizontalCenter: parent.horizontalCenter
		}
		Keys.onPressed: {
			switch (event.key) {
			case Qt.Key_Return:
			case Qt.Key_Enter:
				loginButton.clicked()
			}
		}

		UserField {
			id: userField
			height: config.FontSize * 2.5
			width: parent.width
			focus: userModel.lastUser == ""
			Keys.onPressed: {
				switch (event.key) {
				case Qt.Key_Down:
					passwordField.focus = true
					break
				case Qt.Key_Right:
					sessionPanel.sessionButton.focus = true
					break
				case Qt.Key_Left:
					powerButton.powerButton.focus = true
					break
				}
			}
		}

		RowLayout {
			id: row
			spacing: config.FontSize
			PasswordField {
				id: passwordField
				Layout.preferredWidth: (inputWidth - loginButton.width - row.spacing)
				Layout.preferredHeight: config.FontSize * 2.5
				focus: userModel.lastUser != ""


				Keys.onPressed: {
					switch (event.key) {
					case Qt.Key_Up:
						userField.focus = true
						break
					case Qt.Key_Right:
						loginButton.focus = true
						break
					case Qt.Key_Left:
						powerButton.powerButton.focus = true
						break
					}
				}
			}

			Button {
				id: loginButton
				Layout.preferredWidth: config.FontSize * 2.5
				Layout.preferredHeight: config.FontSize * 2.5
				hoverEnabled: true
				onClicked: sddm.login(user, password, session)
				MouseArea {
					id: mouseArea
					anchors.fill: parent
					cursorShape: Qt.PointingHandCursor
					onClicked: sddm.login(user, password, session)
				}
				icon {
					source: Qt.resolvedUrl("../icons/login.svg")
					color: config.fgColor
				}
				background: Rectangle {
					id: loginButtonBackground
					color: config.bgColor
					border.color: config.fgColor
				}
				states: [
					State {
						name: "focus"
						when: loginButton.focus || loginButton.hovered
						PropertyChanges {
							target: loginButtonBackground
							border.color: config.placeholderColor
						}
					}
				]
				Keys.onPressed: {
					switch (event.key) {
					case Qt.Key_Left:
						passwordField.focus = true
						break
					case Qt.Key_Up:
					case Qt.Key_Down:
						userField.focus = true
						break
					case Qt.Key_Right:
						sessionPanel.sessionButton.focus = true
						break
					}
				}
			}
		}
	}

	Connections {
		target: sddm
		function onLoginFailed() {
			passwordField.text = ""
			passwordField.focus = true
		}
	}
}
