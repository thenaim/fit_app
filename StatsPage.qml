import "StatsPageBarDelegate.qml";
import "StatsPageBarChartsDelegate.qml";
import "StatsPageBarLinesDelegate.qml";

import "js/app.js" as app;

Item {
    id: statsPage;

    /**
    * Stats page title
    */
	Text {
		id: statText;
        opacity: 1.0;

        anchors.bottom: centeredStat.top;

        anchors.bottomMargin: app.sizes.margin;
        anchors.horizontalCenter: parent.horizontalCenter;

		color: fit.isDark ? app.theme.dark.textColor : app.theme.light.textColor;

		text: "Статистика активности и баллы";

 		font: Font {
			  family: "Times";
			  pixelSize: 36;
              black: true;
		}
	}

    /**
    * Chart Bar container
    */
    Rectangle {
        id: centeredStat;
        anchors.top: statText.bottom;
        anchors.centerIn: parent;
        color: fit.isDark ? app.theme.dark.layout_background : app.theme.light.layout_background;

        width: 960;
        height: 352;

        /**
        * Chart Bar lines
        */
        ListView {
            id: barRightLines;
            anchors.top: centeredStat.top;
            anchors.left: centeredStat.left;
            anchors.bottom: centeredStat.bottom;
            width: 960;
            spacing: 48;
            height: 2;

            model: ListModel {}

            delegate: StatsPageBarLinesDelegate {}

            onCompleted: {
                for (let line = 1; line <= 10; line++) {
                    model.append({});
                }
            }
        }

        /**
        * Chart Bars
        */
        ListView {
            id: barCharts;
            z: 2;
            orientation: mainWindow.horizontal;
            anchors.top: centeredStat.top;
            anchors.left: centeredStat.left;
            anchors.right: centeredStat.right;
            anchors.bottom: centeredStat.bottom;
            spacing: 20;
            height: 350;

            model: ListModel {}

            delegate: StatsPageBarChartsDelegate {}
        }

        /**
        * Chart Bar right length
        */
        ListView {
            id: barRight;
            anchors.top: centeredStat.top;
            anchors.left: centeredStat.right;
            anchors.topMargin: -10;
            width: 50;
            height: 370;
            focus: true;
            clip: true;

            model: ListModel {}

            delegate: StatsPageBarDelegate {}

            onCompleted: {
                const points = [350, 300, 250, 200, 150, 100, 50, 0];
                points.forEach((point) => {
                    model.append({ line: point });
                });
            }
        }
    }

    function getStats() {
        app.httpServer(app.config.api.stingray, "GET", {}, "appInit", (data) => {
            if (!data.id) return callback(false);

            if (data.stats.length) {
                barCharts.model.reset();
        
                data.stats.forEach((stat) => {
                    barCharts.model.append(stat);
                });
            }
        });
    }

    onVisibleChanged: {}
}