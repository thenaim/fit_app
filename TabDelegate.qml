import "js/app.js" as app;

Rectangle {
    id: tabDelegate;
    opacity: 1.0;
    
    width: app.sizes.tabCards.width - 21;
    height: app.sizes.tabCards.height;

    anchors.topMargin: parent.isCurrentItem ? 50 : 0;
    radius: app.sizes.radius;

    color: fit.isDark ? app.theme.dark.item_background : app.theme.light.item_background;
    focus: true;

    Image {
        id: tabImage;
        opacity: 1.0;
        height: tabDelegate.activeFocus ? 55 : 50;

        anchors.top: tabDelegate.top;
        anchors.horizontalCenter: tabDelegate.horizontalCenter;
        anchors.topMargin: tabDelegate.activeFocus ? 15 : 25;

        registerInCacheSystem: false;
        async: false;
        fillMode: PreserveAspectFit;

        source: "apps/fit_app/res/" + model.id + "_" + (fit.isDark ? "dark.png" : "light.png");

        Behavior on width  { animation: Animation { duration: app.config.animationDuration; } }
        Behavior on height { animation: Animation { duration: app.config.animationDuration; } }
    }

	Text {
		id: tabText;
        opacity: tabDelegate.activeFocus ? 1.0 : app.config.inactiveOpacity;

        anchors.bottom: tabDelegate.bottom;
        anchors.horizontalCenter: parent.horizontalCenter;
        anchors.bottomMargin: app.sizes.margin / 1.2;

		color: fit.isDark ? app.theme.dark.textColor : app.theme.light.textColor;

		text: model.title;

 		font: Font {
			  family: "Times";
			  pixelSize: 30;
              black: true;
		}
	}
}

