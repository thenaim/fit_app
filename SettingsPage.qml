import "js/app.js" as app;
import "js/languages.js" as appLangs;

import controls.Button;

Item {
    id: settingPageItem;
    z: 4;
    opacity: activeFocus ? 1.0 : app.config.inactiveOpacity;
    width: 600;

    /**
    * FitSmart logo
    */
    Image {
        id: fitSmartImage;
        anchors.top: settingPageItem.top;
        anchors.topMargin: -app.sizes.margin;
        anchors.horizontalCenter: settingPage.horizontalCenter;

        async: false;
        source: fit.isDark ? "apps/fit_app/res/dark_logo.png" : "apps/fit_app/res/light_logo.png";
    }

    /**
    * Setting page infos
    */
    Item {
        id: settingTexts;
        z: 3;
        anchors.top: fitSmartImage.bottom;
        anchors.left: settingPageItem.left;
        width: 600;

        Text {
            id: integrateText;
            anchors.top: settingTexts.top;
            anchors.left: settingTexts.left;

            opacity: 1;
            visible: true;
            color: fit.isDark ? app.theme.dark.textColor : app.theme.light.textColor;
            text: "ID: " + fit.stingray["id"];
            font: Font {
                family: "Proxima Nova Condensed";
                pixelSize: 28;
                black: true;
            }
        }

        Text {
            id: vkIntegratedOrNot;
            anchors.top: integrateText.bottom;
            anchors.left: integrateText.left;
            anchors.topMargin: app.sizes.margin / 2;

            opacity: 1;
            visible: true;
            color: fit.stingray["vkIntegrated"] ? app.theme.light.background : fit.isDark ? app.theme.dark.textColor : app.theme.light.textColor;
            text: fit.stingray["vkIntegrated"] ? appLangs.texts[fit.lang].vkIntegrated : appLangs.texts[fit.lang].vkNotIntegrated;
            font: Font {
                family: "Proxima Nova Condensed";
                pixelSize: 26;
                black: true;
            }
        }

        Text {
            id: tgIntegratedOrNot;
            anchors.top: vkIntegratedOrNot.bottom;
            anchors.left: vkIntegratedOrNot.left;

            opacity: 1;
            visible: true;
            color: fit.stingray["tgIntegrated"] ? app.theme.light.background : fit.isDark ? app.theme.dark.textColor : app.theme.light.textColor;
            text: fit.stingray["tgIntegrated"] ? appLangs.texts[fit.lang].tgIntegrated : appLangs.texts[fit.lang].tgNotIntegrated;
            font: Font {
                family: "Proxima Nova Condensed";
                pixelSize: 26;
                black: true;
            }
        }

        Text {
            id: settingMoreInfo;
            anchors.top: tgIntegratedOrNot.bottom;
            anchors.left: tgIntegratedOrNot.left;
            anchors.topMargin: app.sizes.margin / 2;

            opacity: 1;
            visible: true;
            color: fit.isDark ? app.theme.dark.textColor : app.theme.light.textColor;
            text: appLangs.texts[fit.lang].settingInfo;
            font: Font {
                family: "Proxima Nova Condensed";
                pixelSize: 26;
                black: true;
            }
        }

        Text {
            id: infoTitleText;
            anchors.top: settingMoreInfo.bottom;
            anchors.left: settingMoreInfo.left;
            anchors.topMargin: app.sizes.margin;

            opacity: 1;
            visible: true;
            color: fit.isDark ? app.theme.dark.textColor : app.theme.light.textColor;
            text: appLangs.texts[fit.lang].instruction + ":";
            wrapMode: Text.WordWrap;
            font: Font {
                family: "Proxima Nova Condensed";
                pixelSize: 30;
                black: true;
            }
        }

        Text {
            id: infoTextDes;
            anchors.top: infoTitleText.bottom;
            anchors.left: infoTitleText.left;
            anchors.topMargin: app.sizes.margin / 2;

            opacity: 1;
            visible: true;
            color: fit.isDark ? app.theme.dark.textColor : app.theme.light.textColor;
            text: appLangs.texts[fit.lang].appFunctions.join("\r\n");
            font: Font {
                family: "Proxima Nova Condensed";
                pixelSize: 24;
                black: true;
            }
        }
    }

    /**
    * Theme changer button
    */
    Button {
        id: themeChanger;
        z: 1;
        anchors.top: fitSmartImage.bottom;
        anchors.right: settingPageItem.right;

        opacity: themeChanger.activeFocus ? 1.0 : app.config.inactiveOpacity;
        color: themeChanger.activeFocus ? app.theme.light.background : app.theme.dark.layout_background;
        text: fit.isDark ? appLangs.texts[fit.lang].activeThemeDark : appLangs.texts[fit.lang].activeThemeLight;
        radius: app.sizes.radius;
        width: 400;
        onUpPressed: {
            tab.setFocus();
        }

        onDownPressed: {
            nutritionTypeButton.setFocus();
        }

        onSelectPressed: {
            let themesList = [];
            app.themesList.forEach(element => {
                themesList.push({ id: element.id, data: element.data[fit.lang]})
            });
            fit.modalController.openModal(themesList, "theme", "");
        }
    }

    /**
    * Nutrition type
    */
    Button {
        id: nutritionTypeButton;
        z: 1;
        anchors.top: themeChanger.bottom;
        anchors.right: settingPageItem.right;
        anchors.topMargin: app.sizes.margin / 1.5;

        opacity: nutritionTypeButton.activeFocus ? 1.0 : app.config.inactiveOpacity;
        color: nutritionTypeButton.activeFocus ? app.theme.light.background : app.theme.dark.layout_background;
        text: fit.stingray["meal"] ? appLangs.texts[fit.lang].nutritionMuscleBuilding : appLangs.texts[fit.lang].nutritionWeightLoss;
        radius: app.sizes.radius;
        width: 400;

        onUpPressed: {
            themeChanger.setFocus();
        }

        onDownPressed: {
            genderTypeButton.setFocus();
        }

        onSelectPressed: {
            let nutritionTypes = [];
            app.nutritionTypes.forEach(element => {
                nutritionTypes.push({ id: element.id, data: element.data[fit.lang]})
            });
            return fit.modalController.openModal(nutritionTypes, "nutrition_type", "");
        }
    }

    /**
    * Gender type
    */
    Button {
        id: genderTypeButton;
        z: 1;

        anchors.top: nutritionTypeButton.bottom;
        anchors.right: settingPageItem.right;
        anchors.topMargin: app.sizes.margin / 1.5;

        opacity: genderTypeButton.activeFocus ? 1.0 : app.config.inactiveOpacity;
        color: genderTypeButton.activeFocus ? app.theme.light.background : app.theme.dark.layout_background;
        text: fit.stingray["gender"] !== "man" ? appLangs.texts[fit.lang].genderFemale : appLangs.texts[fit.lang].genderMale;
        radius: app.sizes.radius;
        width: 400;

        onUpPressed: {
            nutritionTypeButton.setFocus();
        }

        onDownPressed: {
            workoutTypeButton.setFocus();
        }

        onSelectPressed: {
            let genderList = [];
            app.gender.forEach(element => {
                genderList.push({ id: element.id, data: element.data[fit.lang]})
            });
            return fit.modalController.openModal(genderList, "gender", "");
        }
    }

    /**
    * Workout day
    */
    Button {
        id: workoutTypeButton;
        z: 1;

        anchors.top: genderTypeButton.bottom;
        anchors.right: settingPageItem.right;
        anchors.topMargin: app.sizes.margin / 1.5;

        opacity: workoutTypeButton.activeFocus ? 1.0 : app.config.inactiveOpacity;
        color: workoutTypeButton.activeFocus ? app.theme.light.background : app.theme.dark.layout_background;
        text: (fit.lang === "ru") ? appLangs.texts[fit.lang].workoutDay + " - " + workoutTypeButton.getDay(fit.stingray["workoutDays"]) + " дня в неделю" : appLangs.texts[fit.lang].workoutDay + " - " + workoutTypeButton.getDay(fit.stingray["workoutDays"]) + " days per week";
        radius: app.sizes.radius;
        width: 400;

        onUpPressed: {
            genderTypeButton.setFocus();
        }

        onDownPressed: {
            languageTypeButton.setFocus();
        }

        onSelectPressed: {
            fit.loading = true;
            app.httpServer(app.config.api.workoutsDays, "GET", {}, "getWorkouts", (days) => {
                if (days.length) {
                    fit.modalController.itemsWillBeInModal = 4;
                    fit.modalController.openModal(days, "workouts_type");
                }

                fit.loading = false;
            });
        }

        function getDay(day) {
            if (day === 1) {
                day = 2;
            } else if (day === 2) {
                day = 3;
            } else if (day === 3) {
                day = 4;
            }
            return day;
        }
    }

    /**
    * Language type
    */
    Button {
        id: languageTypeButton;
        z: 1;

        anchors.top: workoutTypeButton.bottom;
        anchors.right: settingPageItem.right;
        anchors.topMargin: app.sizes.margin / 1.5;

        opacity: languageTypeButton.activeFocus ? 1.0 : app.config.inactiveOpacity;
        color: languageTypeButton.activeFocus ? app.theme.light.background : app.theme.dark.layout_background;
        text: appLangs.texts[fit.lang].language;
        radius: app.sizes.radius;
        width: 400;

        onUpPressed: {
            workoutTypeButton.setFocus();
        }

        onDownPressed: {
            themeChanger.setFocus();
        }

        onSelectPressed: {
            fit.modalController.openModal(appLangs.languages, "language");
        }
    }

    Timer {
		id: checkIntegrationTimer;
		interval: 4000;
		repeat: true;
		running: false;

		onTriggered: {
            fit.appInit((callback) => {
                if (callback) {
                    fit.loading = false;
                }
            });
		}
	}

    onVisibleChanged: {
        themeChanger.setFocus();
        checkIntegrationTimer.stop();

        if (visible) {
            checkIntegrationTimer.start();
        }
    }
}