Rectangle {
    id: chipsDelegate;
    anchors.top: chipItems.top;

    opacity: activeFocus ? 1.0 : 0.7;
    color: fit.isDark ? appMain.theme.dark.layout_background : appMain.theme.light.layout_background;
    focus: true;
    radius: appMain.sizes.radius;
    width: appMain.sizes.chips.width;
    height: appMain.sizes.chips.height;

    Image {
        id: imageChip;
        z: 3;
        anchors.top: chipsDelegate.top;
        anchors.margins: appMain.sizes.margin / 2;
        anchors.horizontalCenter: parent.horizontalCenter;

        width: chipsDelegate.activeFocus ? 64 : 60;
        height: chipsDelegate.activeFocus ? 54 : 50;

        registerInCacheSystem: false;
        source: appMain.config.static + "/images/cat/" + model.image;
        fillMode: PreserveAspectFit;

        Behavior on width  { animation: Animation { duration: appMain.config.animationDuration; } }
        Behavior on height { animation: Animation { duration: appMain.config.animationDuration; } }
    }

    Text {
        id: tabText;
        z: 3;
        anchors.top: imageChip.bottom;
        anchors.margins: appMain.sizes.margin / 2;
        anchors.horizontalCenter: parent.horizontalCenter;

        color: fit.isDark ? appMain.theme.dark.textColor : appMain.theme.light.textColor;
        text: model.name;
        wrapMode: Text.WordWrap;

        font: Font {
            family: "Proxima Nova Condensed";
            pixelSize: chipsDelegate.activeFocus ? 24 : 23;
            black: true;
        }
    }
}

