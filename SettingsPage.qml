import "js/app.js" as app;
import controls.Button;

Item {
    id: settingPageItem;
    property string id;
    property string integrated;
    z: 10;
    opacity: activeFocus ? 1.0 : app.config.inactiveOpacity;
    width: 300;
    width: 600;


    Button {
        id: themeChanger;

        anchors.top: settingPageItem.top;
        anchors.left: settingPageItem.left;

        opacity: activeFocus ? 1.0 : app.config.inactiveOpacity;

        color: fit.isDark ? app.theme.light.background : "#4680C2";

        text: fit.isDark ? "Изменить тему на: светлую" : "Изменить тему на: тёмную";

        onDownPressed: {
            log("onDownPressed button pressed");
        }

        onSelectPressed: {
            fit.stingray.isDark = !fit.stingray.isDark;
            settingPageItem.updateTheme(fit.stingray.isDark)
        }
    }

    Text {
        id: integrateText;
        z: 3;

        anchors.top: themeChanger.bottom;
        anchors.left: themeChanger.left;
        anchors.topMargin: app.sizes.margin;

        opacity: 1;
        visible: true;
        color: fit.isDark ? app.theme.dark.textColor : app.theme.light.textColor;
        text: "ID: " + settingPageItem.id;
        wrapMode: Text.WordWrap;

        font: Font {
            family: "Times";
            pixelSize: 26;
            black: true;
        }
    }

    Text {
        id: integrateTextDes;
        z: 3;

        anchors.top: integrateText.bottom;
        anchors.left: integrateText.left;
        anchors.topMargin: app.sizes.margin;

        opacity: 1;
        visible: true;
        color: fit.isDark ? app.theme.dark.textColor : app.theme.light.textColor;
        text: settingPageItem.integrated === true ? "Интегрирован с ВК" : "Не интегрирован с ВК\nПереходите в группу: https://vk.com/fit_Smart.\nДля подключения нужно отправит ID приложения.";
        wrapMode: Text.WordWrap;

        font: Font {
            family: "Times";
            pixelSize: 26;
            black: true;
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

    function updateTheme(isDark) {
        fit.loading = true;
        app.httpServer(app.config.api.themeChange, "GET", { stingray: load("stingray"), token: app.config.token, isDark: isDark }, (theme) => {

            if (theme.changed) {
                fit.stingray.isDark = isDark;
                fit.isDark = isDark;
                log(fit.isDark);
            };

            fit.loading = false;
            themeChanger.setFocus();
        });
    }

    onVisibleChanged: {
        log(settingPageItem.integrated);
        themeChanger.setFocus();
    }
}