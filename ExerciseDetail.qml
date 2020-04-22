import "js/app.js" as app;
import controls.Button;

Item {
    id: exerciseDetail;
    z: 2;

    property bool vkIntegrated: false; 
    property string vkId; 
    property string id;
    property string title;
    property var description;
    property var images;

    opacity: 1.0;

    focus: false;

    Text {
        id: nameText;
        z: 3;
        anchors.top: exerciseDetail.top;
        anchors.horizontalCenter: exerciseDetail.horizontalCenter;

        opacity: 1;
        color: fit.isDark ? app.theme.dark.textColor : app.theme.light.textColor;
        text: exerciseDetail.title;
        wrapMode: Text.WordWrap;

        font: Font {
            family: "Proxima Nova Condensed";
            pixelSize: 34;
            black: true;
        }
    }

    Item {
        id: exercisesImages;
        anchors.top: nameText.bottom;
        anchors.horizontalCenter: exerciseDetail.horizontalCenter;
        anchors.topMargin: app.sizes.margin;

        width: (app.sizes.exercise.width * 3) + (fit.fullscreen ? 300 : 0);
        height: app.sizes.exercise.height + (fit.fullscreen ? 100 : 0);

        Image {
            id: exercisesImage;
            z: 4;
            anchors.top: exercisesImages.top;
            anchors.left: exercisesImages.left;

            width: app.sizes.exercise.width + (fit.fullscreen ? 100 : 0);
            height: app.sizes.exercise.height + (fit.fullscreen ? 100 : 0);

            visible: true;
            registerInCacheSystem: false;

            source: app.config.static + "/images/img/" + exerciseDetail.images[0];

            fillMode: PreserveAspectFit;
        }

        Image {
            id: exercisesImage2;
            z: 4;
            anchors.top: exercisesImage.top;
            anchors.left: exercisesImage.right;

            width: app.sizes.exercise.width + (fit.fullscreen ? 100 : 0);
            height: app.sizes.exercise.height + (fit.fullscreen ? 100 : 0);

            visible: true;
            registerInCacheSystem: false;

            source: app.config.static + "/images/img/" + exerciseDetail.images[2];

            fillMode: PreserveAspectFit;
        }

        Image {
            id: exercisesImage3;
            z: 4;
            anchors.top: exercisesImage2.top;
            anchors.left: exercisesImage2.right;

            width: app.sizes.exercise.width + (fit.fullscreen ? 100 : 0);
            height: app.sizes.exercise.height + (fit.fullscreen ? 100 : 0);

            visible: true;
            registerInCacheSystem: false;

            source: app.config.static + "/images/img/" + exerciseDetail.images[exerciseDetail.images.length - 1];

            fillMode: PreserveAspectFit;
        }
    }

    ScrollingText {
        id: descriptionexerciseText;
        anchors.top: exercisesImages.bottom;
        anchors.left: exercisesImages.left;
        anchors.right: exercisesImages.right;
        anchors.bottom: descriptionAndButton.top;
        anchors.topMargin: app.sizes.margin;

        opacity: 1.0;

        visible: fit.fullscreen;
        color: fit.isDark ? app.theme.dark.textColor : app.theme.light.textColor;
        text: exerciseDetail.description;

        font: secondaryFont;
    }


    Item {
        id: descriptionAndButton;
        anchors.top: descriptionexerciseText.visible ? descriptionexerciseText.bottom : exercisesImages.bottom;
        anchors.left: exercisesImages.left;
        anchors.right: exercisesImages.right;
        anchors.bottom: exerciseDetail.bottom;
        anchors.topMargin: app.sizes.margin;
        anchors.horizontalCenter: exerciseDetail.horizontalCenter;
        visible: !fit.fullscreen;

        Button {
            id: vkButton;

            anchors.top: descriptionAndButton.top;
            anchors.horizontalCenter: exerciseDetail.horizontalCenter;
            anchors.topMargin: app.sizes.margin / 2;

            color: activeFocus ? "#4680C2" : app.theme.light.background;
            text: "Отправить в социальные сети";
            radius: app.sizes.radius;
            visible: true;
            opacity: activeFocus ? 1.0 : app.config.inactiveOpacity;
            font: Font {
                pixelSize: 15;
            }

            onSelectPressed: {
                sendSocial.visible = true;
                sendSocial.showSendSocial("exercise", exerciseDetail.id);
                return;
                fit.loading = true;
                if (exerciseDetail.vkIntegrated) {
                    app.httpServer(app.config.api.exerciseSend, "GET", "vkButton", { id: exerciseDetail.id }, (vk) => {

                        if (vk.sended) {
                            vkButton.text = app.texts.sended;
                            timerSend.start();
                        };

                        fit.loading = false;
                    });
                }
            }
        }

        Text {
            id: desexerciseText;
            anchors.top: vkButton.bottom;
            anchors.horizontalCenter: exerciseDetail.horizontalCenter;
            anchors.topMargin: app.sizes.margin;

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

    Timer {
		id: timerSend;
		interval: 300;
		repeat: false;
		
		onTriggered: {
            this.stop();
			vkButton.text = exerciseDetail.vkIntegrated ? app.texts.integrateSendVk : app.texts.notIntegrateSendVk;
		}
	}


    onVisibleChanged: {
        exerciseDetail.vkIntegrated = fit.stingray.vkIntegrated;
        vkButton.setFocus();
    }

    onUpPressed: {
        exerciseDetailContainer.visible = false;
        exercisesPageContainer.visible = true;
        tab.setFocus();
    }

    onBackPressed: {
        exerciseDetailContainer.visible = false;
        exercisesPageContainer.visible = true;
        exerciseItemsList.setFocus();
    }
}