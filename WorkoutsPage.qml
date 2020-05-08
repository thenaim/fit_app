import "WorkoutsPageCategoryDelegate.qml";
import "ExerciseDelegate.qml";

import "js/app.js" as app;
import "js/languages.js" as appLangs;

Item {
    id: workoutsPage;
    anchors.top: parent.top;
    anchors.left: parent.left;
    anchors.right: parent.right;
    anchors.bottom: parent.bottom;
    z: 1;
    opacity: activeFocus ? 1.0 : app.config.inactiveOpacity;
    focus: true;

    Item {
        id: categoryWorkout;
        anchors.top: workoutsPage.top;
        anchors.left: workoutsPage.left;
        anchors.right: workoutsPage.right;
        anchors.bottom: workoutsPage.bottom;

        Text {
            id: workoutCategoryText;
            z: 3;
            anchors.top: parent.top;
            anchors.horizontalCenter: parent.horizontalCenter;

            opacity: 1;
            color: fit.isDark ? app.theme.dark.textColor : app.theme.light.textColor;
            text: appLangs.texts[fit.lang].workoutByBodyType;
            visible: (fit.stingray["gender"] === "woman") && !workoutItems.visible;

            font: Font {
                family: "Proxima Nova Condensed";
                pixelSize: 34;
                black: true;
            }
        }

        /**
        * Workout Category Items
        */
        GridView {
            id: workoutCategoryItems;
            anchors.top: workoutCategoryText.bottom;
            anchors.left: parent.left;
            anchors.right: parent.right;
            anchors.bottom: parent.bottom;
            anchors.topMargin: fit.stingray["gender"] === "woman" ? app.sizes.margin : 0;
            z: 1;

            cellWidth: 350;
            cellHeight: 200;

            focus: true;
            clip: true;

            delegate: WorkoutsPageCategoryDelegate {}
            model: ListModel {}

            onUpPressed: {
                tab.setFocus();
            }

            onSelectPressed: {
                const workoutsCategoryCurrent = {
                    index: workoutCategoryItems.currentIndex,
                    data: workoutCategoryItems.model.get(workoutCategoryItems.currentIndex)
                };

                categoryWorkout.visible = false;
                workoutItems.visible = true;
                workoutItems.setFocus();
                workoutsPage.getWorkouts(workoutsCategoryCurrent.data.id_categ);
            }
        }
    }

    /**
    * Workout days
    */
    GridView {
        id: workoutItems;
        anchors.top: workoutsPage.top;
        anchors.left: workoutsPage.left;
        anchors.right: workoutsPage.right;
        anchors.bottom: workoutsPage.bottom;
        z: 1;
        opacity: 1;

        cellWidth: app.sizes.exercise.width + 5;
        cellHeight: app.sizes.exercise.height + 105;

        focus: true;
        clip: true;
        visible: false;

        delegate: ExerciseDelegate {}
        model: ListModel {}

        onUpPressed: {
            tab.setFocus();
        }

        onKeyPressed: {
            const workoutsCurrent = {
                index: workoutItems.currentIndex,
                data: workoutItems.model.get(workoutItems.currentIndex)
            };
            if (key === "Red") {
                app.addToBookmark(workoutsCurrent.data, "exercise", "workout");
            } else if (key === "Up") {
                tab.setFocus();
            } else if (key === "Select") {

                exerciseDetailContainer.page = "workout";

                exerciseDetailContainer.id = workoutsCurrent.data.id;
                exerciseDetailContainer.title = workoutsCurrent.data.title;
                exerciseDetailContainer.description = workoutsCurrent.data.description;
                exerciseDetailContainer.images = workoutsCurrent.data.images;

                workoutsPage.visible = false;
                exerciseDetailContainer.visible = true;
                exerciseDetailContainer.setFocus();

                // stats
                app.httpServer(app.config.api.stats, "GET", { type: "workout" }, "statsExercise", () => {});
            }
        }

        onBackPressed: {
            categoryWorkout.visible = true;
            workoutItems.visible = false;
        }
    
        /**
        * ListView exerciseHighlight
        */
        property int hlWidth: app.sizes.exercise.width;
        property int hlHeight: app.sizes.exercise.height + 100;
        property Color highlightColor: app.theme.light.background;

        Rectangle {
            id: exerciseHighlight;
            z: 2;
            color: workoutItems.highlightColor;
            opacity: workoutItems.activeFocus ? 0.2 : 0.1;
            visible: workoutItems.count;

            doHighlight: {
                if (!workoutItems || !workoutItems.model || !workoutItems.count)
                    return;

                var futurePos = workoutItems.getPositionViewAtIndex(workoutItems.currentIndex, workoutItems.positionMode);
                var itemRect = workoutItems.getItemRect(workoutItems.currentIndex);

                itemRect.Move(-futurePos.X, -futurePos.Y);

                if (workoutItems.hlHeight) {
                    this.height = workoutItems.hlHeight;
                    this.y = itemRect.Top;
                }

                if (workoutItems.hlWidth) {
                    this.width = workoutItems.hlWidth;
                    this.x = itemRect.Left;
                }
            }

            updateHighlight: {
                if (workoutItems.visible) {
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


    function getWorkoutsCategory() {
        app.httpServer(app.config.api.workoutsCategory, "GET", {}, "getWorkouts", (workouts) => {
            workoutCategoryItems.model.reset();
            if (workouts.length) {
                workouts.forEach((work) => {
                    workoutCategoryItems.model.append(work);
                });
            }

            fit.loading = false;
        });
    }

    function getWorkouts(id_categ) {
		fit.loading = true;
        app.httpServer(app.config.api.workouts, "GET", { id_categ: id_categ }, "getWorkouts", (exercise) => {
            workoutItems.model.reset();
            if (exercise.length) {
                exercise.forEach((vid) => {
                    // append to model
                    workoutItems.model.append({
                        id: vid["id"],
                        title: vid["name"],
                        description: vid["text"],
                        bookmark: vid["bookmark"],
                        images: vid["images"],
                        day: vid["day"]
                    });
                });
            }

            fit.loading = false;
        });
    }

    onVisibleChanged: {
        categoryWorkout.visible = true;
        workoutItems.visible = false;
    }
}