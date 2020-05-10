import "js/app.js" as appMain;
Rectangle {
    id: videosDelegate;

    width: appMain.sizes.poster.width;
    height: (appMain.sizes.poster.height * 2);
    opacity: 1;
    color: fit.isDark ? appMain.theme.dark.layout_background : appMain.theme.light.layout_background;
    focus: true;

    Item {
        id: imageVideoItem;
        anchors.top: videosDelegate.top;
        anchors.left: videosDelegate.left;

        width: appMain.sizes.poster.width;
        height: appMain.sizes.poster.height;

        Image {
            id: imageCardDefault;
            anchors.top: videosDelegate.top;
            anchors.left: parent.left;

            width: appMain.sizes.poster.width;
            height: appMain.sizes.poster.height;
            
            visible: imageCard.status !== ui.Image.Ready;
            opacity: imageCard.status !== ui.Image.Ready ? 1.0 : 0;
            registerInCacheSystem: false;
            source: appMain.config.defaultImage;
            fillMode: PreserveAspectFit;
        }

        Image {
            id: imageCard;
            anchors.top: videosDelegate.top;
            anchors.left: parent.left;

            width: appMain.sizes.poster.width;
            height: appMain.sizes.poster.height;

            registerInCacheSystem: false;
            source: model.image;
            fillMode: PreserveAspectFit;
        }
    }

    ScrollingText {
        id: videoText;
        z: 2;
        anchors.top: imageVideoItem.bottom;
        anchors.left: imageVideoItem.left;
        anchors.right: imageVideoItem.right;
        anchors.bottom: bookmarkImage.top;
        anchors.margins: appMain.sizes.margin / 2;

        opacity: 1.0;
        visible: true;
        color: fit.isDark ? appMain.theme.dark.textColor : appMain.theme.light.textColor;
        text: model.title;
        font: Font {
            family: "Proxima Nova Condensed";
            pixelSize: 26;
            black: true;
        }
    }

    Image {
        id: bookmarkImage;
        z: 2;
        anchors.left: videosDelegate.left;
        anchors.right: videosDelegate.right;
        anchors.bottom: videosDelegate.bottom;
        anchors.margins: appMain.sizes.margin;

        width: 20;
        height: 20;

        visible: true;
        registerInCacheSystem: false;
        source: model.bookmark ? "apps/fit_app/res/heart_added.png" : "apps/fit_app/res/heart_add.png";
        fillMode: PreserveAspectFit;
    }
}

