import "js/app.js" as appMain;

Rectangle {
    id: galaryItems;
    z: 1;
    width: parent.height;
    height: parent.height;
    opacity: 1.0;
    color: "#ffffff";
    focus: true;
    
    Rectangle {
        id: galaryItems;
        z: 1;
        width: parent.height;
        height: parent.height;
        opacity: galaryItems.activeFocus ? 1.0 : 0.7;
        color: "#ffffff";
        focus: true;

        Image {
            z: 2;
            width: parent.height;
            height: parent.height;
            opacity: galaryItems.activeFocus ? 1.0 : 0.7;

            visible: true;
            registerInCacheSystem: false;
            source: appMain.config.static + "/images/img/" + model.image;
            fillMode: PreserveAspectFit;
        }
    }

    Rectangle {
        id: galaryItemsIndex;
        z: 3;
        anchors.top: galaryItems.top;
        anchors.horizontalCenter: galaryItems.horizontalCenter;
        anchors.margins: appMain.sizes.margin / 2;
        radius: 10;
        width: 25;
        height: 25;

        opacity: galaryItems.activeFocus ? 1.0 : 0.8;
        color: fit.isDark ? appMain.theme.dark.item_background : appMain.theme.light.item_background;
        focus: true;

        Text {
            id: indexTxt;
            anchors.centerIn: parent;

            opacity: galaryItems.activeFocus ? 1.0 : 0.8;
            color: fit.isDark ? appMain.theme.dark.textColor : appMain.theme.light.textColor;
            text: model.id;
            font: Font {
                family: "Proxima Nova Condensed";
                pixelSize: 28;
                black: true;
            }
        }
    }
}
