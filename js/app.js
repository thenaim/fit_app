/**
 * Server adress with IPv4 (for local tests)
 */

const server = "http://ec2-52-15-73-251.us-east-2.compute.amazonaws.com:8080";

/**
 * App config
 */
this.config = {
    token: "eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4",
    main: server,
    static: server + "/static",
    api: {
        stingray: server + "/stingray",
        exercises: server + "/exercises",
        exercisesCategories: server + "/exercise/categories",
        getBookmarks: server + "/bookmarks",
        addDeleteBookmark: server + "/bookmarks/addDelete",
        sendToSocial: server + "/social/send",
        themeChange: server + "/settings/themechange",
        stats: server + "/stats",
        updateStingray: server + "/settings/update/stingray"
    },
    animationDuration: 150,
    inactiveOpacity: 0.6,
    defaultImage: "apps/fit_app/res/default_video_image.png"
};

/**
 * App tabs
 */
this.tabs = [{
        id: "video",
        title: {
            ru: "Видео",
            en: "Video"
        },
        url: server + "/videos",
        badgeInt: 0
    },
    {
        id: "exercises",
        title: {
            ru: "Упражнения",
            en: "Exercises"
        },
        url: server + "/exercises",
        badgeInt: 0
    },
    {
        id: "nutrition",
        title: {
            ru: "Питание",
            en: "Nutrition"
        },
        url: server + "/nutritions",
        badgeInt: 0
    },
    {
        id: "bookmark",
        title: {
            ru: "Закладки",
            en: "Bookmarks"
        },
        url: server + "/bookmarks",
        badgeInt: 0
    },
    {
        id: "stats",
        title: {
            ru: "Статистика",
            en: "Stats"
        },
        url: server + "/stats",
        badgeInt: 0
    },
    {
        id: "setting",
        title: {
            ru: "Настройки",
            en: "Settings"
        },
        url: server + "/settings",
        badgeInt: 0
    }
];

this.bookmarksTypes = [{
    type: "video",
    title: {
        ru: "Видео",
        en: "Video"
    },
    badgeInt: 0
}, {
    type: "exercise",
    title: {
        ru: "Упражнения",
        en: "Exercises"
    },
    badgeInt: 0
}, {
    type: "nutrition",
    title: {
        ru: "Питание",
        en: "Nutrition"
    },
    badgeInt: 0
}];

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
        width: 220,
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
 * App texts
 */
