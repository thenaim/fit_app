Rectangle {
    id: workoutsPageCategoryDelegate;
	z: 1;

    width: parent.cellWidth - 5;
    height: parent.cellHeight - 5;

    opacity: activeFocus ? 1.0 : appMain.config.inactiveOpacity;
    color: fit.isDark ? appMain.theme.dark.layout_background : appMain.theme.light.layout_background;
    radius: appMain.sizes.radius;
    focus: true;

    Image {
        id: workoutCategoryImage;
        anchors.top: workoutsPageCategoryDelegate.top;
        anchors.horizontalCenter: workoutsPageCategoryDelegate.horizontalCenter;
        anchors.topMargin: appMain.sizes.margin;

        opacity: 1.0;
        height: 100;
        // width: 100;
        registerInCacheSystem: false;
        async: false;
        fillMode: PreserveAspectFit;
        source: "apps/fit_app/res/workouts/" + model.image + ".png";

        Behavior on width  { animation: Animation { duration: appMain.config.animationDuration; } }
        Behavior on height { animation: Animation { duration: appMain.config.animationDuration; } }
    }

	Text {
		id: workoutCategoryText;
        anchors.bottom: workoutsPageCategoryDelegate.bottom;
        anchors.horizontalCenter: workoutsPageCategoryDelegate.horizontalCenter;
        anchors.bottomMargin: appMain.sizes.margin;

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

