import QtQuick 2.9
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import ".."

MenuPage {
    property alias addButton: addButton
    property alias records: records
    property alias viewContainer: viewContainer
    property var col1Ratio: 0.3
    property var col2Ratio: 0.7
    title: qsTrId("diary")
    id: viewContainer

    ScrollView {
        anchors.fill: parent
        clip: true
        contentWidth: column.width
        contentHeight: column.height

        Column {
            id: column
            Repeater {
                id: records
                Item {
                    width: viewContainer.width
                    height: viewContainer.height*0.2

                    DescriptionLabel {
                        anchors.fill: parent
                        verticalAlignment: Text.AlignVCenter
                        anchors.margins: 10
                    }

                    Rectangle{color: (index%2 == 0) ? "black" : "white"
                        anchors.fill: parent
                        opacity: 0.2
                     }
                   MouseArea {
                        anchors.fill: parent
                        Connections {
                            onClicked: {
                                stackView.push("DiaryRecord.qml", {"recordIndex": index})
                            }
                        }
                    }
                }
            }
            Item {
                height: 50
                width: 50
            }
        }}
        AddButton {
            id: addButton
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.margins: 5
        }
}
