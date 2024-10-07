import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.2

Item {
  property var user: userField.text
  property var password: passwordField.text
  property var session: sessionPanel.session
  property var inputHeight: config.FontSize * 7
  property var inputWidth: config.FontSize * 16
  Rectangle {
    id: loginBackground
    anchors {
      verticalCenter: parent.verticalCenter
      horizontalCenter: parent.horizontalCenter
    }
    height: inputHeight * 1.5
    width: inputWidth * 1.5
    visible: true
    color: config.bgColor
    border.color: config.fgColor
    border.width: 1
  }
  Column {
    spacing: config.FontSize / 2
    anchors {
      bottom: parent.bottom
      left: parent.left
    }
    PowerButton {
      id: powerButton
    }
    RebootButton {
      id: rebootButton
    }
    SleepButton {
      id: sleepButton
    }
    z: 5
  }
  Column {
    spacing: config.FontSize / 2
    anchors {
      bottom: parent.bottom
      right: parent.right
    }
    SessionPanel {
      id: sessionPanel
    }
    z: 5
  }
  Column {
    id: column
    spacing: config.FontSize
    z: 5
    width: inputWidth
    anchors {
      verticalCenter: parent.verticalCenter
      horizontalCenter: parent.horizontalCenter
    }
    UserField {
      id: userField
      height: config.FontSize * 2
      width: parent.width
    }
    RowLayout {
      id: row
      spacing: config.FontSize
      anchors {
        horizontalCenter: parent.horizontalCenter
      }
      PasswordField {
        id: passwordField
        Layout.preferredWidth: (inputWidth - loginButton.width - row.spacing)
        Layout.preferredHeight: config.FontSize * 2
        onAccepted: loginButton.clicked()
      }
      Button {
        id: loginButton
        Layout.preferredWidth: config.FontSize * 2
        Layout.preferredHeight: config.FontSize * 2
        enabled: user != "" && password != "" ? true : false
        hoverEnabled: true
        icon {
          source: Qt.resolvedUrl("../icons/login.svg")
          color: config.textDefault
        }
        background: Rectangle {
          id: buttonBackground
          color: config.bgColor
          border.color: config.fgColor
          border.width: 1
        }
        onClicked: {
          sddm.login(user, password, session)
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
