Rectangle {
    id: typesDelegate;
    z: 1;
    height: parent.height;
    width: parent.typesCardWidth;
    opacity: 1.0;
    color: fit.isDark ? appMain.theme.dark.item_background : appMain.theme.light.item_background;
    radius: fit.fullscreen ? 0 : appMain.sizes.radius;
    focus: true;

    Text {
		id: typesTabText;
        anchors.centerIn: parent;

        opacity: typesDelegate.activeFocus ? 1.0 : appMain.config.inactiveOpacity;
		color: fit.isDark ? appMain.theme.dark.textColor : appMain.theme.light.textColor;
		text: model.title[fit.lang];
 		font: Font {
			  family: "Proxima Nova Condensed";
			  pixelSize: fit.fullscreen ? 34 : 28;
              black: true;
		}
	}

    /**
    * Bookmark badges
    */
    Rectangle {
        id: badge;
        anchors.top: typesTabText.top;
        anchors.right: typesTabText.right;
        anchors.rightMargin: -(badge.width + 4);

        height: 20;
        width: badgeLength.width + 10;
        radius: appMain.sizes.radius / 2;
        opacity: 1;
        color: "#f44336";
        visible: model.badgeInt;

        Text {
            id: badgeLength;
            anchors.centerIn: badge;

            opacity: parent.opacity;
            color: "#fff";
            text: model.badgeInt;
            font: Font {
                family: "Proxima Nova Condensed";
                pixelSize: 22;
                black: true;
            }
        }
    }
}



