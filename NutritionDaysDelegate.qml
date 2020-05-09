import "js/app.js" as app;
import "js/languages.js" as appLangs;

Rectangle {
    id: daysDelegate;
    z: 1;
    height: parent.height;
    width: parent.daysCardWidth;
    opacity: 1.0;
    color: fit.isDark ? app.theme.dark.item_background : app.theme.light.item_background;
    radius: fit.fullscreen ? 0 : app.sizes.radius;
    focus: true;

    Text {
		id: daysTabText;
        anchors.centerIn: parent;

        opacity: daysDelegate.activeFocus ? 1.0 : app.config.inactiveOpacity;
		color: fit.isDark ? app.theme.dark.textColor : app.theme.light.textColor;
		text: appLangs.texts[fit.lang].day + " " + model.title;
 		font: Font {
			  family: "Proxima Nova Condensed";
			  pixelSize: fit.fullscreen ? 34 : 28;
              black: true;
		}
	}
}



