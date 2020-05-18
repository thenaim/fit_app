Rectangle {
    id: daysDelegate;
    z: 1;
    height: parent.height;
    width: parent.daysCardWidth;
    opacity: 1.0;
    color: fit.isDark ? appMain.theme.dark.item_background : appMain.theme.light.item_background;
    radius: fit.fullscreen ? 0 : appMain.sizes.radius;
    focus: true;

    Text {
		id: daysTabText;
        anchors.centerIn: parent;

        opacity: daysDelegate.activeFocus ? 1.0 : appMain.config.inactiveOpacity;
		color: fit.isDark ? appMain.theme.dark.textColor : appMain.theme.light.textColor;
		text: appLangs.texts[fit.lang].day + " " + model.title;
 		font: Font {
			  family: "Proxima Nova Condensed";
			  pixelSize: fit.fullscreen ? 34 : 28;
              black: true;
		}
	}
}



