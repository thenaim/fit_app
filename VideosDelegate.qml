import "js/app.js" as app;
Rectangle {
    id: videosDelegate;
    anchors.top: videoItems.top;

    width: app.sizes.poster.width;
    height: (app.sizes.poster.height * 2);
    opacity: 1;
    color: fit.isDark ? app.theme.dark.layout_background : app.theme.light.layout_background;

    focus: true;

    Item {
        id: imageVideoItem;
        anchors.top: videosDelegate.top;
        anchors.left: videosDelegate.left;

        width: app.sizes.poster.width;
        height: app.sizes.poster.height;

        Image {
            id: imageCardDefault;
            anchors.top: videosDelegate.top;
            anchors.left: parent.left;

            width: app.sizes.poster.width;
            height: app.sizes.poster.height;
            
            visible: imageCard.status !== ui.Image.Ready;
            opacity: imageCard.status !== ui.Image.Ready ? 1.0 : 0;
            registerInCacheSystem: false;

            source: app.config.defaultImage;

            fillMode: PreserveAspectFit;
        }

        Image {
            id: imageCard;
            anchors.top: videosDelegate.top;
            anchors.left: parent.left;

            width: app.sizes.poster.width;
            height: app.sizes.poster.height;

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
        anchors.margins: app.sizes.margin / 2;
        opacity: 1.0;

        visible: true;
        color: fit.isDark ? app.theme.dark.textColor : app.theme.light.textColor;
        text: model.title;

        font: Font {
            family: "Times";
            pixelSize: 26;
            black: true;
        }
    }

    /*
    Text {
        id: videoText;
        z: 2;
        anchors.top: imageVideoItem.bottom;
        anchors.left: imageVideoItem.left;
        anchors.right: imageVideoItem.right;
        anchors.margins: app.sizes.margin / 2;

        width: app.sizes.poster.width - 5;
        height: app.sizes.poster.height - 19;

        color: fit.isDark ? app.theme.dark.textColor : app.theme.light.textColor;
        text: app.wrapText(model.title, 35);
        wrapMode: Text.WordWrap;

        font: Font {
            family: "Times";
            pixelSize: videosDelegate.activeFocus ? 22 : 20;
            black: true;
        }
    }
    */

    Image {
        id: bookmarkImage;
        z: 2;
        anchors.left: videosDelegate.left;
        anchors.right: videosDelegate.right;
        anchors.bottom: videosDelegate.bottom;
        // anchors.horizontalCenter: videosDelegate.horizontalCenter;
        anchors.margins: app.sizes.margin;

        width: 20;
        height: 20;

        visible: true;
        registerInCacheSystem: false;

        source: model.bookmark ? "apps/fit_app/res/heart_added.png" : "apps/fit_app/res/heart_add.png";

        fillMode: PreserveAspectFit;
    }
}

