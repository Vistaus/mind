import QtQuick 2.14
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.12
import io.qt.UserDataProvider 1.0
import io.qt.Translator 1.0
import QtGraphicalEffects 1.0
import "."

ApplicationWindow {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTrId("appName")

    MouseArea {
        id: outFocuser
        anchors.fill: parent
        z: -999
        onClicked: outFocuser.forceActiveFocus();
    }

    UserDataProvider {
        id: dataProvider
    }

    Translator {
        id: translator
    }

    onVisibilityChanged: {
        ThemeInfo.hueValue = dataProvider.loadInput("themeHue")
        ThemeInfo.backgroundLightness = dataProvider.loadInput("themeLight")
    }

    onClosing: {
        if (stackView.depth > 1) {
            close.accepted = false
            stackView.pop()
        } else
            return
    }
    background: Rectangle {
        id: appBckg
        color: "#9a9a9a"
    }
    Colorize {
        anchors.fill: parent
        source: appBckg
        hue: ThemeInfo.hueValue
        saturation: 0.6
        lightness: ThemeInfo.backgroundLightness
    }

    header: ToolBar {
        contentHeight: backButton.implicitHeight
        background: Rectangle {
            color: "#9a9a9a"
            id: barBckg
            visible: false
        }

        height: 40
        font.pointSize: 14
        Colorize {
            id: headerColor
            anchors.fill: parent
            source: barBckg
            hue: ThemeInfo.hueValue
            saturation: 0.6
            lightness: ThemeInfo.backgroundLightness - ThemeInfo.elementSubtractor
        }

        Shadow {
              anchors.fill: headerColor
              source: headerColor
            }

        ToolButton {
            id: backButton
            background: Image {
                source: stackView.depth > 1 ? "qrc:/images/back.svg" : "qrc:/images/exit.svg"
                fillMode: Image.PreserveAspectFit
            }
            height: parent.height
            width: parent.width / 17
            anchors.leftMargin: parent.width / 50
            anchors.left: parent.left
            onClicked: {
                if (stackView.depth > 1) {
                    stackView.pop()
                } else
                    Qt.quit()
            }
        }

        ToolButton {
            id: settingsButton
            background: Image {
                source: "qrc:/images/gear.svg"
                fillMode: Image.PreserveAspectFit
            }
            height: parent.height
            width: parent.width / 17
            onClicked: drawer.open()
            anchors.right: parent.right
            anchors.rightMargin: parent.width / 50
        }

        Label {
            text: stackView.currentItem.title
            anchors.centerIn: parent
            //width: parent.width*0.7
            //horizontalAlignment: Text.AlignHCenter
            color: "White"
        }
    }

    //TODO to separate file
    Drawer {
        id: drawer
        width: window.width * 0.66
        height: window.height
        font.pointSize: 14
        z: 10
        background: Rectangle {
            id: bckg
            color: "#9a9a9a"
            visible: false
        }
        Colorize {
            anchors.fill: parent
            source: bckg
            hue: ThemeInfo.hueValue
            saturation: 0.6
            lightness: ThemeInfo.backgroundLightness - ThemeInfo.elementSubtractor
            opacity: 0.8
        }

        ScrollView {
            id: view
            anchors.fill: parent
            contentWidth: -1
            contentHeight: drawerItems.height
            clip: true
            anchors.margins: 10

        Column {
            //anchors.fill: parent
            id: drawerItems

            ItemDelegate {
                text: qsTrId("resetInputs")
                width: parent.width
                onClicked: {
                    stackView.push("Drawer/ClearData.qml")
                    drawer.close()
                }
            }

            ItemDelegate {
                text: qsTrId("contactUs")
                width: parent.width
                onClicked: {
                    stackView.push("Drawer/ContactUs.qml")
                    drawer.close()
                }
            }

            ItemDelegate {
                text: qsTrId("rate")
                width: parent.width
                onClicked: {
                    drawer.close()
                    if (Qt.platform.os == "ios")
                        Qt.openUrlExternally(
                                    "itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=1459513911&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software")
                    else
                        Qt.openUrlExternally(
                                    "https://play.google.com/store/apps/details?id=org.dontpanic")
                }
            }

            ItemDelegate {
                text: qsTrId("support")
                width: parent.width
                onClicked: {
                    stackView.push("Drawer/Support.qml")
                    drawer.close()
                }
            }

            ItemDelegate {
                text: qsTrId("custom-theme")
                width: parent.width
                onClicked: {
                    stackView.push("Drawer/CustomTheme.qml")
                    drawer.close()
                }
            }

            ItemDelegate {
                text: qsTrId("aboutApp")
                width: parent.width
                onClicked: {
                    stackView.push("Drawer/AboutApp.qml")
                    drawer.close()
                }
            }

            ItemDelegate {
                text: qsTrId("import-export")
                width: parent.width
                onClicked: {
                    stackView.pop(null);
                    stackView.push("Drawer/ImportExport.qml")
                    drawer.close()
                }
            }

            ItemDelegate {
                text: qsTrId("exit")
                width: parent.width
                onClicked: {
                    Qt.quit()
                }
            }

            LineDelimiter{
                height: 5
                width: drawer.width}

            GridLayout {
                columns: 3
                width: drawer.width
                    RoundButton {
                        background: Image {
                            source: "qrc:/images/fb.svg"
                        }
                        onClicked: {Qt.openUrlExternally(qsTrId("fb-link")); drawer.close()}
                        Layout.maximumWidth: drawer.width*0.2
                        Layout.maximumHeight: drawer.width*0.2
                        Layout.topMargin: 20
                        Layout.margins: 10
                    }

                    RoundButton {
                        background: Image {
                            source: "qrc:/images/instagram.svg"
                        }
                        onClicked: {Qt.openUrlExternally(qsTrId("mlceni-link")); drawer.close()}
                        Layout.maximumWidth: drawer.width*0.2
                        Layout.maximumHeight: drawer.width*0.2
                        Layout.topMargin: 20
                        Layout.margins: 10
                    }

                    RoundButton {
                        background: Image {
                            source: "qrc:/images/web.svg"
                        }
                        onClicked: {Qt.openUrlExternally(qsTrId("web-link")); drawer.close()}
                        Layout.maximumWidth: drawer.width*0.2
                        Layout.maximumHeight: drawer.width*0.2
                        Layout.topMargin: 20
                        Layout.margins: 10
                    }
            }

            LineDelimiter{
                height: 5
                width: drawer.width}

            GridLayout {
                columns: 3
                width: drawer.width
                Repeater{
                    id: languageList
                    model: 0
                    RoundButton {
                        property var language: "EN"
                        background: Image {
                            source: "qrc:/images/"+language+".svg"
                        }
                        onClicked: {stackView.pop(null); drawer.close(); dataProvider.setLanguage(language); translator.changeLanguage(language); dataProvider.translateInputs();}
                        Layout.maximumWidth: drawer.width*0.2
                        Layout.maximumHeight: drawer.width*0.2
                        Layout.topMargin: 20
                        Layout.margins: 10
                        opacity: (dataProvider.loadLanguage() === language) ? 1.0 : 0.5
                    }
                }
            }
        }
    }}
    Connections{
        target: languageList
         Component.onCompleted: {
             var languages = translator.getLanguages();
             languageList.model = languages.length;
             for (var i = 0; i < languages.length; i++) {
                 languageList.itemAt(i).language = languages[i];
            }
    }}

    StackView {
        id: stackView
        initialItem: "Home.qml"
        anchors.fill: parent
    }
}