this.texts = {
    ru: {
        language: "Язык: Русский",
        languageChanged: "Вы изменили язык на русский",

        nutritionSended: "Рецепт успешно отправлен!",
        exerciseSended: "Упражнения успешно отправлен!",
        selectSocial: "Отправьте в ВК или Телеграм",
        statsTitile: "Статистика активности и баллы",
        instruction: "Инструкция",
        activeThemeDark: "Оформление: Тёмная тема",
        activeThemeLight: "Оформление: Светлая тема",
        genderMale: "Пол: Мужской",
        genderFemale: "Пол: Женский",
        genderMaleChanged: "Вы изменили упражнения на мужской",
        genderFemaleChanged: "Вы изменили упражнения на женский",
        darkThemeActive: "Тёмная тема активирована",
        lightThemeActive: "Светлая тема активирована",
        nutritionMuscleBuilding: "Питание: Наращивание мышц",
        nutritionMuscleBuildingChanged: "Питание изменены на Наращивание мышц",
        nutritionWeightLoss: "Питание: Снижение веса",
        nutritionWeightLossChanged: "Питание изменены на Снижение веса",
        day: "День",
        sendToVk: "Отправить в ВК",
        sendToTg: "Отправить в Телеграм",
        reloading: "Проверяем...",
        cancel: "Отменить",
        vkNotIntegrated: "ВК не интегрирован.",
        tgNotIntegrated: "Телеграм не интегрирован.",
        tgIntegrated: "Телеграм успешно интегрирован!",
        vkIntegrated: "ВК успешно интегрирован!",
        sendToSocial: "Отправить в социальные сети",
        playExerciseClosed: "Вы закрыли упражнения, чтобы начать заново сделайте полный экран",
        finishedExercise: "Вы успешно закончили упражнение",
        relaxCircle: "Отдыхаем между кругами",
        startThirdCircle: "Начали третий круг",
        startSecondCircle: "Начали второй круг",
        startFirstCircle: "Начали первый круг",
        start: "Начать",
        stop: "Остановить",
        repetitionCircle: "Круг (Повторяем 2-3 раза)",
        videoNotAdded: "Вы ещё не добавили Видео в закладки",
        exersicesNotAdded: "Вы ещё не добавили Упражнения в закладки",
        nutritionNotAdded: "Вы ещё не добавили Питание в закладки",
        sended: "Отправлено!",
        checkIntegration: "Проверить интеграцию",
        settingInfo: "Mожно отправлять упражнения, рецепты и много другое.\nБот ВК: https://vk.com/fit_smart_bot.\nБот Телеграм: https://t.me/fit_smart_bot.\nДля подключения нужно отправит ID приложения.",
        appFunctions: [
            "1. Добавить в закладки. Это красная кнопка на пульте.",
            "2. Функция сделать полный экран. Это зеленая кнопка на пульте.",
            "3. Изменить оформление. Это желтая кнопка на пульте."
        ],

        doFullscreen: "-- Сделайте полный экран, чтобы посмотреть полную инструкцию и начать упражнения ---"
    },
    en: {
        language: "Language: English",
        languageChanged: "You changed the language to english",

        nutritionSended: "Recipe sent successfully!",
        exerciseSended: "Exercise sent successfully!",
        selectSocial: "Send to VK or Telegram",
        statsTitile: "Activity Statistics and points",
        instruction: "Instructions",
        activeThemeDark: "Design: Dark theme",
        activeThemeLight: "Design: Light theme",
        genderMale: "Gender: Male",
        genderFemale: "Gender: Female",
        genderMaleChanged: "You changed the exercise to male",
        genderFemaleChanged: "You changed the exercise to female",
        darkThemeActive: "Dark theme activated",
        lightThemeActive: "Light theme activated",
        nutritionMuscleBuilding: "Nutrition: Muscle building",
        nutritionMuscleBuildingChanged: "Nutrition changed to build muscle",
        nutritionWeightLoss: "Nutrition: Weight loss",
        nutritionWeightLossChanged: "Nutrition changed for weight Loss",
        day: "Day",
        sendToVk: "Send to VK",
        sendToTg: "Send to Telegram",
        reloading: "Checking...",
        cancel: "Cancel",
        vkNotIntegrated: "VK is not integrated.",
        tgNotIntegrated: "Telegram is not integrated.",
        tgIntegrated: "Telegram successfully integrated!",
        vkIntegrated: "VK has been successfully integrated!",
        sendToSocial: "Send to social networks",
        playExerciseClosed: "You closed the exercise to start again make a full screen",
        finishedExercise: "You completed the exercise successfully",
        relaxCircle: "Resting between roundes",
        startThirdCircle: "Started the third round",
        startSecondCircle: "Started the second round",
        startFirstCircle: "Started the first round",
        start: "Start",
        stop: "Stop",
        repetitionCircle: "Round (Repeat 2-3 times)",
        videoNotAdded: "You haven't added the Video to your bookmarks yet",
        exersicesNotAdded: "You haven't added the Exercises to your bookmarks yet",
        nutritionNotAdded: "You haven't added Food to your bookmarks yet",
        sent: "Sent!",
        checkIntegration: "Check integration",
        settingInfo: "You can send exercises, recipes, and much more.\nBot VK: https://vk.com/fit_smart_bot.\nBot Telegram: https://t.me/fit_smart_bot.\nTo connect, you will need to send the app ID.",
        appFunctions: [
            "1. Add to bookmarks. This is the red button on the remote.",
            "2. A function to make it full screen. This is the green button on the remote.",
            "3. Change the design. This is the yellow button on the remote."
        ],

        doFullscreen: "--- Make a full screen to view the full instructions and start the exercise ---"
    }
};

/**
 * Format params
 * Set auth token and stingray id
 * 
 * @param  {String} url
 * @param  {Object} params
 * @return {String} formated params like "http://example.example?a=1&b=2&c=3"
 */
