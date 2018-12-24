import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import MyStatesEnum 1.0

Item {
    function getDate(){
        return internalcalendar.selectedDate;
    }

    function setDate(someDate){
        internalcalendar.selectedDate = someDate;
    }

    function getDateStyle(state){
        switch(state){
        case DateStyle.BookedDate:
            return "yellow";
        case DateStyle.SaleDate:
            return "red";
        default:
            return "transparent";
        }
    }

    Calendar{
        id: internalcalendar

        anchors.fill: parent

        style: CalendarStyle{
            navigationBar:Rectangle{
                height: 48
                color: "#f7f7f7"

                Rectangle{
                    color: "#d7d7d7"
                    height: 1
                    width: parent.width
                    anchors.bottom: parent.bottom
                }

                Button{
                    id: prevMon
                    width: parent.height - 8
                    height: width
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 8

                    onClicked: control.showPreviousMonth()

                    style: ButtonStyle{
                        background: Rectangle{
                            color: "#f7f7f7"
                            Image{
                                source: control.pressed ? "left_arrow_disable.png" : "left_arrow.png"
                                width: parent.width - 8
                                height: width
                            }
                        }
                    }
                }

                Label{
                    id: dateText
                    text: styleData.title
                    color: "#34aadc"
                    elide: Text.ElideRight
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 16
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: prevMon.right
                    anchors.leftMargin: 2
                    anchors.right: nextMon.left
                    anchors.rightMargin: 2
                }

                Button{
                    id: nextMon
                    width: parent.height - 8
                    height: width
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right

                    onClicked: control.showNextMonth()

                    style: ButtonStyle{
                        background: Rectangle{
                            color: "#f7f7f7"
                            Image{
                                source: control.pressed ? "right_arrow_disable.png" : "right_arrow.png"
                                width: parent.height - 8
                                height: width
                            }
                        }
                    }
                }
            }



            dayDelegate: Rectangle{
                anchors.fill: parent
                anchors.margins: styleData.selected ? -1 : 0

                readonly property color sameMonthDateTextColor: "#444"
                readonly property color selectedDateColor: "#34aadc"
                readonly property color selectedDateTextColor: "white"
                readonly property color differentMonthDateTextColor: "#bbb"
                readonly property color invalidDateColor: "#dddddd"
                readonly property color targetDateColor: "red"
                readonly property color targetDateTextColor: "white"
                color: {
                    var background = "transparent"
                    if (styleData.date !== undefined )
                    {
                       if (styleData.selected)
                       {
                          background = selectedDateColor
                       }
                       for(var i = 0; i < DatesModel.getCount(); i++){
                           var targetDate = DatesModel.getByIndex(i);
                           if (styleData.date.getDate() == targetDate.getDate() && styleData.date.getMonth() == targetDate.getMonth() && styleData.date.getFullYear() == targetDate.getFullYear())
                           {
                               background = getDateStyle(DatesModel.getState(i));
                           }
                       }
                    }
                    background
                }

                Label{
                    id: dayDelegateText
                    text: styleData.date.getDate()
                    anchors.centerIn: parent
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 10

                    color:{
                        var theColor = invalidDateColor;
                        if (styleData.valid)
                        {
                            theColor = styleData.visibleMonth ? sameMonthDateTextColor : differentMonthDateTextColor;
                            if (styleData.selected)
                            {
                                theColor = selectedDateTextColor;
                            }
                            if (styleData.date.getDate() == new Date(11, 12, 2018))
                            {
                                theColor = "white"
                            }

                            theColor;
                        }
                    }
                }
            }
        }

    }
}
