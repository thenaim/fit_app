import "js/app.js" as app;

Rectangle {
    id: exerciseDelegate;
    anchors.top: exerciseItems.top;

    width: app.sizes.exercise.width;
    height: app.sizes.exercise.height + 100;
    opacity: 1;
    color: fit.isDark ? app.theme.dark.layout_background : app.theme.light.layout_background;

    focus: true;

    Rectangle {
        id: imageExerciseItem;
        z: 1;
        anchors.top: exerciseDelegate.top;
        color: "#ffffff";
        opacity: 1.0;

        width: app.sizes.exercise.width;
        height: app.sizes.exercise.height;

        Image {
            id: imageCard;
            z: 2;
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
        height: (app.sizes.exercise.height / 2) + 30;

        Text {
            id: exerciseText;
            anchors.top: parent.top;

            width: app.sizes.exercise.width;

            color: fit.isDark ? app.theme.dark.textColor : app.theme.light.textColor;
            text: app.wrapText(model.title, 28);
            wrapMode: Text.WordWrap;

            font: Font {
                family: "Proxima Nova Condensed";
                pixelSize: 26;
                black: true;
            }
        }

        Image {
            id: bookmarkImage;
            z: 2;
            // anchors.top: exerciseText.bottom;
            anchors.left: exerciseDelegate.left;
            anchors.right: exerciseDelegate.right;
            anchors.bottom: exerciseDelegate.bottom;
            // anchors.horizontalCenter: exerciseDelegate.horizontalCenter;
            anchors.margins: app.sizes.margin / 2;

            width: 20;
            height: 20;

            visible: true;
            registerInCacheSystem: false;

            source: model.bookmark ? "apps/fit_app/res/heart_added.png" : "apps/fit_app/res/heart_add.png";

            fillMode: PreserveAspectFit;
        }
    }
}


