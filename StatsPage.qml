import "js/app.js" as app;
import "js/languages.js" as appLangs;

import "StatsPageBarDelegate.qml";
import "StatsPageBarChartsDelegate.qml";
import "StatsPageBarLinesDelegate.qml";


Item {
    id: statsPage;
    z: 1;
    opacity: 1.0;

    /**
    * Stats page title
    */
	Text {
		id: statText;

        anchors.bottom: centeredStat.top;

        anchors.bottomMargin: app.sizes.margin;
        anchors.horizontalCenter: parent.horizontalCenter;

		color: fit.isDark ? app.theme.dark.textColor : app.theme.light.textColor;

		text: appLangs.texts[fit.lang].statsTitile;

 		font: Font {
			  family: "Proxima Nova Condensed";
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

        opacity: 1.0;

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
            focus: false;
            opacity: 1.0;

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
            orientation: mainWindow.horizontal;
            anchors.top: centeredStat.top;
            anchors.left: centeredStat.left;
            anchors.right: centeredStat.right;
            anchors.bottom: centeredStat.bottom;
            spacing: 20;
            height: 350;

            focus: true;

            model: ListModel {}

            delegate: StatsPageBarChartsDelegate {}

            onUpPressed: {
                tab.setFocus();
            }
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
            focus: false;
            clip: true;
            opacity: 1.0;

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
        fit.loading = true;
        app.httpServer(app.config.api.stingray, "GET", {}, "appInit", (data) => {
            if (!data.id) return callback(false);

            if (data.stats.length) {
                barCharts.model.reset();
        
                data.stats.forEach((stat) => {
                    barCharts.model.append(stat);
                });
                barCharts.setFocus();
            }
            fit.loading = false;
        });
    }

    // onVisibleChanged: {}
}