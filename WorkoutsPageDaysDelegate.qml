import "js/app.js" as appMain;

Rectangle {
    id: workoutsPageDayDelegate;
	z: 1;

    width: parent.cellWidth - 5;
    height: parent.cellHeight - 5;

    opacity: activeFocus ? 1.0 : appMain.config.inactiveOpacity;
    color: fit.isDark ? appMain.theme.dark.layout_background : appMain.theme.light.layout_background;
    radius: appMain.sizes.radius;
    focus: true;

	Text {
		id: workoutDayText;
        anchors.centerIn: workoutsPageDayDelegate;

        opacity: workoutsPageDayDelegate.activeFocus ? 1.0 : appMain.config.inactiveOpacity;
		color: fit.isDark ? appMain.theme.dark.textColor : appMain.theme.light.textColor;
		text: model.title;
 		font: Font {
			  family: "Proxima Nova Condensed";
			  pixelSize: 28;
              black: true;
		}
	}
}

