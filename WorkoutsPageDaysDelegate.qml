import "js/app.js" as app;

Rectangle {
    id: workoutsPageDayDelegate;
	z: 1;

    width: parent.cellWidth - 5;
    height: parent.cellHeight - 5;

    opacity: activeFocus ? 1.0 : app.config.inactiveOpacity;
    color: fit.isDark ? app.theme.dark.layout_background : app.theme.light.layout_background;
    radius: app.sizes.radius;
    focus: true;

	Text {
		id: workoutDayText;
        opacity: workoutsPageDayDelegate.activeFocus ? 1.0 : app.config.inactiveOpacity;

        anchors.centerIn: workoutsPageDayDelegate;

		color: fit.isDark ? app.theme.dark.textColor : app.theme.light.textColor;
		text: model.title;
 		font: Font {
			  family: "Proxima Nova Condensed";
			  pixelSize: 28;
              black: true;
		}
	}
}

