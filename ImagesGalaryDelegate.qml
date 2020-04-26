import "js/app.js" as app;

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

            source: app.config.static + "/images/img/" + model.image;

            fillMode: PreserveAspectFit;
        }
    }

    Rectangle {
        id: galaryItemsIndex;
        z: 3;
        anchors.top: galaryItems.top;
        anchors.left: galaryItems.left;
        anchors.margins: app.sizes.margin / 2;
        radius: 10;
        width: 25;
        height: 25;

        opacity: galaryItems.activeFocus ? 1.0 : 0.8;
        color: fit.isDark ? app.theme.dark.item_background : app.theme.light.item_background;
        focus: true;

        Text {
            id: indexTxt;
            opacity: galaryItems.activeFocus ? 1.0 : 0.8;

            anchors.centerIn: parent;

            color: fit.isDark ? app.theme.dark.textColor : app.theme.light.textColor;

            text: model.id;

            font: Font {
                family: "Proxima Nova Condensed";
                pixelSize: 28;
                black: true;
            }
        }
    }
}
