
Item {
    id: statsLeaderDelegate;
    z: 1;
    width: 600;
    height: 50;
    opacity: 1.0;
    focus: true;

    Rectangle {
        id: statsLeaderPlace;
        anchors.top: statsLeaderDelegate.top;
        anchors.left: statsLeaderDelegate.left;
        anchors.leftMargin: appMain.sizes.margin / 2;
        anchors.rightMargin: appMain.sizes.margin / 2;
        z: 1;
        width: 85;
        height: 50;
        opacity: statsLeaderDelegate.activeFocus ? 1.0 : appMain.config.inactiveOpacity;
        color: fit.isDark ? appMain.theme.dark.item_background : appMain.theme.light.item_background;
        radius: appMain.sizes.radius;
        focus: true;

        Text {
            anchors.centerIn: statsLeaderPlace;

            opacity: statsLeaderDelegate.activeFocus ? 1.0 : appMain.config.inactiveOpacity;
            color: fit.stingray["id"] === model.id ? appMain.theme.light.background : fit.isDark ? appMain.theme.dark.textColor : appMain.theme.light.textColor;
            text: model.place;
            font: Font {
                family: "Proxima Nova Condensed";
                pixelSize: fit.fullscreen ? 34 : 28;
                black: true;
            }
        }
    }

    Rectangle {
        id: statsLeaderId;
        anchors.top: statsLeaderDelegate.top;
        anchors.left: statsLeaderPlace.right;
        anchors.leftMargin: appMain.sizes.margin / 2;
        anchors.rightMargin: appMain.sizes.margin / 2;
        z: 1;
        width: 235;
        height: 50;
        opacity: statsLeaderDelegate.activeFocus ? 1.0 : appMain.config.inactiveOpacity;
        color: fit.isDark ? appMain.theme.dark.item_background : appMain.theme.light.item_background;
        radius: appMain.sizes.radius;
        focus: true;

        Text {
            anchors.centerIn: statsLeaderId;

            opacity: statsLeaderDelegate.activeFocus ? 1.0 : appMain.config.inactiveOpacity;
            color: fit.stingray["id"] === model.id ? appMain.theme.light.background : fit.isDark ? appMain.theme.dark.textColor : appMain.theme.light.textColor;
            text: model.id;
            font: Font {
                family: "Proxima Nova Condensed";
                pixelSize: fit.fullscreen ? 34 : 28;
                black: true;
            }
        }
    }

    Rectangle {
        id: statsLeaderPoints;
        anchors.top: statsLeaderDelegate.top;
        anchors.left: statsLeaderId.right;
        anchors.leftMargin: appMain.sizes.margin / 2;
        anchors.rightMargin: appMain.sizes.margin / 2;
        z: 1;
        width: 235;
        height: 50;
        opacity: statsLeaderDelegate.activeFocus ? 1.0 : appMain.config.inactiveOpacity;
        color: fit.isDark ? appMain.theme.dark.item_background : appMain.theme.light.item_background;
        radius: appMain.sizes.radius;
        focus: true;

        Text {
            anchors.centerIn: statsLeaderPoints;

            opacity: statsLeaderDelegate.activeFocus ? 1.0 : appMain.config.inactiveOpacity;
            color: fit.stingray["id"] === model.id ? appMain.theme.light.background : fit.isDark ? appMain.theme.dark.textColor : appMain.theme.light.textColor;
            text: model.points;
            font: Font {
                family: "Proxima Nova Condensed";
                pixelSize: fit.fullscreen ? 34 : 28;
                black: true;
            }
        }
    }
}



