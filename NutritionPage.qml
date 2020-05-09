import "js/app.js" as app;
import "NutritionDaysDelegate.qml";
import "NutritionItems.qml";

Item {
    id: nutritionPage;
	z: 1;

    anchors.top: nutritionPageContainer.top;
    anchors.left: nutritionPageContainer.left;
    anchors.right: nutritionPageContainer.right;
    anchors.bottom: nutritionPageContainer.bottom;

    opacity: 1.0;

    /**
    * Day Cards
    */
    ListView {
        id: nutritionDays;
        // get main container width, then divided to tab length
        // will be responsive card
        property string daysCardWidth: (mainView.width) / 7;

        anchors.top: nutritionPage.top;
        anchors.left: nutritionPage.left;
        anchors.right: nutritionPage.right;
        anchors.margins: -app.sizes.margin;
        orientation: mainWindow.horizontal;
        opacity: 1.0;

        height: fit.fullscreen ? 70 : 50;
        width: daysCardWidth;
        focus: true;
        clip: true;
        model: ListModel {}
        delegate: NutritionDaysDelegate {}

        onCompleted: {
            for (let day = 1; day <= 7; day++) {
                model.append( { day: day, title: day });
            }
        }

        onUpPressed: {
            tab.setFocus();
        }

        onDownPressed: {
            const dayCurrent = {
                index: nutritionDays.currentIndex,
                data: nutritionDays.model.get(nutritionDays.currentIndex)
            };
            nutritionItemsList.getNutritions(dayCurrent.data.day);
            nutritionItemsList.setFocus();
        }

        onSelectPressed: {
            const dayCurrent = {
                index: nutritionDays.currentIndex,
                data: nutritionDays.model.get(nutritionDays.currentIndex)
            };
            nutritionItemsList.getNutritions(dayCurrent.data.day);
            nutritionItemsList.setFocus();
        }

        // ListView tabDaysHighlight
        property int hlWidth: nutritionDays.daysCardWidth;
        property int hlHeight: 4;
        property Color highlightColor: app.theme.light.background;

        // Highlight back (line)
        Rectangle {
            id: tabDaysHighlightBack;
            anchors.bottom: nutritionDays.bottom;
            anchors.left: nutritionDays.left;
            anchors.right: nutritionDays.right;
            color: fit.isDark ? app.theme.dark.layout_background : app.theme.light.layout_background;

            height: nutritionDays.hlHeight;
            visible: true;
            z: 2;
            opacity: 0.8;
        }
    
        // Highlight front
        Rectangle {
            id: tabDaysHighlight;
            color: nutritionDays.highlightColor;
            anchors.top: tabDaysHighlightBack.top;
            anchors.bottom: nutritionDays.bottom;
            visible: true;
            z: 3;
            opacity: nutritionDays.activeFocus && nutritionDays.count ? 0.8 : 0.2;

            doHighlight: {
                if (!nutritionDays || !nutritionDays.model || !nutritionDays.count)
                    return;

                var futurePos = nutritionDays.getPositionViewAtIndex(nutritionDays.currentIndex, nutritionDays.positionMode);
                var itemRect = nutritionDays.getItemRect(nutritionDays.currentIndex);

                itemRect.Move(-futurePos.X, -futurePos.Y);

                if (nutritionDays.hlHeight) {
                    this.height = nutritionDays.hlHeight;
                    this.y = itemRect.Top;
                }

                if (nutritionDays.hlWidth) {
                    this.width = nutritionDays.hlWidth;
                    this.x = itemRect.Left;
                }
            }

            updateHighlight: {
                if (nutritionDays.visible) {
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
    * Nutrition Items
    */
    NutritionItems {
        id: nutritionItems;

        anchors.top: nutritionDays.bottom;
        anchors.left: nutritionPage.left;
        anchors.right: nutritionPage.right;
        anchors.bottom: nutritionPage.bottom;
        anchors.topMargin: app.sizes.margin / 2;

        opacity: 1.0;

        onKeyPressed: {
            if (key === "Up") {
                nutritionDays.setFocus();
            } else if (key === "Red") {
                let current = model.get(nutritionItems.currentIndex);
                app.addToBookmark(current, "nutrition", "main");
            } else if (key === "Select") {
                const currentNutritionItem = model.get(nutritionItems.currentIndex);
                
                nutritionDetail.page = "main";

                nutritionDetail.id = currentNutritionItem.id;
                nutritionDetail.day = nutritionDays.model.get(nutritionDays.currentIndex).day;
                nutritionDetail.name = currentNutritionItem.name;
                nutritionDetail.steps = currentNutritionItem.steps;
                nutritionDetail.ingredients = currentNutritionItem.ingredients;
                nutritionDetail.image = currentNutritionItem.image;

                nutritionPage.visible = false;
                nutritionDetail.visible = true;
                nutritionDetail.setFocus();

                // stats
                app.httpServer(app.config.api.stats, "GET", { type: "nutrition" }, "statsNutrition", () => {});
            }
        }
    }
}