this.formatParams = (url, params) => {
    let stingray = JSON.parse(load("fit_stingray") || "{}");

    params.token = this.config.token;
    params.stingray = stingray.id || "";

    const final = url + "?" + Object
        .keys(params)
        .map(function (key) {
            return key + "=" + encodeURIComponent(params[key]);
        })
        .join("&");

    return final;
};

/**
 * Function to callback httpServer requests
 * @param  {String} url
 * @param  {String} method http
 * @param  {Object} params request
 * @param  {String} functionName where culling [httpServer] function
 * @return {Function} callback with result
 */
this.httpServer = (url, method, params, functionName, callback) => {
    let http = new XMLHttpRequest();
    http.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
    http.setRequestHeader("X-Requested-With", "XMLHttpRequest");
    http.timeout = 10000;

    http.open(method, this.formatParams(url, params), true);
    http.send();

    http.onreadystatechange = () => {
        if (http.readyState === 4) {
            if (http.status === 200) {
                return callback(JSON.parse(http.responseText));
            }
            log("----");
            log("Error http server status:", http.status);
            log("Function name:", functionName);
            log("Error url:", this.formatParams(url, params));
            log("Text response:", http.responseText ? http.responseText : null);
            log("----");
            return callback(false);
        }

    };
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
 * On change tab select page
 * main.qml - 47 line.
 */
this.onTabChange = () => {
    // Hide all tab pages
    videoItems.visible = false;
    exercisesPageContainer.visible = false;
    nutritionPageContainer.visible = false;
    bookmarkPageContainer.visible = false;
    statsPage.visible = false;
    settingPage.visible = false;

    // get current tab
    const tabCurrent = {
        index: tab.currentIndex,
        data: tab.model.get(tab.currentIndex)
    };

    // check tab id and active page
    switch (tabCurrent.data.id) {
        case "video":
            videoItems.visible = true;
            videoItems.setFocus();
            videoItems.getVideos(tabCurrent.data.url);
            break;
        case "exercises":
            exercisesPageContainer.visible = true;
            exercisesPageContainer.setFocus();
            exercisesPageContainer.getChipsAndExercises();
            break;
        case "nutrition":
            nutritionPageContainer.visible = true;
            nutritionItemsList.setFocus();
            nutritionItemsList.getNutritions(nutritionDays.model.get(nutritionDays.currentIndex).day);
            break;
        case "bookmark":
            bookmarkPageContainer.visible = true;
            bookmarkPageContainer.setFocus();
            bookmarkPageContainer.getBookmarks(bookmarkTypes.model.get(bookmarkTypes.currentIndex).type);
            break;
        case "stats":
            statsPage.visible = true;
            statsPage.getStats();
            barCharts.setFocus();
            break;
        case "setting":
            settingPage.visible = true;
            settingPage.setFocus();
            break;
        default:
            break;
    }
};

/**
 * On select item add to bookmark
 * @param  {Object} current model item
 * @param  {String} type item of adding/deleting item
 * @param  {String} page main or bookmark page
 */
this.addToBookmark = (current, type, page) => {
    fit.loading = true;
    this.httpServer(app.config.api.addDeleteBookmark, "GET", {
        id: type === "video" ? current.videoId : current.id,
        type: type
    }, "Add bookmark key: Red", (book) => {

        // if bookmark added, then show notification
        if (book.added) {
            current.bookmark = true;
            fit.addDeleteBadge(book.added, type);
            fit.showNotification("Успешно сохранено в закладках");
        } else {
            current.bookmark = false;
            fit.addDeleteBadge(book.added, type);
            fit.showNotification("Успешно удалено из закладки");
        }

        // check page type and update item
        if (type === "video") {
            videoItems.model.set(videoItems.currentIndex, current);
        } else if (type === "exercise") {
            exerciseItemsList.model.set(exerciseItemsList.currentIndex, current);
        } else if (type === "nutrition") {
            nutritionItems.model.set(nutritionItems.currentIndex, current);
        }

        fit.loading = false;
    });
};