import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.2
import QtQuick.Window 2.2

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    property var tempDate: new Date();

    Button{
        id: button

        style: ButtonStyle{

            label: Text {
                text: Qt.formatDate(tempDate, "dd.MM.yyyy")
                font.pixelSize: 14
                color: "#34aadc"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
        }

        anchors.centerIn: parent

        onClicked: dialogCalendar.show(tempDate)
    }

    Dialog{
        id: dialogCalendar

        width: 250
        height: 300

        contentItem: Rectangle{
            id: dialogRect
            color: "#f7f7f7"

            CustomCalendar{
                id: calendar
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: row.top
            }

            Row{
                    id: row
                    height: 48
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom

                    Button{
                        id: dialogButtonCancel

                        anchors.top: parent.top
                        anchors.bottom: parent.bottom

                        width: parent.width / 2 - 1

                        style: ButtonStyle{
                            background: Rectangle{
                                color: control.pressed ? "#d7d7d7" : "#f7f7f7"
                                border.width: 0
                            }

                            label: Text {
                                text: qsTr("Cancel")
                                font.pixelSize: 14
                                color: "#34aadc"
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                            }
                        }

                        onClicked: dialogCalendar.close()

                    }

                    Rectangle{
                        id: dividerVertical
                        width: 2
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        color: "#d7d7d7"
                    }

                    Button{
                        id: dialogButtonOk
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        width: parent.width / 2 - 1

                        style: ButtonStyle{
                            background: Rectangle{
                                color: control.pressed ? "#d7d7d7" : "#f7f7f7"
                                border.width: 0
                            }

                            label: Text {
                                text: qsTr("Ok")
                                font.pixelSize: 14
                                color: "#34aadc"
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                            }
                        }

                        onClicked: {
                            tempDate = calendar.getDate()
                            button.text = Qt.formatDate(tempDate, "dd.MM.yyy");
                            dialogCalendar.close();
                        }
                    }
                }

        }
        function show(x){
            calendar.setDate(x)
            dialogCalendar.open()
        }
    }
}
