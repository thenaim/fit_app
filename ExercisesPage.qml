import "js/app.js" as app;

import "ExerciseDelegate.qml";
import "Chips.qml";

Rectangle {
    id: exercisesPage;
    property bool loading: false;

    anchors.top: exercisesPageContainer.top;
    anchors.left: exercisesPageContainer.left;
    anchors.right: exercisesPageContainer.right;
    anchors.bottom: exercisesPageContainer.bottom;

    opacity: 1.0;
    color: fit.isDark ? app.theme.dark.item_background : app.theme.light.item_background;

    /**
    * Chips horizontal cards
    */
    Chips {
        id: chipItems;
        anchors.top: exercisesPage.top;
        anchors.left: exercisesPage.left;
        anchors.right: exercisesPage.right;

        keyNavigationWraps: false;
        
        onCompleted: {
            chipItems.setFocus();
        }

        onKeyPressed: {
            const chipCurrent = {
                index: chipItems.currentIndex,
                data: model.get(chipItems.currentIndex)
            };

            if (key === "Select" || key === "Down") {
                exercisesPage.updateExercises(chipCurrent.data.id);
                exerciseItemsList.setFocus();
            }
        }

        onUpPressed: {
            tab.setFocus();
        }

        onLeftPressed: {}

        onRightPressed: {}
    }

    /**
    * Chip category name
    */
    Rectangle {
        id: exercisesCategory;
        anchors.top: chipItems.bottom;
        anchors.left: exercisesPage.left;
        anchors.right: exercisesPage.right;
        anchors.topMargin: app.sizes.margin / 1.5;

        height: app.sizes.exercise.height + 50;

        opacity: 1.0;
        color: fit.isDark ? app.theme.dark.item_background : app.theme.light.item_background;

        Text {
            id: exerciseText;
            anchors.top: parent.top;
            width: 300;
            height: 40;

            color: fit.isDark ? app.theme.dark.textColor : app.theme.light.textColor;

            text: "Мышцы пресса";

            font: Font {
                family: "Times";
                pixelSize: 32;
                black: true;
            }
        }

        /**
        * Chip category items
        */
        ListView {
            id: exerciseItemsList;
            z: 1;
            orientation: exercisesCategory.horizontal;

            anchors.top: exerciseText.bottom;
            anchors.left: exercisesPageContainer.left;
            anchors.right: exercisesPageContainer.right;

            spacing: 10;
            height: app.sizes.exercise.height + 70;
            opacity: 1.0;
            focus: true;
            clip: true;

            delegate: ExerciseDelegate {}

            model: ListModel { id: exerciseItemModel; }
            
            onSelectPressed: {
                log("currentExerciseItemsList");
                const currentExerciseItemsList = model.get(exerciseItemsList.currentIndex);
                exerciseDetailContainer.id = currentExerciseItemsList.id;
                exerciseDetailContainer.title = currentExerciseItemsList.title;
                exerciseDetailContainer.description = currentExerciseItemsList.description;
                exerciseDetailContainer.images = currentExerciseItemsList.images;

                exercisesPageContainer.visible = false;
                exerciseDetailContainer.visible = true;
                exerciseDetailContainer.setFocus();
            }

            onCompleted: {
                chipItems.setFocus();
            }

            onKeyPressed: {
                if (key === "Up") {
                    chipItems.setFocus();
                }
            }

            onLeftPressed: {}

            onRightPressed: {}


            /**
            * ListView exerciseHighlight
            */
            property int hlWidth: app.sizes.exercise.width;
            property int hlHeight: 4;
            property Color highlightColor: app.theme.light.background;

            Rectangle {
                id: exerciseHighlight;
                z: 2;
                color: exerciseItemsList.highlightColor;
                anchors.bottom: exerciseItemsList.bottom;
                opacity: exerciseItemsList.activeFocus ? 1 : 0.6;
                visible: exerciseItemsList.count;

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
    }

    onCompleted: {}

    function getChipsAndExercises(type) {
        fit.loading = true;
        chipItems.getChips(app.config.api.exercisesCategories, (callback) => {
            if (callback) {
                app.httpServer(app.config.api.exercises, "GET", { stingray: load("fit_stingray"), token: app.config.token, type: type }, (exercise) => {
                    // reset models
                    exerciseItemsList.exerciseItemModel.reset();

                    if (exercise.length) {
                        exercise.forEach((vid) => {
                            const data = {
                                id: vid["id"],
                                title: vid["name"],
                                description: vid["detail"],
                                images: vid.images
                            };
                            // append to models
                            exerciseItemsList.exerciseItemModel.append(data);
                            fit.loading = false;
                        });
                        // active category name
                        exerciseText.text = chipsList.model.get(chipsList.currentIndex).name;
                    };
                });
            }
        });
    }

    function updateExercises(type) {
        app.httpServer(app.config.api.exercises, "GET", { stingray: load("fit_stingray"), token: app.config.token, type: type }, (exercise) => {
            // reset models
            exerciseItemsList.exerciseItemModel.reset();

            if (exercise.length) {
                exercise.forEach((vid) => {
                    const data = {
                        id: vid["id"],
                        title: vid["name"],
                        description: vid["detail"],
                        images: vid.images
                    };
                    // append to models
                    exerciseItemsList.exerciseItemModel.append(data);
                });
                // set active category name
                exerciseText.text = chipsList.model.get(chipsList.currentIndex).name;
            };
        });
    }
}