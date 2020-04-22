import "js/app.js" as app;

Rectangle {
    id: barChartsDelegate;
    z: 1;
    anchors.bottom: centeredStat.bottom;
    height: model.points >= 350 ? 350 : model.points === 0 ? 1 : model.points;
    width: 176;
    color: model.colors;
    opacity: barChartsDelegate.activeFocus ? 1.0 : app.config.inactiveOpacity;
    focus: true;

    Behavior on height { animation: Animation { duration: 1500; } }
    Behavior on width { animation: Animation { duration: 150; } }

    Text {
		id: barChartsPoint;
        anchors.top: parent.top;
        anchors.topMargin: -(app.sizes.margin + 4);
        anchors.horizontalCenter: barChartsDelegate.horizontalCenter;
        opacity: barChartsDelegate.activeFocus ? 1.0 : app.config.inactiveOpacity;

		color: fit.isDark ? app.theme.dark.textColor : app.theme.light.textColor;

		text: model.points;

 		font: Font {
			  family: "Proxima Nova Condensed";
			  pixelSize: 26;
              black: true;
		}
	}

    Text {
		id: barChartsPoint;
        anchors.top: barChartsDelegate.bottom;
        anchors.topMargin: app.sizes.margin / 2;
        anchors.horizontalCenter: barChartsDelegate.horizontalCenter;
        opacity: barChartsDelegate.activeFocus ? 1 : 0.9;

		color: fit.isDark ? app.theme.dark.textColor : app.theme.light.textColor;

		text: model.name;

 		font: Font {
			  family: "Proxima Nova Condensed";
			  pixelSize: 22;
              black: true;
		}
	}
}
