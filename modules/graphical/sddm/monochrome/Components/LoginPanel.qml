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

		CustomButton {
			id: powerButton
			iconSource: "../icons/power.svg"
			onButtonClicked: sddm.powerOff()
			Keys.onPressed: {
				switch (event.key)  {
				case Qt.Key_Return:
				case Qt.Key_Enter:
					powerButton.button.clicked()
					break;
				case Qt.Key_Right:
					userField.forceActiveFocus()
					break;
				case Qt.Key_Left:
					sessionPanel.sessionButton.button.forceActiveFocus()
					break
				case Qt.Key_Down:
					rebootButton.button.forceActiveFocus()
					break
				case Qt.Key_Up:
					sleepButton.button.forceActiveFocus()
					break
				}
			}
		}

		CustomButton {
			id: rebootButton
			iconSource: "../icons/reboot.svg"
			onButtonClicked: sddm.reboot()
			Keys.onPressed: {
				switch (event.key) {
				case Qt.Key_Return:
				case Qt.Key_Enter:
					rebootButton.button.clicked()
					break
				case Qt.Key_Up:
					powerButton.button.forceActiveFocus()
					break
				case Qt.Key_Down:
					sleepButton.button.forceActiveFocus()
					break
				case Qt.Key_Right:
					userField.forceActiveFocus()
					break
				case Qt.Key_Left:
					sessionPanel.sessionButton.button.forceActiveFocus()
					break
				}
			}
		}

		CustomButton {
			id: sleepButton
			iconSource: "../icons/sleep.svg"
			onButtonClicked: sddm.suspend()
			Keys.onPressed: {
				switch (event.key) {
				case Qt.Key_Return:
				case Qt.Key_Enter:
					sleepButton.button.clicked()
					break
				case Qt.Key_Up:
					rebootButton.button.forceActiveFocus()
					break
				case Qt.Key_Down:
					powerButton.button.forceActiveFocus()
					break
				case Qt.Key_Right:
					userField.forceActiveFocus()
					break
				case Qt.Key_Left:
					sessionPanel.sessionButton.button.forceActiveFocus()
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
					sessionPanel.sessionButton.button.clicked()
					break
				case Qt.Key_Left:
					userField.forceActiveFocus()
					break
				case Qt.Key_Right:
					powerButton.button.forceActiveFocus()
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
				if (user == "") {
					userField.forceActiveFocus()
				} else if (password == "") {
					passwordField.forceActiveFocus()
				} else {
					loginButton.button.clicked()
				}
				break
			}
		}

		CustomTextField {
			id: userField
			echoMode: TextInput.Normal
			placeholderText: "Username"
			width: parent.width
			text: userModel.lastUser
			focus: userModel.lastUser === ""
			Keys.onPressed: {
				switch (event.key) {
				case Qt.Key_Up:
				case Qt.Key_Down:
					passwordField.forceActiveFocus()
					break
				case Qt.Key_Right:
					if (userField.cursorPosition === userField.text.length || event.modifiers & Qt.ControlModifier) {
						sessionPanel.sessionButton.button.forceActiveFocus()
					}
					break
				case Qt.Key_Left:
					if (userField.cursorPosition === 0 || event.modifiers & Qt.ControlModifier) {
						powerButton.button.forceActiveFocus()
					}
					break
				}
			}
		}

		RowLayout {
			id: row
			spacing: config.FontSize

			CustomTextField {
				id: passwordField
				placeholderText: "Password"
				echoMode: TextInput.Password
				Layout.preferredWidth: (inputWidth - loginButton.button.width - row.spacing)
				Layout.preferredHeight: config.FontSize * 2.5
				focus: userModel.lastUser !== ""

				Keys.onPressed: {
					switch (event.key) {
					case Qt.Key_Up:
					case Qt.Key_Down:
						userField.forceActiveFocus()
						break
					case Qt.Key_Right:
						if (passwordField.cursorPosition === passwordField.text.length || event.modifiers & Qt.ControlModifier) {
							loginButton.button.forceActiveFocus()
						}
						break
					case Qt.Key_Left:
						if (passwordField.cursorPosition === 0 || event.modifiers & Qt.ControlModifier) {
							powerButton.button.forceActiveFocus()
						}
						break
					}
				}
			}

			CustomButton {
				id: loginButton
				onButtonClicked: sddm.login(user, password, session)
				iconSource: "../icons/login.svg"

				Keys.onPressed: {
					switch (event.key) {
					case Qt.Key_Left:
						passwordField.forceActiveFocus()
						break
					case Qt.Key_Up:
					case Qt.Key_Down:
						userField.forceActiveFocus()
						break
					case Qt.Key_Right:
						sessionPanel.sessionButton.button.forceActiveFocus()
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
			passwordField.forceActiveFocus()
		}
	}
}
