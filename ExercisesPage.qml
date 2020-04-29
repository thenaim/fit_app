import "js/app.js" as app;

import "ExerciseItems.qml";
import "ExerciseDelegate.qml";
import "Chips.qml";

Item {
    id: exercisesPage;
    z: 1;
    property bool loading: false;

    anchors.top: exercisesPageContainer.top;
    anchors.left: exercisesPageContainer.left;
    anchors.right: exercisesPageContainer.right;
    anchors.bottom: exercisesPageContainer.bottom;

    opacity: 1.0;

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
                exerciseItemsList.getExercises(chipCurrent.data.id_type);
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

        /**
        * Exercise items
        */
        ExerciseItems {
            id: exerciseItemsList;
            z: 1;

            anchors.top: exercisesCategory.top;
            anchors.left: exercisesPageContainer.left;
            anchors.right: exercisesPageContainer.right;
            anchors.topMargin: app.sizes.margin / 1.5;

            opacity: 1.0;

            onCompleted: {
                chipItems.setFocus();
            }

            onKeyPressed: {
                if (key === "Red") {
                    let current = model.get(exerciseItemsList.currentIndex);
                    app.addToBookmark(current, "exercise", "main");
                } else if (key === "Up") {
                    chipItems.setFocus();
                } else if (key === "Select") {
                    const currentExerciseItemsList = model.get(exerciseItemsList.currentIndex);

                    exerciseDetailContainer.page = "main";

                    exerciseDetailContainer.id = currentExerciseItemsList.id;
                    exerciseDetailContainer.title = currentExerciseItemsList.title;
                    exerciseDetailContainer.description = currentExerciseItemsList.description;
                    exerciseDetailContainer.images = currentExerciseItemsList.images;

                    exercisesPageContainer.visible = false;
                    exerciseDetailContainer.visible = true;
                    exerciseDetailContainer.setFocus();

                    // stats
                    app.httpServer(app.config.api.stats, "GET", { type: "exercise" }, "statsExercise", () => {});
                }
            }

            onLeftPressed: {}

            onRightPressed: {}
        }
    }

    onCompleted: {}

    function getChipsAndExercises() {
        chipItems.getChips(app.config.api.exercisesCategories, (callback) => {
            if (callback) {
                exerciseItemsList.getExercises(chipItems.model.get(chipItems.currentIndex).id_type);
                exerciseItemsList.setFocus();
            }
        });
    }
}