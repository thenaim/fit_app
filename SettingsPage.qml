import "js/app.js" as app;
import controls.Button;

Item {
    id: settingPageItem;
    property string id;
    property bool vkIntegrated;

    z: 10;
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
            text: "ID: " + settingPageItem.id;
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
            text: "ВК не интегрирован.";
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
            text: "Телеграм не интегрирован.";
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
            text: app.texts.settingInfo;
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
            text: "Инструкция:";
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
            text: app.texts.appFunctions.join("\r\n");
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
        text: fit.isDark ? "Оформление: Тёмная тема" : "Оформление: Светлая тема";
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
        text: "Питание: Наращивание мышц";
        radius: app.sizes.radius;
        width: 400;

        onUpPressed: {
            themeChanger.setFocus();
        }

        onDownPressed: {
            reloadIntegrated.setFocus();
        }

        onSelectPressed: {
            if (load("nutrition_type") === "muscle_building") {
                save("nutrition_type", "weight_loss");
                nutritionTypeButton.text = "Питание: Снижение веса";
                fit.showNotification("Питание изменены на Снижение веса");
            } else {
                save("nutrition_type", "muscle_building");
                nutritionTypeButton.text = "Питание: Наращивание мышц";
                fit.showNotification("Питание изменены на Наращивание мышц");
            }
        }
    }

    /**
    * Check integration
    */
    Button {
        id: reloadIntegrated;
        z: 1;

        anchors.top: nutritionTypeButton.bottom;
        anchors.right: settingPageItem.right;
        anchors.topMargin: app.sizes.margin;

        opacity: reloadIntegrated.activeFocus ? 1.0 : app.config.inactiveOpacity;
        color: reloadIntegrated.activeFocus ? app.theme.light.background : app.theme.dark.layout_background;
        text: "Проверить интеграцию";
        radius: app.sizes.radius;
        width: 400;

        onUpPressed: {
            nutritionTypeButton.setFocus();
        }

        onSelectPressed: {
            reloadIntegrated.text = "Обновляем...";
            reloadingTimer.start();
            fit.loading = true;

            fit.appInit((callback) => {
                if (callback) {
                    settingPageItem.checkVkAndTelegram();
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
            reloadIntegrated.text = "Проверить интеграцию";
			this.stop();
		}
	}

    /**
    * Update theme function
    */
    function updateTheme(isDark) {
        if (isDark) {
            fit.showNotification("Тёмная тема активирована");
        } else {
            fit.showNotification("Светлая тема активирована");
        }
        fit.loading = true;
        app.httpServer(app.config.api.themeChange, "GET", { isDark: isDark }, "updateTheme", (theme) => {

            if (theme.changed) {
                fit.stingray.isDark = isDark;
                fit.isDark = isDark;
            };

            fit.loading = false;
            themeChanger.setFocus();
        });
    }

    /**
    * Get App settings
    */
    function checkVkAndTelegram() {
        const stingray = JSON.parse(load("fit_stingray"));
        settingPageItem.id = stingray.id;

        stingray.vkIntegrated ? vkIntegratedOrNot.text = "ВК интегрирован." : vkIntegratedOrNot.text = "ВК не интегрирован.";
        stingray.tgIntegrated ? tgIntegratedOrNot.text = "Телеграм интегрирован." : tgIntegratedOrNot.text = "Телеграм не интегрирован.";
    }

    onVisibleChanged: {
        settingPageItem.checkVkAndTelegram();
        themeChanger.setFocus();
    }
}