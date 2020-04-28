import "NutritionDelegate.qml";

import "js/app.js" as app;

GridView {
    id: nutritionItemsList;
    z:1;

    property bool loading: false;

    cellWidth: app.sizes.nutrition.width;
    cellHeight: app.sizes.nutrition.height + 40;

    visible: !loading;

    focus: true;
    clip: true;

    delegate: NutritionDelegate {}

    model: ListModel { id: nutritionModel; }

    function getNutritions(day) {
        const stingray = JSON.parse(load("fit_stingray"));
        fit.loading = true;
        app.httpServer(app.tabs[2].url, "GET", { type: stingray.meal ? "muscle_building" : "weight_loss", day: day || 1 }, "getNutritions", (nutritions) => {
            nutritionItemsList.nutritionModel.reset();
            if (nutritions.length) {
                nutritions.forEach((nut) => {
                    nutritionItemsList.nutritionModel.append({
                        id: nut["id"],
                        name: nut["name"],
                        steps: nut["steps"],
                        ingredients: nut["ingredients"],
                        bookmark: nut["bookmark"],
                        image: nut["image"] //.split(".")[0]
                    });
                });
            };

            fit.loading = false;
        });
    }

    /**
    * GridView nutritionHighlight
    */
	property Color highlightColor: app.theme.light.background;

	Rectangle {
		id: highlight;
        z: 2;

        width: nutritionItemsList.cellWidth - 5;
        height: nutritionItemsList.cellHeight - 5;

        visible: nutritionItemsList.count;

		opacity: parent.activeFocus && nutritionItemsList.count ? 0.2 : 0.1;
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
