import "NutritionDelegate.qml";

import "js/app.js" as app;

GridView {
    id: nutritionItemsList;
    z:1;

    property bool loading: false;

    cellWidth: app.sizes.nutrition.width;
    cellHeight: app.sizes.nutrition.height;

    visible: !loading;

    focus: true;
    clip: true;

    delegate: NutritionDelegate {}

    model: ListModel { id: nutritionModel; }

    function getNutritions(day) {
        fit.loading = true;

        app.httpServer(app.tabs[2].url, "GET", { type: "muscle_building", day: day || 1 }, "getNutritions", (nutritions) => {
            nutritionItemsList.nutritionModel.reset();
            if (nutritions.data.length) {
                nutritions.data.forEach((nut) => {
                    nutritionItemsList.nutritionModel.append({
                        id: nut["id"],
                        name: nut["name"],
                        steps: nut["steps"],
                        ingredients: nut["ingredients"],
                        image: nut["image"] //.split(".")[0]
                    });
                });
            };

            fit.loading = false;
        });
    }

    Image {
        id: nutritionThemeLogo;
        z: 1;
        anchors.bottom: nutritionItemsList.bottom;
        anchors.horizontalCenter: nutritionItemsList.horizontalCenter;

        opacity: 0.1;
        height: 300;

        registerInCacheSystem: false;
        async: false;
        fillMode: PreserveAspectFit;

        source: "apps/fit_app/res/video_page_" + (fit.isDark ? "dark.png" : "light.png");

        Behavior on width  { animation: Animation { duration: app.config.animationDuration; } }
        Behavior on height { animation: Animation { duration: app.config.animationDuration; } }
    }




    /**
    * GridView nutritionHighlight
    */
	property Color highlightColor: app.theme.light.background;

	Rectangle {
		id: highlight;
        z: 2;

        width: app.sizes.nutrition.width;
        height: app.sizes.nutrition.height;

        visible: nutritionItemsList.count;

		opacity: parent.activeFocus && nutritionItemsList.count ? 0.4 : 0.2;
		color: nutritionItemsList.highlightColor;
        radius: app.sizes.radius;

		updateHighlight: {
			this.doHighlight();
			crunchTimer.restart();
		}

		doHighlight: {
			if (!nutritionItemsList.model || !nutritionItemsList.model.count)
				return;

			var futurePos = nutritionItemsList.getPositionViewAtIndex(nutritionItemsList.currentIndex, nutritionItemsList.positionMode);
			var itemRect = nutritionItemsList.getItemRect(nutritionItemsList.currentIndex);
			itemRect.Move(-futurePos.X, -futurePos.Y);

			highlightXAnim.complete();
			highlightYAnim.complete();
			this.y = itemRect.Top;
			this.x = itemRect.Left;
			this.height = 255;
			this.width =  280;
			if (this.y != itemRect.Top && this.x != itemRect.Left) {
				highlightXAnim.complete();
				highlightYAnim.complete();
			}
		}

		Behavior on y {
			id: highlightYAnim;
			animation: Animation {
				duration: 250;
			}
		}

		Behavior on x {
			id: highlightXAnim;
			animation: Animation {
				duration: 250;
			}
		}

		Behavior on width {
			animation: Animation {
				duration: 250;
			}
		}

		Behavior on height {
			animation: Animation {
				duration: 250;
			}
		}

		Behavior on opacity { animation: Animation { duration: 300; } }
	}

	Timer {	//TODO: Remove this when GetItemRect will work correctly.
		id: crunchTimer;
		interval: 200;
		repeat: false;
		running: false;

		onTriggered: {
			highlight.doHighlight();
			this.stop();
		}
	}

	onContentHeightChanged:	{ highlight.updateHighlight(); }
	onContentWidthChanged:	{ highlight.updateHighlight(); }
	onCurrentIndexChanged:	{ highlight.updateHighlight(); }
	onCountChanged:			{ highlight.updateHighlight(); }
}
