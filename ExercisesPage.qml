import "ExercisesPageItems.qml";
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
        anchors.bottom: exercisesPage.bottom;

        height: appMain.sizes.exercise.height + 50;
        opacity: 1.0;
        color: fit.isDark ? appMain.theme.dark.item_background : appMain.theme.light.item_background;

        /**
        * Exercise items
        */
        ExercisesPageItems {
            id: exerciseItemsList;
            z: 1;

            anchors.top: exercisesCategory.top;
            anchors.left: exercisesPageContainer.left;
            anchors.right: exercisesPageContainer.right;
            anchors.topMargin: appMain.sizes.margin;

            opacity: activeFocus ? 1.0 : appMain.config.inactiveOpacity;

            onCompleted: {
                chipItems.setFocus();
            }

            onKeyPressed: {
                if (key === "Red") {
                    let current = model.get(exerciseItemsList.currentIndex);
                    appMain.addToBookmark(current, "exercise", "main", (boolean) => {});
                } else if (key === "Up") {
                    chipItems.setFocus();
                } else if (key === "Select") {
                    const currentExerciseItemsList = model.get(exerciseItemsList.currentIndex);

                    exerciseDetailContainer.page = "main";

                    exerciseDetailContainer.id = currentExerciseItemsList.id;
                    exerciseDetailContainer.title = currentExerciseItemsList.title;
                    exerciseDetailContainer.description = currentExerciseItemsList.description;
                    exerciseDetailContainer.images = currentExerciseItemsList.images;
                    exerciseDetailContainer.bookmark = currentExerciseItemsList.bookmark;

                    exercisesPageContainer.visible = false;
                    exerciseDetailContainer.visible = true;
                    exerciseDetailContainer.setFocus();
                    imagesGalary.setFocus();

                    // stats
                    appMain.httpServer(appMain.config.api.stats, "GET", { type: "exercise" }, "statsExercise", () => {});
                }
            }
        }
    }

    function getChipsAndExercises() {
        chipItems.getChips(appMain.config.api.exercisesCategories, (callback) => {
            if (callback) {
                exerciseItemsList.getExercises(chipItems.model.get(chipItems.currentIndex).id_type);
                exerciseItemsList.setFocus();
            }
        });
    }
}