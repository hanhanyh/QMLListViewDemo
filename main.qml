import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex


        Page {
            BusyIndicator{
               id:indicator
               running: false
               z:2
               anchors.centerIn: parent
            }
            Timer{
                id:timer
                interval: 1000
                running: false
                onTriggered: indicator.running=false
            }
            ListModel{
                id:lm


                ListElement{name:"xx";age:"12"}
                ListElement{name:"xx";age:"12"}
                ListElement{name:"xx";age:"12"}
                ListElement{name:"xx";age:"12"}
                ListElement{name:"xx";age:"12"}
                ListElement{name:"xx";age:"12"}
                ListElement{name:"xx";age:"12"}
                ListElement{name:"xx";age:"12"}
                ListElement{name:"xx";age:"12"}
                ListElement{name:"xx";age:"12"}
                ListElement{name:"xx";age:"12"}
                ListElement{name:"xx";age:"12"}
                ListElement{name:"xx";age:"12"}
                ListElement{name:"xx";age:"12"}
                ListElement{name:"xx";age:"12"}
                ListElement{name:"xx";age:"12"}
            }

            ListView{
                id:lv
                 width:parent.width
                 height:parent.width
                 model:lm
                 focus: true
                 clip:true
                 Component.onCompleted: {
                     console.log("contentY:"+lv.contentY)
                     console.log("contentHeight"+lv.contentHeight)
                     console.log("Height:"+lv.height)
                 }
                 onFlickEnded:
                 {
                     if(lv.contentY<1)
                     {
                         console.log("下拉刷新")
                     }
                 }
                 onFlickStarted:{
                    console.log("开始拉动"+contentY)
                     //内容右上角Y>0 表示 上拉
                     //contentHeight内容高度-内容右上角Y=屏幕+剩下内容宽度
                     //如果剩下内容宽度 不足listview 高度的9/10 就是下拉刷新了
                     if(contentY>0&&contentHeight-contentY<contentHeight*(9/10))
                      {
                         indicator.running=true
                         timer.start()
                         console.log("上拉加载")
                         var rd=Math.random()
                         lm.append({name:"hanhan"+rd,age:"20"});
                          lm.append({name:"hanhan"+rd,age:"20"});
                          lm.append({name:"hanhan"+rd,age:"20"});
                          lm.append({name:"hanhan"+rd,age:"20"});
                          lm.append({name:"hanhan"+rd,age:"20"});
                     }
                     //如果 contentY<0表示 下拉
                     if(contentY<0)
                     {
                         indicator.running=true
                         timer.start()
                         console.log("下拉刷新")
                     }
                }

                delegate:Rectangle {
                    width:parent.width
                    height:50
                    color:ListView.isCurrentItem?"red":"white"
                    Label{
                        text:name
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            lv.currentIndex=index
                        }
                    }
                }

            }
        }

        Page {
            Label {
                text: qsTr("Second page")
                anchors.centerIn: parent
            }
        }
    }

    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex
        TabButton {
            text: qsTr("First")
        }
        TabButton {
            text: qsTr("Second")
        }
    }
}
