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

    focus: true;

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
            family: "Times";
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


    Item {
        id: descriptionAndButton;
        anchors.top: exercisesImages.bottom;
        anchors.left: exercisesImages.left;
        anchors.topMargin: app.sizes.margin;
        anchors.horizontalCenter: exerciseDetail.horizontalCenter;

        Image {
            id: vkButtonImage;
            anchors.top: descriptionAndButton.top;
            anchors.horizontalCenter: exerciseDetail.horizontalCenter;

            width: 50;
            height: 50;

            visible: true;
            registerInCacheSystem: false;

            source: "apps/fit_app/res/VK_logo.png";

            fillMode: PreserveAspectFit;
        }

        Button {
            id: vkButton;

            anchors.top: vkButtonImage.bottom;
            anchors.horizontalCenter: exerciseDetail.horizontalCenter;
            anchors.topMargin: app.sizes.margin / 2;

            color: activeFocus ? "#4680C2" : app.theme.light.background;
            text: exerciseDetail.vkIntegrated ? "Отправить упражнение в ВК" : "Чтобы отправить интегрируйте приложение с ВК";
            radius: app.sizes.radius;
            visible: true;
            opacity: activeFocus ? 1.0 : app.config.inactiveOpacity;

            onSelectPressed: {
                fit.loading = true;
                if (exerciseDetail.vkIntegrated) {
                    app.httpServer(app.config.api.exerciseSend, "GET", { id: exerciseDetail.id }, (vk) => {

                        if (vk.sended) {
                            vkButton.text = "Отправлено!"
                            timerSend.start();
                        };

                        fit.loading = false;
                    });
                }
            }

            onLeftPressed: {
                fullscreenButton.setFocus();
            }
            
            onTopPressed: {}
        }

        Text {
            id: desexerciseText;
            anchors.top: vkButton.bottom;
            anchors.horizontalCenter: exerciseDetail.horizontalCenter;
            anchors.topMargin: app.sizes.margin;

            color: fit.isDark ? app.theme.dark.textColor : app.theme.light.textColor;

            visible: !fit.fullscreen;
            text: "-- Сделайте полный экран, чтобы посмотреть полную инструкцию упражнения ---";

            font: Font {
                family: "Times";
                pixelSize: 24;
                black: true;
            }
        }

        Text {
            id: descriptionexerciseText;
            anchors.top: exercisesImages.bottom;
            anchors.left: descriptionAndButton.left;
            anchors.topMargin: app.sizes.margin;

            color: fit.isDark ? app.theme.dark.textColor : app.theme.light.textColor;

            visible: fit.fullscreen;
            text: app.wrapText(exerciseDetail.description, 280);

            font: Font {
                family: "Times";
                pixelSize: 22;
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
			vkButton.text = exerciseDetail.vkIntegrated ? "Отправить упражнение в ВК" : "Чтобы отправить интегрируйте приложение с ВК"
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