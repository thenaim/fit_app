import "js/app.js" as app;

Rectangle {
    id: workoutsPageCategoryDelegate;
	z: 1;

    width: parent.cellWidth - 5;
    height: parent.cellHeight - 5;

    opacity: activeFocus ? 1.0 : app.config.inactiveOpacity;
    color: fit.isDark ? app.theme.dark.layout_background : app.theme.light.layout_background;
    radius: app.sizes.radius;
    focus: true;

	Text {
		id: workoutCategoryText;
        opacity: workoutsPageCategoryDelegate.activeFocus ? 1.0 : app.config.inactiveOpacity;

        anchors.centerIn: workoutsPageCategoryDelegate;

		color: fit.isDark ? app.theme.dark.textColor : app.theme.light.textColor;
		text: model.categ_name;
 		font: Font {
			  family: "Proxima Nova Condensed";
			  pixelSize: 32;
              black: true;
		}
	}
}

