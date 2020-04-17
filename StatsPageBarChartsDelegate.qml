import "js/app.js" as app;

Rectangle {
    id: barCharts;
    anchors.bottom: centeredStat.bottom;
    height: model.points >= 350 ? +barCharts.height : model.points === 0 ? 1 : model.points;
    width: 176;
    opacity: 0.4;
    color: model.colors;

    Text {
		id: barChartsPoint;
        anchors.top: parent.top;
        anchors.topMargin: -(app.sizes.margin + 4);
        anchors.horizontalCenter: barCharts.horizontalCenter;
        opacity: 1.0;

		color: fit.isDark ? app.theme.dark.textColor : app.theme.light.textColor;

		text: model.points;

 		font: Font {
			  family: "Times";
			  pixelSize: 26;
              black: true;
		}
	}

    Text {
		id: barChartsPoint;
        anchors.top: barCharts.bottom;
        anchors.topMargin: app.sizes.margin / 2;
        anchors.horizontalCenter: barCharts.horizontalCenter;
        opacity: 1.0;

		color: fit.isDark ? app.theme.dark.textColor : app.theme.light.textColor;

		text: model.name;

 		font: Font {
			  family: "Times";
			  pixelSize: 22;
              black: true;
		}
	}
}
