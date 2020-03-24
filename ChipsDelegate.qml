import "js/app.js" as app;
Rectangle {
    id: chipsDelegate;
    anchors.top: chipItems.top;

    opacity: activeFocus ? 1.0 : app.config.inactiveOpacity;
    color: fit.isDark ? app.theme.dark.layout_background : app.theme.light.layout_background;
    focus: true;

    radius: app.sizes.radius;

    width: app.sizes.chips.width;
    height: app.sizes.chips.height;

    Image {
        id: imageChip;
        z: 3;
        anchors.top: chipsDelegate.top;
        anchors.margins: app.sizes.margin / 2;
        
        anchors.horizontalCenter: parent.horizontalCenter;

        width: chipsDelegate.activeFocus ? 54 : 50;
        height: chipsDelegate.activeFocus ? 54 : 50;

        registerInCacheSystem: false;

        source: app.config.static + "/images/cat/" + model.image;

        fillMode: PreserveAspectFit;

        Behavior on width  { animation: Animation { duration: app.config.animationDuration; } }
        Behavior on height { animation: Animation { duration: app.config.animationDuration; } }
    }

    Text {
        id: tabText;
        z: 3;
        anchors.top: imageChip.bottom;
        anchors.margins: app.sizes.margin / 2;

        anchors.horizontalCenter: parent.horizontalCenter;

        color: fit.isDark ? app.theme.dark.textColor : app.theme.light.textColor;
        text: model.name;
        wrapMode: Text.WordWrap;

        font: Font {
            family: "Times";
            pixelSize: chipsDelegate.activeFocus ? 24 : 23;
            black: true;
        }
    }
}

