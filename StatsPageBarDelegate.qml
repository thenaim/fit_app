import "js/app.js" as appMain;

Rectangle {
    id: statsBarDelegate;
    z: 1;

    height: 50;
    width: parent.width;
    opacity: 1.0;
    color: fit.isDark ? appMain.theme.dark.item_background : appMain.theme.light.item_background;
    focus: false;

    Text {
		id: daysTabText;
        anchors.top: parent.top;
        anchors.horizontalCenter: statsBarDelegate.horizontalCenter;

        opacity: 1.0;
		color: fit.isDark ? appMain.theme.dark.textColor : appMain.theme.light.textColor;
		text: model.line;
 		font: Font {
			  family: "Proxima Nova Condensed";
			  pixelSize: 28;
              black: true;
		}
	}
}
