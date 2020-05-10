import "ImagesGalaryDelegate.qml";

import controls.Button;
import "js/app.js" as appMain;
import "js/languages.js" as appLangs;

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
        color: fit.isDark ? appMain.theme.dark.textColor : appMain.theme.light.textColor;
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
        anchors.topMargin: !imagesGalary.zoom ? appMain.sizes.margin : 0;

        height: appMain.sizes.exercise.height + (fit.fullscreen ? 100 : 80);
        spacing: 1;
        focus: true;
        clip: true;
        delegate: ImagesGalaryDelegate {}
       	model: ListModel {}

        Behavior on height { animation: Animation { duration: 300; } }

        // On select pressed, zoom image and check if appMain fullscreened
        onSelectPressed: {
            if (imagesGalary.zoom) {
                imagesGalary.height = appMain.sizes.exercise.height + (fit.fullscreen ? 100 : 80);
                imagesGalary.anchors.top = nameText.bottom;
            } else {
                imagesGalary.height = mainView.height > 720 ? 720 - (appMain.sizes.margin * 2) : mainView.height - (appMain.sizes.margin * 2);
                imagesGalary.anchors.top = exerciseDetail.top;
            }
            imagesGalary.zoom = !imagesGalary.zoom;
        }

        // On up pressed
        // if fullscreen true, then return
        // if not fullscreen, then setFocus to tab
        onUpPressed: {
            if (fit.fullscreen) return;
            exerciseDetailContainer.visible = false;
            if (exerciseDetail.page === "main") {
                exercisesPageContainer.visible = true;
            } else if (exerciseDetail.page === "bookmark") {
                bookmarkPage.visible = true;
            } else if (exerciseDetail.page === "workout") {
                workoutsPage.visible = true;
                workoutItems.setFocus();
            }
            tab.setFocus();
        }

        onDownPressed: {
            if (fit.fullscreen) {
                return startButton.setFocus();
            }
            sendSocialExerciseButton.setFocus();
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
        anchors.topMargin: appMain.sizes.margin;

        opacity: 1.0;
        visible: fit.fullscreen && !imagesGalary.zoom;
        color: fit.isDark ? appMain.theme.dark.textColor : appMain.theme.light.textColor;
        text: exerciseDetail.description;
        font: secondaryFont;
    }

    /**
    * Exercise Start container
    */
    Item {
        id: startExercises;
        z: 3;
        anchors.top: descriptionexerciseText.bottom;
        anchors.left: exerciseDetail.left;
        anchors.right: exerciseDetail.right;
        anchors.bottom: exerciseDetail.bottom;
        anchors.topMargin: -80;
        anchors.horizontalCenter: exerciseDetail.horizontalCenter;

        height: 150;
        width: 300;
        visible: fit.fullscreen;

        /**
        * Exercise rounds
        */
        Text {
            id: exerciseRounds;
            anchors.top: startExercises.top;
            anchors.horizontalCenter: exerciseDetail.horizontalCenter;
            anchors.bottomMargin: appMain.sizes.margin / 2.8;

            color: imagesGalary.zoom ? appMain.theme.light.textColor : fit.isDark ? appMain.theme.dark.textColor : appMain.theme.light.textColor;
            text: exerciseTimer.rounds + "/3 " + appLangs.texts[fit.lang].repetitionCircle;
            font: Font {
                family: "Proxima Nova Condensed";
                pixelSize: 26;
                black: true;
            }
        }

        /**
        * Exercise start button
        */
        Button {
            id: startButton;

            anchors.top: exerciseRounds.bottom;
            anchors.horizontalCenter: parent.horizontalCenter;
            anchors.topMargin: appMain.sizes.margin / 2;
            anchors.bottomMargin: appMain.sizes.margin / 3;

            color: activeFocus ? appMain.theme.light.background : appMain.theme.dark.layout_background;
            text: exerciseTimer.running ? appLangs.texts[fit.lang].stop : appLangs.texts[fit.lang].start;
            radius: appMain.sizes.radius;
            visible: true;
            opacity: activeFocus ? 1.0 : appMain.config.inactiveOpacity;
            font: Font {
                pixelSize: 15;
            }

            onUpPressed: {
                imagesGalary.setFocus();
            }

            onSelectPressed: {
                if (exerciseTimer.running) {
                    // stop play exercise
                    return exerciseTimer.resetDataPlay();
                }

                fit.showNotification(appLangs.texts[fit.lang].startFirstCircle);
                exerciseTimer.start();
                // stats
                appMain.httpServer(appMain.config.api.stats, "GET", { type: "exercise_play" }, "startButton", () => {});
            }
        }

        /**
        * Exercise time
        */
        Text {
            id: exerciseTime;
            anchors.top: startButton.top;
            anchors.right: startButton.left;
            anchors.rightMargin: appMain.sizes.margin / 2;
            anchors.topMargin: startButton.height / 3;

            color: imagesGalary.zoom ? appMain.theme.light.textColor : fit.isDark ? appMain.theme.dark.textColor : appMain.theme.light.textColor;
            text: "00:00:30";
            font: Font {
                family: "Proxima Nova Condensed";
                pixelSize: exerciseTimer.running && exerciseTimer.exercise ? 35 : 30;
                black: true;
            }
        }

        /**
        * Exercise relax time
        */
        Text {
            id: relaxTime;
            anchors.top: startButton.top;
            anchors.left: startButton.right;
            anchors.leftMargin: appMain.sizes.margin / 2;
            anchors.topMargin: startButton.height / 3;

            color: imagesGalary.zoom ? appMain.theme.light.textColor : fit.isDark ? appMain.theme.dark.textColor : appMain.theme.light.textColor;
            text: "00:00:15";
            font: Font {
                family: "Proxima Nova Condensed";
                pixelSize: exerciseTimer.running && !exerciseTimer.exercise ? 35 : 30;
                black: true;
            }
        }

        /**
        * Exercise start timer
        */
        Timer {
            id: exerciseTimer;
            property bool exercise: true;
            property int timerExercise: 30000;
            property int timerRelax: 15000;
            property int rounds: 1;
            interval: 1000;
            repeat: true;
            
            onTriggered: {
                // stop if fullscreen closed
                if (!fit.fullscreen) {
                    exerciseTimer.resetDataPlay();

                    return fit.showNotification(appLangs.texts[fit.lang].playExerciseClosed);
                }
                // stop when 3 round finished
                if (exerciseTimer.rounds === 4) {
                    exerciseTimer.resetDataPlay();
                    return fit.showNotification(appLangs.texts[fit.lang].finishedExercise);
                }
                // time to do exercise
                if (exerciseTimer.exercise) {
                    exerciseTimer.timerExercise -= interval;
                    if (exerciseTimer.timerExercise === 0) {
                        exerciseTimer.exercise = false;
                        exerciseTimer.timerExercise = 30000;
                        if (exerciseTimer.rounds === 1) {
                            fit.showNotification(appLangs.texts[fit.lang].relaxCircle);
                        }
                    }
                    exerciseTime.text = exerciseTimer.parseMillisecondsIntoReadableTime(exerciseTimer.timerExercise);
                }
                // time to relax
                if (!exerciseTimer.exercise) {
                    exerciseTimer.timerRelax -= interval;
                    if (exerciseTimer.timerRelax === 0) {
                        exerciseTimer.exercise = true;
                        exerciseTimer.timerRelax = 15000;
                        exerciseTimer.rounds += 1;
                        if (exerciseTimer.rounds === 2) {
                            fit.showNotification(appLangs.texts[fit.lang].startSecondCircle);
                        }
                        if (exerciseTimer.rounds === 3) {
                            fit.showNotification(appLangs.texts[fit.lang].startThirdCircle);
                        }
                    }
                    relaxTime.text = exerciseTimer.parseMillisecondsIntoReadableTime(exerciseTimer.timerRelax);
                }
            }

            function resetDataPlay() {
                exerciseTimer.rounds = 1;
                exerciseTimer.timerExercise = 30000;
                exerciseTimer.timerRelax = 15000;
                exerciseTime.text = "00:00:30";
                relaxTime.text = "00:00:15";
                exerciseTimer.stop();
            }

            /**
            * Parse Milliseconds Into Readable Time
            * @param {Number} milliseconds of timer
            */
            function parseMillisecondsIntoReadableTime(milliseconds){
                //Get hours from milliseconds
                const hours = milliseconds / (1000 * 60 * 60);
                const absoluteHours = Math.floor(hours);
                const h = absoluteHours > 9 ? absoluteHours : '0' + absoluteHours;

                //Get remainder from hours and convert to minutes
                const minutes = (hours - absoluteHours) * 60;
                const absoluteMinutes = Math.floor(minutes);
                const m = absoluteMinutes > 9 ? absoluteMinutes : '0' +  absoluteMinutes;

                //Get remainder from minutes and convert to seconds
                const seconds = (minutes - absoluteMinutes) * 60;
                const absoluteSeconds = Math.floor(seconds);
                const s = absoluteSeconds > 9 ? absoluteSeconds : '0' + absoluteSeconds;

                return h + ':' + m + ':' + s;
            }

        }
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
            id: sendSocialExerciseButton;

            anchors.top: descriptionAndButton.top;
            anchors.horizontalCenter: exerciseDetail.horizontalCenter;
            anchors.topMargin: appMain.sizes.margin / 2;

            color: activeFocus ? appMain.theme.light.background : appMain.theme.dark.layout_background;
            text: appLangs.texts[fit.lang].sendToSocial;
            radius: appMain.sizes.radius;
            visible: true;
            opacity: activeFocus ? 1.0 : appMain.config.inactiveOpacity;
            font: Font {
                pixelSize: 15;
            }

            onUpPressed: {
                if (fit.fullscreen) return;
                imagesGalary.setFocus();
            }

            onSelectPressed: {
                let socials = appMain.social;
                fit.modalController.openModal(socials, "exercise", exerciseDetail.id);
            }
        }

        Text {
            id: desexerciseText;
            anchors.top: exerciseDetail.bottom;
            anchors.horizontalCenter: exerciseDetail.horizontalCenter;
            anchors.topMargin: -8;

            color: fit.isDark ? appMain.theme.dark.textColor : appMain.theme.light.textColor;
            visible: !fit.fullscreen;
            text: appLangs.texts[fit.lang].doFullscreen;
            font: Font {
                family: "Proxima Nova Condensed";
                pixelSize: 24;
                black: true;
            }
        }
    }

    onVisibleChanged: {
        // stop play exercise
        exerciseTimer.resetDataPlay();
        // reset galary images and add new if exist
        imagesGalary.model.reset();
        imagesGalary.zoom = false;
        exerciseDetail.images.forEach((img, index) => {
            index += 1;
            imagesGalary.model.append({
                id: index,
                image: img
            });
        });
        imagesGalary.setFocus();
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
        } else if (exerciseDetail.page === "workout") {
            workoutsPage.visible = true;
            workoutItems.setFocus();
        }
    }
}