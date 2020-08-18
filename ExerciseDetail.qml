import "ImagesGalaryDelegate.qml";

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
    property bool bookmark: false; 

    opacity: 1.0;

    focus: true;

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
        anchors.margins: imagesGalary.zoom ? -appMain.sizes.margin : 0;
        anchors.topMargin: imagesGalary.zoom ? 0 : appMain.sizes.margin / 2;

        height: appMain.sizes.exercise.height + (fit.fullscreen ? 100 : 80);
        // spacing: 1;
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
                return startExerciseButton.setFocus();
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

                imagesGalary.currentIndex = 0;
                imagesGalary.setFocus();
            }

            onSelectPressed: {
                fit.modalController.itemsWillBeInModal = 3;
                fit.modalController.openModal(appModals.social, "exercise", exerciseDetail.id, sendSocialExerciseButton, fit.lang);
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

    /**
    * Exercise play zone
    */
    Item {
        id: playZone;
        z: 4;
        anchors.left: mainView.left;
        anchors.right: mainView.right;
        anchors.bottom: mainView.bottom;
        anchors.margins: fit.fullscreen ? 0 : -appMain.sizes.margin;
        
        height: 110 + 10;
        visible: fit.fullscreen;

        /**
        * Exercise rounds text
        */
        Text {
            id: exerciseRounds;
            anchors.top: parent.top;
            anchors.left: parent.left;
            anchors.margins: appMain.sizes.margin;

            color: imagesGalary.zoom ? appMain.theme.light.textColor : fit.isDark ? appMain.theme.dark.textColor : appMain.theme.light.textColor;
            text: exerciseTimer.rounds + "/3 " + appLangs.texts[fit.lang].repetitionCircle;
            font: Font {
                family: "Proxima Nova Condensed";
                pixelSize: 34;
                black: true;
            }
        }

        /**
        * Exercise start button
        */
        Button {
            id: startExerciseButton;
            anchors.top: parent.top;
            anchors.horizontalCenter: parent.horizontalCenter;

            color: activeFocus ? appMain.theme.light.background : appMain.theme.dark.layout_background;
            text: exerciseTimer.running ? appLangs.texts[fit.lang].stop : appLangs.texts[fit.lang].start;
            radius: appMain.sizes.radius;
            visible: true;
            width: 250;
            opacity: activeFocus ? 1.0 : appMain.config.inactiveOpacity;
            font: Font {
                pixelSize: 30;
            }

            onUpPressed: {
                imagesGalary.setFocus();
            }

            onRightPressed: {
                if (musicOrNot.withMusic) {
                    valueDownButton.setFocus();
                } else {
                    musicOrNot.setFocus();
                }
            }

            onSelectPressed: {
                if (exerciseTimer.running) {
                    // stop play exercise
                    fitPlayerMusic.abort();
                    return exerciseTimer.resetDataPlayTimer();
                }

                fit.showNotification(appLangs.texts[fit.lang].startFirstCircle);
                exerciseTimer.start();
                if (musicOrNot.music) {
                    fitPlayerMusic.playMusicByUrl(appMain.config.main + "/videos/music_" + (Math.floor(Math.random() * 5) + 1) + ".mp4");
                }
                startExerciseButton.setFocus();
                // stats
                appMain.httpServer(appMain.config.api.stats, "GET", { type: "exercise_play" }, "startButton", () => {});
            }
        }

        /**
        * Exercise music Value Down Button
        */
        Button {
            id: valueDownButton;
            anchors.top: parent.top;
            anchors.right: musicOrNot.left;
            anchors.rightMargin: appMain.sizes.margin / 2;

            color: activeFocus ? appMain.theme.light.background : appMain.theme.dark.layout_background;
            text: "-";
            radius: appMain.sizes.radius;
            visible: musicOrNot.music;
            width: 50;
            opacity: activeFocus ? 1.0 : appMain.config.inactiveOpacity;
            font: Font {
                pixelSize: 30;
            }

            onKeyPressed: {
                if (key === "Up") {
                    imagesGalary.setFocus();
                } else if (key === "Left") {
                    startExerciseButton.setFocus();
                } else if (key === "Right") {
                    musicOrNot.setFocus();
                } else if (key === "Select") {
                    mainWindow.volumeDown();
                }
            }
        }

        /**
        * Exercise music ON/OFF Button
        */
        Button {
            id: musicOrNot;
            anchors.top: parent.top;
            anchors.right: valueUpButton.left;
            anchors.rightMargin: appMain.sizes.margin / 2;

            property bool music: false; 

            color: activeFocus ? appMain.theme.light.background : appMain.theme.dark.layout_background;
            text: music ? appLangs.texts[fit.lang].withMusic : appLangs.texts[fit.lang].noMusic;
            radius: appMain.sizes.radius;
            visible: true;
            opacity: activeFocus ? 1.0 : appMain.config.inactiveOpacity;
            font: Font {
                pixelSize: 25;
            }

            onKeyPressed: {
                if (key === "Up") {
                    imagesGalary.setFocus();
                } else if (key === "Left") {
                    if (musicOrNot.music) {
                        valueDownButton.setFocus();
                    } else {
                        startExerciseButton.setFocus();
                    }
                } else if (key === "Right") {
                    valueUpButton.setFocus();
                } else if (key === "Select") {
                    musicOrNot.music = !musicOrNot.music;
                    if (!musicOrNot.music) {
                        fitPlayerMusic.abort();
                    }
                    if (musicOrNot.music && exerciseTimer.running) {
                        fitPlayerMusic.playMusicByUrl(appMain.config.main + "/videos/music_" + (Math.floor(Math.random() * 5) + 1) + ".mp4");
                        musicOrNot.setFocus();
                    }
                    save("fit_music", JSON.stringify({ music: musicOrNot.music}));
                }
            }

            onCompleted: {
                musicOrNot.music = JSON.parse(load("fit_music") || "{}").music ? true : false;
            }
        }

        /**
        * Exercise music Value Up Button
        */
        Button {
            id: valueUpButton;
            anchors.top: parent.top;
            anchors.right: parent.right;
            anchors.rightMargin: appMain.sizes.margin;

            color: activeFocus ? appMain.theme.light.background : appMain.theme.dark.layout_background;
            text: "+";
            radius: appMain.sizes.radius;
            visible: musicOrNot.music;
            width: 50;
            opacity: activeFocus ? 1.0 : appMain.config.inactiveOpacity;
            font: Font {
                pixelSize: 30;
            }

            onKeyPressed: {
                if (key === "Up") {
                    imagesGalary.setFocus();
                } else if (key === "Left") {
                    musicOrNot.setFocus();
                } else if (key === "Select") {
                    mainWindow.volumeUp();
                }
            }
        }

        /**
        * Exercise Progress Bar
        */
        ProgressBarController {
            id: progress;
            anchors.top: startExerciseButton.bottom;
            anchors.left: playZone.left;
            anchors.right: playZone.right;
            anchors.topMargin: appMain.sizes.margin / 2;

            barColor: appMain.theme.light.background;
            height: 50;
            progress: 0.0;
            animationDuration: 1000;
            radius: 0;

            /**
            * Exercise Progress Bar Text
            */
            Text {
                id: progressText;
                anchors.centerIn: progress;

                color: appMain.theme.light.textColor;
                text: "00:00:00";
                font: Font {
                    family: "Proxima Nova Condensed";
                    pixelSize: 36;
                    black: true;
                }
            }
        }

        /**
        * Exercise play zone timer
        */
        Timer {
            id: exerciseTimer;
            property bool exercise: true;
            property int timerExercise: 0;
            property int timerRelax: 15000;
            property int rounds: 1;
            interval: 1000;
            repeat: true;
            
            onTriggered: {
                // stop if fullscreen closed
                if (!fit.fullscreen) {
                    exerciseTimer.resetDataPlayTimer();
                    fitPlayerMusic.abort();

                    return fit.showNotification(appLangs.texts[fit.lang].playExerciseClosed);
                }

                // stop when 3 round finished
                if (exerciseTimer.rounds === 4) {
                    exerciseTimer.resetDataPlayTimer();
                    fitPlayerMusic.abort();
                    return fit.showNotification(appLangs.texts[fit.lang].finishedExercise);
                }

                // time to do exercise
                if (exerciseTimer.exercise) {
                    exerciseTimer.timerExercise += interval;
                    progress.progress = (exerciseTimer.timerExercise / 30000).toFixed(3);

                    // stop, when exercise time over and run relax time
                    if (exerciseTimer.timerExercise === 30000) {
                        progress.reset();
                        exerciseTimer.exercise = false;
                        exerciseTimer.timerExercise = 0;

                        // show notification on first round starts
                        if (exerciseTimer.rounds === 1) {
                            fit.showNotification(appLangs.texts[fit.lang].relaxCircle);
                        }
                    }
                }

                // time to relax
                if (!exerciseTimer.exercise) {
                    exerciseTimer.timerRelax -= interval;
                    progress.progress = (exerciseTimer.timerRelax / 15000).toFixed(3);

                    // stop, when relax time over
                    if (exerciseTimer.timerRelax === 0) {
                        progress.reset();
                        exerciseTimer.exercise = true;
                        exerciseTimer.timerRelax = 15000;
                        exerciseTimer.rounds += 1;

                        // show notification on new round starts
                        if (exerciseTimer.rounds === 2) {
                            fit.showNotification(appLangs.texts[fit.lang].startSecondCircle);
                        }
                        if (exerciseTimer.rounds === 3) {
                            fit.showNotification(appLangs.texts[fit.lang].startThirdCircle);
                        }
                    }
                }

                const time = new Date(exerciseTimer.exercise ? exerciseTimer.timerExercise : exerciseTimer.timerRelax);
                progressText.text = time.toISOString().substr(11, 8);
            }

            function resetDataPlayTimer() {
                exerciseTimer.rounds = 1;
                exerciseTimer.timerExercise = 0;
                exerciseTimer.timerRelax = 15000;
                progressText.text = "00:00:00";
                progress.progress = 0;
                exerciseTimer.stop();
            }
        }
    }

    Image {
        z: 4;

        anchors.top: mainView.top;
        anchors.right: mainView.right;
        anchors.margins: appMain.sizes.margin;

        width: 35;
        height: 25;

        visible: true;
        registerInCacheSystem: false;
        source: exerciseDetail.bookmark ? "apps/fit_app/res/heart_added.png" : "apps/fit_app/res/heart_add.png";
        fillMode: PreserveAspectFit;
    }

    onKeyPressed: {
        if (key === "Red" && exerciseDetail.page === "workout") {
            let current = workoutItems.model.get(workoutItems.currentIndex);
            appMain.addToBookmark(current, "exercise", exerciseDetail.page, (boolean) => {
                exerciseDetail.bookmark = boolean;
            });
        } 
        if (key === "Red" && exerciseDetail.page === "main") {
            let current = exerciseItemsList.exerciseItemModel.get(exerciseItemsList.currentIndex);
            appMain.addToBookmark(current, "exercise", exerciseDetail.page, (boolean) => {
                exerciseDetail.bookmark = boolean;
            });
        }
    }

    onVisibleChanged: {
        // stop music
        fitPlayerMusic.abort();
        // stop play exercise
        exerciseTimer.resetDataPlayTimer();
        // reset galary images and add new if exist
        imagesGalary.model.reset();
        imagesGalary.zoom = false;
        if (visible) {
            exerciseDetail.images.forEach((img, index) => {
                index += 1;
                imagesGalary.model.append({
                    id: index,
                    image: img
                });
            imagesGalary.setFocus();
            });

            imagesGalary.setFocus();
            imagesGalary.setFocus();
        }

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