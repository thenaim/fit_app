import "js/app.js" as app;

Rectangle {
    id: statsBarDelegate;
    z: 1;
    height: 50;
    width: parent.width;
    opacity: 1.0;
    color: fit.isDark ? app.theme.dark.item_background : app.theme.light.item_background;
    focus: false;

    Text {
		id: daysTabText;
        anchors.top: parent.top;
        anchors.horizontalCenter: statsBarDelegate.horizontalCenter;
        opacity: 1.0;

		color: fit.isDark ? app.theme.dark.textColor : app.theme.light.textColor;

		text: model.line;

 		font: Font {
			  family: "Times";
			  pixelSize: 28;
              black: true;
		}
	}
}



