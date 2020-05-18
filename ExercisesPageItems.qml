import "ExerciseDelegate.qml";

ListView {
	id: exerciseItemsList;
	z: 1;
	orientation: exercisesCategory.horizontal;

	spacing: 10;
	height: appMain.sizes.exercise.height + 100;
	opacity: 1;
	focus: true;
	clip: true;
	delegate: ExerciseDelegate {}
	model: ListModel { id: exerciseItemModel; }

	function getExercises(id_type) {
		fit.loading = true;
        appMain.httpServer(appMain.config.api.exercises, "GET", { id_type: id_type }, "getExercises", (exercise) => {
            // reset model
            exerciseItemsList.exerciseItemModel.reset();

            if (exercise.length) {
                exercise.forEach((vid) => {
                    // append to model
                    exerciseItemsList.exerciseItemModel.append({
                        id: vid["id"],
                        title: vid["name"],
                        description: vid["text"],
                        bookmark: vid["bookmark"],
                        images: vid["images"]
                    });
                });
            }

    		fit.loading = false;
        });
    }


	/**
	* ListView exerciseHighlight
	*/
	property int hlWidth: appMain.sizes.exercise.width;
	property int hlHeight: appMain.sizes.exercise.height + 100;
	property Color highlightColor: appMain.theme.light.background;

	Rectangle {
		id: exerciseHighlight;
		z: 2;
		color: exerciseItemsList.highlightColor;
		opacity: exerciseItemsList.activeFocus ? 0.2 : 0.1;
		visible: false;

		doHighlight: {
			if (!exerciseItemsList || !exerciseItemsList.model || !exerciseItemsList.count)
				return;

			var futurePos = exerciseItemsList.getPositionViewAtIndex(exerciseItemsList.currentIndex, exerciseItemsList.positionMode);
			var itemRect = exerciseItemsList.getItemRect(exerciseItemsList.currentIndex);

			itemRect.Move(-futurePos.X, -futurePos.Y);

			if (exerciseItemsList.hlHeight) {
				this.height = exerciseItemsList.hlHeight;
				this.y = itemRect.Top;
			}

			if (exerciseItemsList.hlWidth) {
				this.width = exerciseItemsList.hlWidth;
				this.x = itemRect.Left;
			}
		}

		updateHighlight: {
			if (exerciseItemsList.visible) {
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

		// Behavior on height { animation: Animation { duration: 200; } }
	}

	Timer {	//TODO: Remove this when GetItemRect will work correctly.
		id: crunchTimer;
		interval: 200;
		repeat: false;
		running: false;

		onTriggered: {
			exerciseHighlight.doHighlight();
			this.stop();
		}
	}

	onActiveFocusChanged: {
		if (activeFocus)
			exerciseHighlight.updateHighlight();
	}

	resetHighlight: {
		exerciseHighlight.x = 0;
		highlightXAnim.complete();
		exerciseHighlight.y = 0;
		highlightYAnim.complete();
	}

	onVisibleChanged: {
		if (visible)
			this.resetHighlight();
	}

	onCountChanged:			{ if (count == 1) exerciseHighlight.updateHighlight(); }	// Call on first element added.
	onWidthChanged: 		{ exerciseHighlight.updateHighlight(); }
	onHeightChanged: 		{ exerciseHighlight.updateHighlight(); }
	onCurrentIndexChanged:	{ exerciseHighlight.updateHighlight(); }
}