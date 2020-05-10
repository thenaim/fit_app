import "js/app.js" as appMain;

Rectangle {
    id: exerciseDelegate;
    anchors.top: exerciseItems.top;

    width: appMain.sizes.exercise.width;
    height: appMain.sizes.exercise.height + 100;
    opacity: 1;
    color: fit.isDark ? appMain.theme.dark.layout_background : appMain.theme.light.layout_background;

    focus: true;

    Rectangle {
        id: imageExerciseItem;
        z: 1;
        anchors.top: exerciseDelegate.top;
        color: "#ffffff";
        opacity: 1;

        width: appMain.sizes.exercise.width;
        height: appMain.sizes.exercise.height;

        Image {
            id: imageCard;
            z: 2;
            anchors.top: imageExerciseItem.top;
            opacity: 1;

            width: appMain.sizes.exercise.width;
            height: appMain.sizes.exercise.height;

            registerInCacheSystem: false;
            source: appMain.config.static + "/images/img/" + model.images[0];
            fillMode: PreserveAspectFit;
        }
    }

    Item {
        id: contentExerciseItem;
        anchors.top: imageExerciseItem.bottom;
        anchors.left: imageExerciseItem.left;
        anchors.right: imageExerciseItem.right;
        anchors.margins: appMain.sizes.margin / 2;
        opacity: exerciseDelegate.activeFocus ? 1.0 : appMain.config.inactiveOpacity;

        width: appMain.sizes.exercise.width;
        height: (appMain.sizes.exercise.height / 2) + 30;

        Text {
            id: exerciseText;
            anchors.top: parent.top;

            width: appMain.sizes.exercise.width;

            color: fit.isDark ? appMain.theme.dark.textColor : appMain.theme.light.textColor;
            text: appMain.wrapText(model.title, 28);
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
            anchors.left: exerciseDelegate.left;
            anchors.right: exerciseDelegate.right;
            anchors.bottom: exerciseDelegate.bottom;
            anchors.margins: appMain.sizes.margin / 2;

            width: 20;
            height: 20;
            visible: true;
            registerInCacheSystem: false;
            source: model.bookmark ? "apps/fit_app/res/heart_added.png" : "apps/fit_app/res/heart_add.png";
            fillMode: PreserveAspectFit;
        }
    }

    /**
    * Show day workout, when day property exist
    */
    Rectangle {
        id: dayItemsIndex;
        z: 3;
        anchors.top: contentExerciseItem.top;
        anchors.horizontalCenter: exerciseDelegate.horizontalCenter;
        anchors.topMargin: -(appMain.sizes.margin * 2);
        radius: 10;
        width: indexTxt.width + appMain.sizes.margin;
        height: 25;
        visible: model.day;

        opacity: exerciseDelegate.activeFocus ? 1.0 : 0.8;
        color: fit.isDark ? appMain.theme.dark.layout_background : appMain.theme.light.layout_background;
        focus: true;

        Text {
            id: indexTxt;
            opacity: exerciseDelegate.activeFocus ? 1.0 : 0.8;

            anchors.centerIn: parent;

            color: fit.isDark ? appMain.theme.dark.textColor : appMain.theme.light.textColor;

            text: appLangs.texts[fit.lang].day + " " + model.day;

            font: Font {
                family: "Proxima Nova Condensed";
                pixelSize: 28;
                black: true;
            }
        }
    }
}


