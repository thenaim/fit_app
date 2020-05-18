Rectangle {
    id: workoutsPageCategoryDelegate;
	z: 1;

    width: parent.cellWidth - 5;
    height: parent.cellHeight - 5;

    opacity: activeFocus ? 1.0 : appMain.config.inactiveOpacity;
    color: fit.isDark ? appMain.theme.dark.layout_background : appMain.theme.light.layout_background;
    radius: appMain.sizes.radius;
    focus: true;

	Text {
		id: workoutCategoryText;
        anchors.centerIn: workoutsPageCategoryDelegate;

        opacity: workoutsPageCategoryDelegate.activeFocus ? 1.0 : appMain.config.inactiveOpacity;
		color: fit.isDark ? appMain.theme.dark.textColor : appMain.theme.light.textColor;
		text: model.categ_name;
 		font: Font {
			  family: "Proxima Nova Condensed";
			  pixelSize: 32;
              black: true;
		}
	}
}

