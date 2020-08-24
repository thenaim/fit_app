import "NutritionDelegate.qml";

GridView {
    id: nutritionItemsList;
    z:1;

    cellWidth: appMain.sizes.nutrition.width;
    cellHeight: appMain.sizes.nutrition.height + 40;
    
	opacity: activeFocus ? 1.0 : appMain.config.inactiveOpacity;
    focus: true;
    clip: true;
    delegate: NutritionDelegate {}
    model: ListModel { id: nutritionModel; }

    function getNutritions(day) {
        const stingray = JSON.parse(load("fit_stingray"));
        fit.loading = true;
        appMain.httpServer(appMain.tabs[3].url, "GET", { type: stingray.meal ? "muscle_building" : "weight_loss", day: day || 1 }, "getNutritions", (nutritions) => {
            nutritionItemsList.nutritionModel.reset();
            if (nutritions.length) {

                nutritions.forEach((nut, index) => {
					let indexNut = parseInt(index);
					let myNut = {
                        id: nut["id"],
                        name: nut["name"],
                        steps: nut["steps"],
                        ingredients: nut["ingredients"],
                        bookmark: nut["bookmark"],
                        image: nut["image"], //.split(".")[0]
						type: ""
                    };


					if (nut["type"] === "muscle_building") {
						if (indexNut === 0 || indexNut === 1) {
							myNut["type"] = "Завтрак";
						}
						if (indexNut === 2 || indexNut === 3) {
							myNut["type"] = "Обед";
						}
						if (indexNut === 4 || indexNut === 5) {
							myNut["type"] = "Ужин";
						}
					}

					if (nut["type"] === "weight_loss") {
						if (indexNut === 0) {
							myNut["type"] = "Завтрак";
						}
						if (indexNut === 1 || indexNut === 2) {
							myNut["type"] = "Обед";
						}
						if (indexNut === 3 || indexNut === 4) {
							myNut["type"] = "Ужин";
						}
					}
                    nutritionItemsList.nutritionModel.append(myNut);
                });
            };

            fit.loading = false;
        });
    }

    /**
    * GridView nutritionHighlight
    */
	property Color highlightColor: appMain.theme.light.background;

	Rectangle {
		id: highlight;
        z: 2;

        width: nutritionItemsList.cellWidth - 5;
        height: nutritionItemsList.cellHeight - 5;

        visible: nutritionItemsList.count && !parent.activeFocus;

		opacity: 0.2;
		color: nutritionItemsList.highlightColor;
        radius: appMain.sizes.radius;

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
