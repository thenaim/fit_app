import "ImagesGalaryDelegate.qml";

import controls.Button;
import "js/app.js" as app;

Item {
    id: exerciseDetail;
    z: 2;

    property bool vkIntegrated: false; 
    property string vkId;

    property string page; 
    property string id;
    property string title;
    property var description;
    property var images;

    opacity: 1.0;

    focus: false;

    /**
    * Exercise Name
    */
    Text {
        id: nameText;
        z: 3;
        anchors.top: exerciseDetail.top;
        anchors.horizontalCenter: exerciseDetail.horizontalCenter;

        opacity: 1;
        color: fit.isDark ? app.theme.dark.textColor : app.theme.light.textColor;
        text: exerciseDetail.title;
        wrapMode: Text.WordWrap;
        visible: !imagesGalary.zoom;

        font: Font {
            family: "Proxima Nova Condensed";
            pixelSize: 34;
            black: true;
        }
    }

    /**
    * Exercise Image Galary
    */
    ListView {
        id: imagesGalary;
        property bool zoom: false;
        z: 2;
        orientation: mainWindow.horizontal;

        anchors.top: nameText.bottom;
        anchors.horizontalCenter: exerciseDetail.horizontalCenter;
        anchors.left: exerciseDetail.left;
        anchors.right: exerciseDetail.right;
        anchors.topMargin: !imagesGalary.zoom ? app.sizes.margin : 0;

        height: app.sizes.exercise.height + (fit.fullscreen ? 100 : 80);
        spacing: 2;

        focus: true;
        clip: true;

        delegate: ImagesGalaryDelegate {}

       	model: ListModel {}

        Behavior on height { animation: Animation { duration: 300; } }

        onSelectPressed: {
            if (imagesGalary.zoom) {
                imagesGalary.height = app.sizes.exercise.height + (fit.fullscreen ? 100 : 80);
                imagesGalary.anchors.top = nameText.bottom;
            } else {
                imagesGalary.height = mainView.height > 720 ? 720 - (app.sizes.margin * 2) : mainView.height - (app.sizes.margin * 2);
                imagesGalary.anchors.top = exerciseDetail.top;
            }
            imagesGalary.zoom = !imagesGalary.zoom;
        }
    
        onUpPressed: {
            if (fit.fullscreen) return;
            exerciseDetailContainer.visible = false;
            if (exerciseDetail.page === "main") {
                exercisesPageContainer.visible = true;
            } else if (exerciseDetail.page === "bookmark") {
                bookmarkPage.visible = true;
            }
            tab.setFocus();
        }

        onDownPressed: {
            if (fit.fullscreen) return;
            vkButton.setFocus();
        }
    }

    /**
    * Exercise Description
    */
    ScrollingText {
        id: descriptionexerciseText;
        anchors.top: imagesGalary.bottom;
        anchors.left: exerciseDetail.left;
        anchors.right: exerciseDetail.right;
        anchors.bottom: exerciseDetail.bottom;
        anchors.topMargin: app.sizes.margin;

        opacity: 1.0;

        visible: fit.fullscreen && !imagesGalary.zoom;
        color: fit.isDark ? app.theme.dark.textColor : app.theme.light.textColor;
        text: exerciseDetail.description;

        font: secondaryFont;
    }

    /**
    * Exercise Social button
    */
    Item {
        id: descriptionAndButton;
        z: 1;
        anchors.top: descriptionexerciseText.visible ? descriptionexerciseText.bottom : imagesGalary.bottom;
        anchors.left: exerciseDetail.left;
        anchors.right: exerciseDetail.right;
        anchors.bottom: exerciseDetail.bottom;
        anchors.horizontalCenter: exerciseDetail.horizontalCenter;
        visible: !fit.fullscreen && !imagesGalary.zoom;

        Button {
            id: vkButton;

            anchors.top: descriptionAndButton.top;
            anchors.horizontalCenter: exerciseDetail.horizontalCenter;
            anchors.topMargin: app.sizes.margin / 2;

            color: activeFocus ? app.theme.light.background : app.theme.dark.layout_background;
            text: "Отправить в социальные сети";
            radius: app.sizes.radius;
            visible: true;
            opacity: activeFocus ? 1.0 : app.config.inactiveOpacity;
            font: Font {
                pixelSize: 15;
            }

            onUpPressed: {
                if (fit.fullscreen) return;
                imagesGalary.setFocus();
            }

            onSelectPressed: {
                sendSocial.visible = true;
                sendSocial.showSendSocial("exercise", exerciseDetail.id);
            }
        }

        Text {
            id: desexerciseText;
            anchors.top: exerciseDetail.bottom;
            anchors.horizontalCenter: exerciseDetail.horizontalCenter;
            anchors.topMargin: -8;

            color: fit.isDark ? app.theme.dark.textColor : app.theme.light.textColor;

            visible: !fit.fullscreen;
            text: app.texts.doFullscreen;

            font: Font {
                family: "Proxima Nova Condensed";
                pixelSize: 24;
                black: true;
            }
        }
    }

    onVisibleChanged: {
        imagesGalary.model.reset();
        exerciseDetail.images.forEach((img) => {
            imagesGalary.model.append({
                image: img
            });
        });
        imagesGalary.setFocus();
    }

    onBackPressed: {
        exerciseDetailContainer.visible = false;
        if (exerciseDetail.page === "main") {
            exercisesPageContainer.visible = true;
            exerciseItemsList.setFocus();
        } else if (exerciseDetail.page === "bookmark") {
            bookmarkPage.visible = true;
            bookmarkExerciseItemsList.setFocus();
        }
    }
}