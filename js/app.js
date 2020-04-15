/**
 * Server adress with IPv4 (for local tests)
 */

const server = "http://192.168.1.70:8080";

/**
 * App config
 */
this.config = {
    token: "eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4",
    static: server + "/static",
    api: {
        stingray: server + "/stingray",
        watch: server + "/videos/watch",
        exercises: server + "/exercises",
        exercisesCategories: server + "/exercise/categories",
        addDeleteBookmark: server + "/bookmarks/addDelete",
        nutritionSend: server + "/nutrition/send",
        exerciseSend: server + "/exercise/send",
        themeChange: server + "/settings/themechange"
    },
    animationDuration: 150,
    inactiveOpacity: 0.6,
    defaultImage: "apps/fit_app/res/default_video_image.png"
};

/**
 * App config
 */
this.texts = {
    integrateSendVk: "Отправить упражнение в ВК",
    notIntegrateSendVk: "Чтобы отправить интегрируйте приложение с ВК",
    sended: "Отправлено!",
    nutritionSended: "Ретцепт успешно отправлен!",
    fullNutritionSend: "Отправить полный ретцепт в ВК",
    checkIntegration: "Проверить интеграцию",
    settingInfo: "Mожно отправлять упражнения, рецепты и много другое.\nБот ВК: https://vk.com/fit_smart_bot.\nБот Телеграм: https://t.me/fit_smart_bot.\nДля подключения нужно отправит ID приложения.",
    appFunctions: [
        "1. Функция сделать полный экран. Это синяя кнопка на пульте.",
        "2. Добавить в закладки. Это краная кнопка на пульте."
    ],

    doFullscreen: "-- Сделайте полный экран, чтобы посмотреть полную инструкцию упражнения ---"
};

/**
 * App tabs
 */
this.tabs = [{
        id: "video",
        title: "Видео",
        url: server + "/videos"
    },
    {
        id: "exercises",
        title: "Упражнения",
        url: server + "/exercises"
    },
    {
        id: "nutrition",
        title: "Питание",
        url: server + "/nutritions"
    },
    {
        id: "bookmark",
        title: "Закладки",
        url: server + "/bookmarks"
    },
    {
        id: "stats",
        title: "Статистика",
        url: server + "/stats"
    },
    {
        id: "setting",
        title: "Настройки",
        url: server + "/settings"
    }
];

/**
 * Theme colors - light and dark
 */
this.theme = {
    active: "#3F0B81",
    light: {
        background: "#03E4A1",
        textColor: "#000000",
        border_color: "#989aa2",
        item_background: "#ffffff",
        layout_background: "#f2f2f2"
    },
    dark: {
        background: "#121212",
        textColor: "#ffffff",
        border_color: "#222222",
        item_background: "#1A1B1E",
        layout_background: "#0d0d0d"
    }
};

/**
 * App sizes
 */
this.sizes = {
    menuWidth: 320,
    margin: 20,
    radius: 20,
    poster: {
        width: 295,
        height: 166
    },
    tabCards: {
        width: 180,
        height: 120
    },
    chips: {
        width: 170,
        height: 100
    },
    exercise: {
        width: 280,
        height: 280
    },
    nutrition: {
        width: 285,
        height: 260,
    }
};

/**
 * Wrap text
 * @param  {String} s string to wrap
 * @return {String} Wraped text with '\n'
 */
this.wrapText = (text, maxLength) => {
    text += "";
    const result = [];
    let line = [],
        length = 0;
    text.split(" ").forEach((word) => {
        if ((length + word.length) >= maxLength) {
            result.push(line.join(" "));
            line = [];
            length = 0;
        }
        length += word.length + 1;
        line.push(word);
    });
    if (line.length > 0) {
        result.push(line.join(" "));
    }
    return result.join("\n");
};

/**
 * Format params
 * Set auth token and stingray id
 * 
 * @param  {Object} params
 * @return {String} formated params like "?a=1&b=2&c=3"
 */
