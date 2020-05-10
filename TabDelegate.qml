import "js/app.js" as appMain;

Rectangle {
    id: tabDelegate;
    opacity: 1.0;

    width: appMain.sizes.tabCards.width;
    height: appMain.sizes.tabCards.height;
    radius: appMain.sizes.radius;
    color: fit.isDark ? appMain.theme.dark.item_background : appMain.theme.light.item_background;
    focus: true;

    Image {
        id: tabImage;
        anchors.top: tabDelegate.top;
        anchors.horizontalCenter: tabDelegate.horizontalCenter;
        anchors.topMargin: tabDelegate.activeFocus ? 10 : 15;

        opacity: 1.0;
        height: 60;
        registerInCacheSystem: false;
        async: false;
        fillMode: PreserveAspectFit;
        source: "apps/fit_app/res/tabs/" + model.id + "_" + (fit.isDark ? "dark.png" : "light.png");

        Behavior on width  { animation: Animation { duration: appMain.config.animationDuration; } }
        Behavior on height { animation: Animation { duration: appMain.config.animationDuration; } }
    }

	Text {
		id: tabText;
        anchors.bottom: tabDelegate.bottom;
        anchors.horizontalCenter: parent.horizontalCenter;
        anchors.bottomMargin: appMain.sizes.margin / 1.6;

        opacity: tabDelegate.activeFocus ? 1.0 : appMain.config.inactiveOpacity;
		color: fit.isDark ? appMain.theme.dark.textColor : appMain.theme.light.textColor;
		text: model.title[fit.lang];
 		font: Font {
			  family: "Proxima Nova Condensed";
			  pixelSize: 28;
              black: true;
		}
	}

    Rectangle {
        id: badge;
        anchors.top: tabDelegate.top;
        anchors.right: tabDelegate.right;
        anchors.rightMargin: -(badge.width / 2);

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

