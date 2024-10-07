import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQml.Models 2.15

Item {
  property var session: sessionList.currentIndex
  implicitHeight: sessionButton.height
  implicitWidth: sessionButton.width
  DelegateModel {
    id: sessionWrapper
    model: sessionModel
    delegate: ItemDelegate {
      id: sessionEntry
      height: config.FontSize * 2
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
          name: "pressed"
          when: sessionEntry.down
          PropertyChanges {
            target: sessionEntryBackground
            border.color: config.fgDefault
            border.width: 1
          }
        },
        State {
          name: "hovered"
          when: sessionEntry.hovered
          PropertyChanges {
            target: sessionEntryBackground
            border.color: config.fgColor
            border.width: 1
          }
        }
      ]
      MouseArea {
        anchors.fill: parent
        onClicked: {
          sessionList.currentIndex = index
          sessionPopup.close()
        }
      }
    }
  }
  Button {
    id: sessionButton
    height: config.FontSize * 2
    width: config.FontSize * 2
    hoverEnabled: true
    icon {
      source: Qt.resolvedUrl("../icons/settings.svg")
      color: config.textDefault
    }
    background: Rectangle {
      id: sessionButtonBackground
      color: config.bgColor
      border.color: config.fgColor
      border.width: 1
    }
    onClicked: {
      sessionPopup.visible ? sessionPopup.close() : sessionPopup.open()
      sessionButton.state = "pressed"
    }
  }
  Popup {
    id: sessionPopup
    width: inputWidth
    x: -(inputWidth)
    y: -(contentHeight + padding * 2) + sessionButton.height
    padding: 8
    background: Rectangle {
      color: config.bgColor
      border.color: config.fgColor
      border.width: 1
    }
    contentItem: ListView {
      id: sessionList
      implicitHeight: contentHeight
      spacing: 8
      model: sessionWrapper
      currentIndex: sessionModel.lastIndex
      clip: true
    }
  }
}
