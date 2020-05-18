Rectangle {
    id: barChartsDelegate;
    z: 1;
    anchors.bottom: centeredStat.bottom;
    height: model.points >= 350 ? 350 : model.points === 0 ? 1 : model.points;
    width: 176;
    color: model.colors;
    opacity: barChartsDelegate.activeFocus ? 1.0 : appMain.config.inactiveOpacity;
    focus: true;

    Behavior on height { animation: Animation { duration: 1500; } }
    Behavior on width { animation: Animation { duration: 150; } }

    Text {
		id: barChartsPoint;
        anchors.top: parent.top;
        anchors.topMargin: -(appMain.sizes.margin + 4);
        anchors.horizontalCenter: barChartsDelegate.horizontalCenter;

        opacity: barChartsDelegate.activeFocus ? 1.0 : appMain.config.inactiveOpacity;
		color: fit.isDark ? appMain.theme.dark.textColor : appMain.theme.light.textColor;
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
        anchors.topMargin: appMain.sizes.margin / 2;
        anchors.horizontalCenter: barChartsDelegate.horizontalCenter;

        opacity: barChartsDelegate.activeFocus ? 1 : 0.9;
		color: fit.isDark ? appMain.theme.dark.textColor : appMain.theme.light.textColor;
		text: model.name[fit.lang];
 		font: Font {
			  family: "Proxima Nova Condensed";
			  pixelSize: 22;
              black: true;
		}
	}
}
