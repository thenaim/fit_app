import "js/app.js" as appMain;
import "js/languages.js" as appLangs;

import "StatsPageTypeDelegate.qml";
import "StatsPageLeaderboardDelegate.qml";
import "StatsPageBarDelegate.qml";
import "StatsPageBarChartsDelegate.qml";
import "StatsPageBarLinesDelegate.qml";


Item {
    id: statsPage;
    z: 1;
    opacity: 1.0;

    /**
    * Day Cards
    */
    ListView {
        id: statsTypeTab;
        // get main container width, then divided to tab length
        // will be responsive card
        property string daysCardWidth: (mainView.width) / statsTypeTab.count;

        anchors.top: statsPage.top;
        anchors.left: statsPage.left;
        anchors.right: statsPage.right;
        anchors.margins: -appMain.sizes.margin;
        orientation: mainWindow.horizontal;
        opacity: 1.0;

        height: fit.fullscreen ? 70 : 50;
        width: daysCardWidth;
        focus: true;
        clip: true;
        model: ListModel {}
        delegate: StatsPageTypeDelegate {}

        onCompleted: {
            appMain.statsTypes.forEach((tab) => {
                model.append(tab);
            });
        }

        onKeyPressed: {
            const statsCurrent = statsTypeTab.model.get(statsTypeTab.currentIndex);
            if (key === "Up") {
                tab.setFocus();
            } else if (key === "Down" || key === "Select") {
                statsPage.onTabChange();
                statsPage.getStats();
            }
        }

        // ListView tabDaysHighlight
        property int hlWidth: statsTypeTab.daysCardWidth;
        property int hlHeight: 4;
        property Color highlightColor: appMain.theme.light.background;

        // Highlight back (line)
        Rectangle {
            id: tabDaysHighlightBack;
            anchors.bottom: statsTypeTab.bottom;
            anchors.left: statsTypeTab.left;
            anchors.right: statsTypeTab.right;
            color: fit.isDark ? appMain.theme.dark.layout_background : appMain.theme.light.layout_background;

            height: statsTypeTab.hlHeight;
            visible: true;
            z: 2;
            opacity: 0.8;
        }
    
        // Highlight front
        Rectangle {
            id: tabDaysHighlight;
            color: statsTypeTab.highlightColor;
            anchors.top: tabDaysHighlightBack.top;
            anchors.bottom: statsTypeTab.bottom;
            visible: true;
            z: 3;
            opacity: statsTypeTab.activeFocus && statsTypeTab.count ? 0.8 : 0.2;

            doHighlight: {
                if (!statsTypeTab || !statsTypeTab.model || !statsTypeTab.count)
                    return;

                var futurePos = statsTypeTab.getPositionViewAtIndex(statsTypeTab.currentIndex, statsTypeTab.positionMode);
                var itemRect = statsTypeTab.getItemRect(statsTypeTab.currentIndex);

                itemRect.Move(-futurePos.X, -futurePos.Y);

                if (statsTypeTab.hlHeight) {
                    this.height = statsTypeTab.hlHeight;
                    this.y = itemRect.Top;
                }

                if (statsTypeTab.hlWidth) {
                    this.width = statsTypeTab.hlWidth;
                    this.x = itemRect.Left;
                }
            }

            updateHighlight: {
                if (statsTypeTab.visible) {
                    this.doHighlight();
                    crunchTimer.restart();
                }
            }

            Behavior on color { animation: Animation { duration: 300; } }

            Behavior on x {
                id: highlightXAnim;
                animation: Animation {
                    duration: 200;
                }
            }

            Behavior on height { animation: Animation { duration: 200; } }
        }

        Timer {	//TODO: Remove this when GetItemRect will work correctly.
            id: crunchTimer;
            interval: 200;
            repeat: false;
            running: false;

            onTriggered: {
                tabDaysHighlight.doHighlight();
                this.stop();
            }
        }

        onActiveFocusChanged: {
            if (activeFocus)
                tabDaysHighlight.updateHighlight();
        }

        resetHighlight: {
            tabDaysHighlight.x = 0;
            highlightXAnim.complete();
            tabDaysHighlight.y = 0;
            highlightYAnim.complete();
        }

        onVisibleChanged: {
            if (visible)
                this.resetHighlight();
        }

        onCountChanged:			{ if (count == 1) tabDaysHighlight.updateHighlight(); }	// Call on first element added.
        onWidthChanged: 		{ tabDaysHighlight.updateHighlight(); }
        onHeightChanged: 		{ tabDaysHighlight.updateHighlight(); }
        onCurrentIndexChanged:	{ tabDaysHighlight.updateHighlight(); }
    }

    /**
    * Chart Bar container
    */
    Rectangle {
        id: centeredStat;
        anchors.centerIn: parent;

        color: fit.isDark ? appMain.theme.dark.layout_background : appMain.theme.light.layout_background;
        width: 960;
        height: 352;
        opacity: 1.0;
        visible: true;

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
                statsTypeTab.setFocus();
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

    /**
    * Leaderboard
    */
    Rectangle {
        id: centeredStatTopusers;
        anchors.centerIn: parent;

        color: fit.isDark ? appMain.theme.dark.layout_background : appMain.theme.light.layout_background;
		radius: appMain.sizes.radius;
        width: 600;
        height: 330;
        opacity: 1.0;
        visible: false;

        Rectangle {
            id: placeText;
            anchors.top: centeredStatTopusers.top;
            anchors.left: centeredStatTopusers.left;

            color: parent.color;
		    radius: appMain.sizes.radius;
            width: 100;
            height: 50;
            opacity: 1.0;
            visible: true;

            Text {
                anchors.centerIn: parent;

                color: fit.isDark ? appMain.theme.dark.textColor : appMain.theme.light.textColor;
                text: appLangs.texts[fit.lang].place;
                font: Font {
                    family: "Proxima Nova Condensed";
                    pixelSize: 30;
                    black: true;
                }
            }
        }

        Rectangle {
            id: idText;
            anchors.top: centeredStatTopusers.top;
            anchors.left: placeText.right;

            color: parent.color;
		    radius: appMain.sizes.radius;
            width: 250;
            height: 50;
            opacity: 1.0;
            visible: true;

            Text {
                anchors.centerIn: parent;

                color: fit.isDark ? appMain.theme.dark.textColor : appMain.theme.light.textColor;
                text: "ID";
                font: Font {
                    family: "Proxima Nova Condensed";
                    pixelSize: 30;
                    black: true;
                }
            }
        }

        Rectangle {
            id: pointsText;
            anchors.top: centeredStatTopusers.top;
            anchors.left: idText.right;

		    radius: appMain.sizes.radius;
            color: parent.color;
            width: 250;
            height: 50;
            opacity: 1.0;
            visible: true;

            Text {
                anchors.centerIn: parent;

                color: fit.isDark ? appMain.theme.dark.textColor : appMain.theme.light.textColor;
                text: appLangs.texts[fit.lang].points;
                font: Font {
                    family: "Proxima Nova Condensed";
                    pixelSize: 30;
                    black: true;
                }
            }
        }

        ListView {
            id: leaderboard;
            anchors.top: centeredStatTopusers.top;
            anchors.left: centeredStatTopusers.left;
            anchors.right: centeredStatTopusers.right;
            anchors.bottom: centeredStatTopusers.bottom;

            width: 600;
            height: 50;
            focus: true;
            clip: true;
            opacity: 1.0;
	        spacing: 5;

            model: ListModel {}
            delegate: StatsPageLeaderboardDelegate {}
            onUpPressed: {
                statsTypeTab.setFocus();
            }
        }
    }

    function onTabChange() {
        const statsCurrent = statsTypeTab.model.get(statsTypeTab.currentIndex);
        centeredStat.visible = false;
        centeredStatTopusers.visible = false;
        if (statsCurrent.type === "dashboard") {
            centeredStat.visible = true;
            barCharts.setFocus();
        } else if (statsCurrent.type === "leaderboard") {
            centeredStatTopusers.visible = true;
            leaderboard.setFocus();
        }
    }

    function getStats() {
        fit.loading = true;
        appMain.httpServer(appMain.config.api.stingray, "GET", {}, "appInit", (data) => {
            if (!data.id) return callback(false);

            if (data.stats.length) {
                barCharts.model.reset();
        
                data.stats.forEach((stat) => {
                    barCharts.model.append(stat);
                });
            }

            if (data.leaderboard.length) {
                leaderboard.model.reset();
            
                data.leaderboard.forEach((leader, index) => {
                    leader.place = index + 1;
                    leaderboard.model.append(leader);
                });
            }

            statsPage.onTabChange();
            fit.loading = false;
        });
    }
}