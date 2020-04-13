import "js/app.js" as app;
import "StatsPageBarDelegate.qml";
import "StatsPageBarLinesDelegate.qml";

Item {
    id: statsPage;

    z: 1;

	Text {
		id: statText;
        opacity: 1.0;

        anchors.top: statsPage.top;
        anchors.horizontalCenter: parent.horizontalCenter;
        // anchors.topMargin: app.sizes.margin / 2;

		color: fit.isDark ? app.theme.dark.textColor : app.theme.light.textColor;

		text: "Статистика активности";

 		font: Font {
			  family: "Times";
			  pixelSize: 36;
              black: true;
		}
	}

    Rectangle {
        id: centeredStat;
        anchors.top: parent.top;
        color: fit.isDark ? app.theme.dark.layout_background : app.theme.light.layout_background;
        anchors.centerIn: statsPage;

        width: 960;
        height: 350;

        ListView {
            id: barRightLines;
            anchors.top: centeredStat.top;
            anchors.left: centeredStat.left;
            anchors.bottom: centeredStat.bottom;
            width: 960;
            spacing: 68;
            height: 2;

            model: ListModel {}

            delegate: StatsPageBarLinesDelegate {}

            onCompleted: {
                for (let day = 1; day <= 10; day++) {
                    model.append( { day: day });
                }
            }
        }

        ListView {
            id: barRight;
            anchors.top: centeredStat.top;
            anchors.left: centeredStat.right;
            anchors.topMargin: -10;
            width: 50;
            height: 420;
            focus: true;

            model: ListModel {}

            delegate: StatsPageBarDelegate {}

            onCompleted: {
                const points = [500, 400, 300, 200, 100, 0];
                points.forEach((point) => {
                    model.append({ line: point });
                });
            }
        }
    }

    onVisibleChanged: {}
}