import "js/app.js" as app;
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
            wrapMode: Text.WordWrap;

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
            color: fit.isDark ? app.theme.dark.textColor : app.theme.light.textColor;
            text: fit.stingray["vkIntegrated"] ? app.texts[fit.lang].vkIntegrated : app.texts[fit.lang].vkNotIntegrated;
            wrapMode: Text.WordWrap;

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
            color: fit.isDark ? app.theme.dark.textColor : app.theme.light.textColor;
            text: fit.stingray["tgIntegrated"] ? app.texts[fit.lang].tgIntegrated : app.texts[fit.lang].tgNotIntegrated;
            wrapMode: Text.WordWrap;

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
            text: app.texts[fit.lang].settingInfo;
            wrapMode: Text.WordWrap;

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
            text: app.texts[fit.lang].instruction + ":";
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
            text: app.texts[fit.lang].appFunctions.join("\r\n");
            wrapMode: Text.WordWrap;

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
        text: fit.isDark ? app.texts[fit.lang].activeThemeDark : app.texts[fit.lang].activeThemeLight;
        radius: app.sizes.radius;
        width: 400;
        onUpPressed: {
            tab.setFocus();
        }

        onDownPressed: {
            nutritionTypeButton.setFocus();
        }

        onSelectPressed: {
            fit.stingray.isDark = !fit.stingray.isDark;
            settingPageItem.updateTheme(fit.stingray.isDark);
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
        anchors.topMargin: app.sizes.margin;

        opacity: nutritionTypeButton.activeFocus ? 1.0 : app.config.inactiveOpacity;
        color: nutritionTypeButton.activeFocus ? app.theme.light.background : app.theme.dark.layout_background;
        text: fit.stingray["meal"] ? app.texts[fit.lang].nutritionMuscleBuilding : app.texts[fit.lang].nutritionWeightLoss;
        radius: app.sizes.radius;
        width: 400;

        onUpPressed: {
            themeChanger.setFocus();
        }

        onDownPressed: {
            genderTypeButton.setFocus();
        }

        onSelectPressed: {
            let stingray = JSON.parse(load("fit_stingray"));

            app.httpServer(app.config.api.updateStingray, "GET", { meal: !stingray.meal }, "nutrition_type", (res) => {
                if (res.updated) {
                    stingray.meal = !stingray.meal;
                    if (stingray.meal) {
                        fit.showNotification(app.texts[fit.lang].nutritionMuscleBuildingChanged);
                    } else {
                        fit.showNotification(app.texts[fit.lang].nutritionWeightLossChanged);
                    }

                    save("fit_stingray", JSON.stringify(stingray));
                    fit.stingray = JSON.parse(load("fit_stingray"));
                }
            });
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
        anchors.topMargin: app.sizes.margin;

        opacity: genderTypeButton.activeFocus ? 1.0 : app.config.inactiveOpacity;
        color: genderTypeButton.activeFocus ? app.theme.light.background : app.theme.dark.layout_background;
        text: fit.stingray["gender"] !== "man" ? app.texts[fit.lang].genderFemale : app.texts[fit.lang].genderMale;
        radius: app.sizes.radius;
        width: 400;

        onUpPressed: {
            nutritionTypeButton.setFocus();
        }

        onDownPressed: {
            languageTypeButton.setFocus();
        }

        onSelectPressed: {
            let stingray = JSON.parse(load("fit_stingray"));

            app.httpServer(app.config.api.updateStingray, "GET", { gender: stingray.gender === "man" ? "woman" : "man" }, "genderTypeButton", (res) => {
                if (res.updated) {
                    if (stingray.gender === "woman") {
                        stingray.gender = "man";
                        fit.showNotification(app.texts[fit.lang].genderMaleChanged);
                    } else {
                        stingray.gender = "woman";
                        fit.showNotification(app.texts[fit.lang].genderFemaleChanged);
                    }

                    save("fit_stingray", JSON.stringify(stingray));
                    fit.stingray = JSON.parse(load("fit_stingray"));
                }
            });
        }
    }

    /**
    * Language type
    */
    Button {
        id: languageTypeButton;
        z: 1;

        anchors.top: genderTypeButton.bottom;
        anchors.right: settingPageItem.right;
        anchors.topMargin: app.sizes.margin;

        opacity: languageTypeButton.activeFocus ? 1.0 : app.config.inactiveOpacity;
        color: languageTypeButton.activeFocus ? app.theme.light.background : app.theme.dark.layout_background;
        text: app.texts[fit.lang].language;
        radius: app.sizes.radius;
        width: 400;

        onUpPressed: {
            genderTypeButton.setFocus();
        }

        onDownPressed: {
            reloadIntegrated.setFocus();
        }

        onSelectPressed: {
            let stingray = JSON.parse(load("fit_stingray"));

            app.httpServer(app.config.api.updateStingray, "GET", { lang: stingray.lang === "ru" ? "en" : "ru" }, "languageTypeButton", (res) => {
                if (res.updated) {
                    if (stingray.lang === "ru") {
                        stingray.lang = "en";
                        fit.lang = "en";
                        fit.showNotification(app.texts[fit.lang].languageChanged);
                    } else {
                        stingray.lang = "ru";
                        fit.lang = "ru";
                        fit.showNotification(app.texts[fit.lang].languageChanged);
                    }

                    save("fit_stingray", JSON.stringify(stingray));
                    fit.stingray = JSON.parse(load("fit_stingray"));
                }
            });
        }
    }

    /**
    * Check integration
    */
    Button {
        id: reloadIntegrated;
        z: 1;

        anchors.top: languageTypeButton.bottom;
        anchors.right: settingPageItem.right;
        anchors.topMargin: app.sizes.margin;

        opacity: reloadIntegrated.activeFocus ? 1.0 : app.config.inactiveOpacity;
        color: reloadIntegrated.activeFocus ? app.theme.light.background : app.theme.dark.layout_background;
        text: app.texts[fit.lang].checkIntegration;
        radius: app.sizes.radius;
        width: 400;

        onUpPressed: {
            languageTypeButton.setFocus();
        }

        onDownPressed: {
            themeChanger.setFocus();
        }

        onSelectPressed: {
            reloadIntegrated.text = app.texts[fit.lang].reloading;
            reloadingTimer.start();
            fit.loading = true;

            fit.appInit((callback) => {
                if (callback) {
                    fit.loading = false;
                }
            });
        }
    }

    Timer {
		id: reloadingTimer;
		interval: 1000;
		repeat: false;
		running: false;

		onTriggered: {
            reloadIntegrated.text = app.texts[fit.lang].checkIntegration;
			this.stop();
		}
	}

    /**
    * Update theme function
    */
    function updateTheme(isDark) {
        fit.loading = true;
        app.httpServer(app.config.api.themeChange, "GET", { isDark: isDark }, "updateTheme", (theme) => {
            if (theme.changed) {
                fit.stingray.isDark = isDark;
                fit.isDark = isDark;

                if (isDark) {
                    fit.showNotification(app.texts[fit.lang].darkThemeActive);
                } else {
                    fit.showNotification(app.texts[fit.lang].lightThemeActive);
                }
            }

            fit.loading = false;
            themeChanger.setFocus();
        });
    }

    /**
    * Update nutrition type
    */
    function updateMeal() {
        let stingray = JSON.parse(load("fit_stingray"));

        app.httpServer(app.config.api.updateStingray, "POST", { meal: stingray.meal }, "nutrition_type", (res) => {
            if (res.updated) {
                stingray.meal = !stingray.meal;
                if (stingray.meal) {
                    nutritionTypeButton.text = app.texts[fit.lang].nutritionMuscleBuilding;
                    fit.showNotification(app.texts[fit.lang].nutritionMuscleBuildingChanged);
                } else {
                    nutritionTypeButton.text = app.texts[fit.lang].nutritionWeightLoss;
                    fit.showNotification(app.texts[fit.lang].nutritionWeightLossChanged);
                }

                save("fit_stingray", JSON.stringify(stingray));
            }
        });
    }

    onVisibleChanged: {
        themeChanger.setFocus();
        fit.appInit((callback) => {});
    }
}