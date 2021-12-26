﻿import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import ".."

MenuPage {
    property alias addButton: addButton
    property alias sendArea: sendArea
    property alias records: records
    property alias viewContainer: viewContainer
    property var col1Ratio: 0.3
    property var col2Ratio: 0.7
    title: titleText
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
                    property var header: false
                    property var position: 0
                    width: viewContainer.width
                    height: viewContainer.height*0.2

                    DescriptionLabel {
                        anchors.fill: parent
                        verticalAlignment: Text.AlignVCenter
                        anchors.margins: 10
                        font.bold: header
                    }

                    Row {
                        anchors.fill: parent
                        layoutDirection: Qt.RightToLeft
                        spacing: 5
                        visible: dateOnly && arrayNames.length > 1
                        Repeater{
                            model: 6
                            Image {
                                property var ok: false
                                source: (ok) ? "qrc:/images/tick.svg" : "qrc:/images/delete.svg"
                                height: parent.height*0.23
                                width: parent.height*0.23
                                anchors.verticalCenter: parent.verticalCenter
                                fillMode: Image.PreserveAspectFit
                            }
                    }}

                    Rectangle{color: (index%2 == 0) ? "black" : "white"
                        anchors.fill: parent
                        opacity: (header) ? 0.0 : 0.2
                     }
                   MouseArea {
                        anchors.fill: parent
                        Connections {
                            function onClicked() {
                                stackView.push(afterDateFile, {"dataRecordIndex": position, "arrayNames" : arrayNames, "questionTexts" : questionTexts, "titleText" : titleText})
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

        Image {
            source: "qrc:/images/letter.svg"
            height: 60
            width: 90
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.margins: 5
            fillMode: Image.PreserveAspectFit
            opacity: 0.5
            MouseArea {
                anchors.fill: parent
                id: sendArea
            }
            visible: sendingEnabled
        }
}
