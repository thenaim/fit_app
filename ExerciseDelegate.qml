import "js/app.js" as app;

Rectangle {
    id: exerciseDelegate;
    anchors.top: exerciseItems.top;

    width: app.sizes.exercise.width;
    height: app.sizes.exercise.height + 70;
    opacity: activeFocus ? 1.0 : app.config.inactiveOpacity;
    color: fit.isDark ? app.theme.dark.layout_background : app.theme.light.layout_background;

    focus: true;

    Rectangle {
        id: imageExerciseItem;
        anchors.top: exerciseDelegate.top;
        color: "#ffffff";
        opacity: 1.0;

        width: app.sizes.exercise.width;
        height: app.sizes.exercise.height;

        Image {
            id: imageCard;
            anchors.top: imageExerciseItem.top;

            width: app.sizes.exercise.width;
            height: app.sizes.exercise.height;

            registerInCacheSystem: false;

            source: app.config.static + "/images/img/" + model.images[0];

            fillMode: PreserveAspectFit;
        }
    }

    Item {
        id: contentExerciseItem;
        anchors.top: imageExerciseItem.bottom;
        anchors.left: imageExerciseItem.left;
        anchors.right: imageExerciseItem.right;

        anchors.margins: app.sizes.margin / 2;

        width: app.sizes.exercise.width;
        height: app.sizes.exercise.height / 2;

        Text {
            id: exerciseText;
            anchors.top: parent.top;

            width: app.sizes.exercise.width;

            color: fit.isDark ? app.theme.dark.textColor : app.theme.light.textColor;
            text: app.wrapText(model.title, 28);
            wrapMode: Text.WordWrap;

            font: Font {
                family: "Times";
                pixelSize: 26;
                black: true;
            }
        }
    }
}


