import "js/app.js" as app;
import controls.Button;

Item {
    id: settingPageItem;
    property string id;
    property bool vkIntegrated;

    property string integratedText: "Интегрирован с ВК\nТеперь можно отправлять упражнения, рецепты и много другое.";
    property string notIntegratedText: "Не интегрирован с ВК\nПереходите в группу: https://vk.com/fit_Smart.\nДля подключения нужно отправит ID приложения.";
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

    Item {
        id: settingTexts;
        anchors.top: fitSmartImage.bottom;
        anchors.left: settingPageItem.left;
        width: 600;

        Text {
            id: mainInfoText;
            z: 3;

            anchors.top: settingTexts.top;
            anchors.left: settingTexts.left;
            anchors.topMargin: app.sizes.margin;

            opacity: 1;
            visible: true;
            color: fit.isDark ? app.theme.dark.textColor : app.theme.light.textColor;
            text: "Информация:";
            wrapMode: Text.WordWrap;

            font: Font {
                family: "Times";
                pixelSize: 30;
                black: true;
            }
        }

        Text {
            id: integrateText;
            z: 3;

            anchors.top: mainInfoText.bottom;
            anchors.left: mainInfoText.left;
            anchors.topMargin: app.sizes.margin / 2;

            opacity: 1;
            visible: true;
            color: fit.isDark ? app.theme.dark.textColor : app.theme.light.textColor;
            text: "ID: " + settingPageItem.id;
            wrapMode: Text.WordWrap;

            font: Font {
                family: "Times";
                pixelSize: 28;
                black: true;
            }
        }

        Text {
            id: integrateTextDes;
            z: 3;

            anchors.top: integrateText.bottom;
            anchors.left: integrateText.left;
            anchors.topMargin: app.sizes.margin / 2;

            opacity: 1;
            visible: true;
            color: fit.isDark ? app.theme.dark.textColor : app.theme.light.textColor;
            text: "";
            wrapMode: Text.WordWrap;

            font: Font {
                family: "Times";
                pixelSize: 26;
                black: true;
            }
        }

        Text {
            id: infoTitleText;
            z: 3;

            anchors.top: integrateTextDes.bottom;
            anchors.left: integrateTextDes.left;
            anchors.topMargin: app.sizes.margin;

            opacity: 1;
            visible: true;
            color: fit.isDark ? app.theme.dark.textColor : app.theme.light.textColor;
            text: "Инструкция:";
            wrapMode: Text.WordWrap;

            font: Font {
                family: "Times";
                pixelSize: 30;
                black: true;
            }
        }

        Text {
            id: infoTextDes;
            z: 3;

            anchors.top: infoTitleText.bottom;
            anchors.left: infoTitleText.left;
            anchors.topMargin: app.sizes.margin / 2;

            opacity: 1;
            visible: true;
            color: fit.isDark ? app.theme.dark.textColor : app.theme.light.textColor;
            text: app.texts.appFunctions.join("\r\n");
            wrapMode: Text.WordWrap;

            font: Font {
                family: "Times";
                pixelSize: 24;
                black: true;
            }
        }
    }

    Button {
        id: themeChanger;
        anchors.top: fitSmartImage.bottom;
        anchors.right: settingPageItem.right;

        opacity: activeFocus ? 1.0 : app.config.inactiveOpacity;
        color: activeFocus ? app.theme.active : app.theme.light.background;
        text: fit.isDark ? "Изменить тему на: светлую" : "Изменить тему на: тёмную";
        radius: app.sizes.radius;
        width: 400;
        onUpPressed: {
            tab.setFocus();
        }

        onDownPressed: {
            reloadIntegrated.setFocus();
        }

        onSelectPressed: {
            fit.stingray.isDark = !fit.stingray.isDark;
            settingPageItem.updateTheme(fit.stingray.isDark)
        }
    }

    Button {
        id: reloadIntegrated;

        anchors.top: themeChanger.bottom;
        anchors.right: settingPageItem.right;
        anchors.topMargin: app.sizes.margin;

        opacity: activeFocus ? 1.0 : app.config.inactiveOpacity;
        color: activeFocus ? app.theme.active : app.theme.light.background;
        text: "Проверить интеграцию";
        radius: app.sizes.radius;
        width: 400;

        onUpPressed: {
            themeChanger.setFocus();
        }

        onSelectPressed: {
            reloadIntegrated.text = "Обновляем...";
            reloadingTimer.start();
            fit.loading = true;

            fit.appInit((callback) => {
                if (callback) {
                    if (load("fit_integratedVk")) {
                        integrateTextDes.text = settingPageItem.integratedText;
                    } else {
                        integrateTextDes.text = settingPageItem.notIntegratedText;
                    }
                    fit.loading = false;
                }
            });
        }
    }

    Image {
        id: settingThemeLogo;
        z: 1;
        opacity: 0.4;

        anchors.bottom: settingPageItem.bottom;
        anchors.bottomMargin: -20;
        anchors.horizontalCenter: settingPageItem.horizontalCenter;
        height: 300;

        registerInCacheSystem: false;
        async: false;
        fillMode: PreserveAspectFit;

        source: "apps/fit_app/res/mode_" + (fit.isDark ? "dark.png" : "light.png");

        Behavior on width  { animation: Animation { duration: app.config.animationDuration; } }
        Behavior on height { animation: Animation { duration: app.config.animationDuration; } }
    }

    Timer {
		id: reloadingTimer;
		interval: 800;
		repeat: false;
		running: false;

		onTriggered: {
            reloadIntegrated.text = "Проверить интеграцию";
			this.stop();
		}
	}

    function updateTheme(isDark) {
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

    onVisibleChanged: {
        if (load("fit_integratedVk")) {
            integrateTextDes.text = settingPageItem.integratedText;
        } else {
            integrateTextDes.text = settingPageItem.notIntegratedText;
        }
        themeChanger.setFocus();
    }
}