this.formatParams = (url, params) => {
    let stingray = JSON.parse(load("fit_stingray") || "{}");

    params.token = this.config.token;
    params.stingray = stingray.id || "";

    return url + "?" + Object
        .keys(params)
        .map(function (key) {
            return key + "=" + encodeURIComponent(params[key]);
        })
        .join("&");
};

/**
 * Function to callback httpServer requests
 * @param  {String} url, method, body
 * @return {Function} callback with http result
 */
this.httpServer = (url, method, params, functionName, callback) => {
    url = this.formatParams(url, params);

    const http = new XMLHttpRequest();
    http.setRequestHeader("Content-Type", "application/json");
    http.setRequestHeader("X-Requested-With", "XMLHttpRequest");
    http.timeout = 10000;

    http.onreadystatechange = () => {
        if (http.readyState === 4) {
            if (http.status === 200) {
                return callback(JSON.parse(http.responseText));
            }
            log("\n----",
                "\nError http server status:", http.status,
                "\nFunction name:", functionName,
                "\nError url:", url,
                "\nText response:", http.responseText ? http.responseText : null,
                "\n----");
            return callback(false);
        }

    };

    http.onerror = function (e) {
        log("Error [httpServer function]", url);
    };

    http.open(method, url, true);
    http.send();
};

/**
 * On change tab select page
 */
this.onTabChange = () => {
    const tabCurrent = {
        index: tab.currentIndex,
        data: model.get(tab.currentIndex)
    };

    switch (tabCurrent.data.id) {
        case "video":
            videoItems.visible = true;
            exercisesPageContainer.visible = false;
            nutritionPageContainer.visible = false;
            statsPage.visible = false;
            settingPage.visible = false;
            videoItems.setFocus();
            videoItems.getVideos(tabCurrent.data.url);
            break;
        case "exercises":
            videoItems.visible = false;
            exercisesPageContainer.visible = true;
            nutritionPageContainer.visible = false;
            statsPage.visible = false;
            settingPage.visible = false;
            exercisesPageContainer.setFocus();
            exercisesPageContainer.getChipsAndExercises("Abs");
            break;
        case "nutrition":
            videoItems.visible = false;
            exercisesPageContainer.visible = false;
            nutritionPageContainer.visible = true;
            statsPage.visible = false;
            settingPage.visible = false;
            nutritionDays.setFocus();
            nutritionItemsList.getNutritions();
            break;
        case "bookmark":
            videoItems.visible = true;
            exercisesPageContainer.visible = false;
            nutritionPageContainer.visible = false;
            statsPage.visible = false;
            settingPage.visible = false;
            videoItems.setFocus();
            videoItems.getVideos(tabCurrent.data.url);
            break;
        case "stats":
            statsPage.visible = true;
            videoItems.visible = false;
            exercisesPageContainer.visible = false;
            nutritionPageContainer.visible = false;
            settingPage.visible = false;
            statsPage.setFocus();
            break;
        case "setting":
            videoItems.visible = false;
            exercisesPageContainer.visible = false;
            nutritionPageContainer.visible = false;
            statsPage.visible = false;

            fit.appInit((callback) => {
                if (callback) {
                    settingPage.visible = true;
                    settingPage.setFocus();
                }
            });

            break;
        default:
            break;
    }
};

/**
 * On select video add to bookmark
 */
this.addVideoToBookmark = (current) => {
    fit.loading = true;
    this.httpServer(app.config.api.addDeleteBookmark, "GET", {
        videoId: current.videoId
    }, "Add bookmark key: Red", (book) => {

        if (book.added) {
            current.bookmark = true;
            fit.showNotification("Видео успешно сохранено в закладках");
        }

        if (book.deleted) {
            current.bookmark = false;
            fit.showNotification("Видео успешно удалено из закладки");
        }

        videoItems.model.remove(videoItems.currentIndex, 1);
        videoItems.model.insert(videoItems.currentIndex, current);

        fit.loading = false;
        videoItems.setFocus();
    });
};