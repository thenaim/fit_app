/**
 * Server adress with IPv4 (for local tests)
 */
const prod = false;

const server = prod ? "" : "http://192.168.1.144:8080";

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
        workouts: server + "/workouts",
        workoutsCategory: server + "/workouts/category",
        workoutsDays: server + "/workouts/days",
        getBookmarks: server + "/bookmarks",
        addDeleteBookmark: server + "/bookmarks/addDelete",
        sendToSocial: server + "/social/send",
        themeChange: server + "/settings/themechange",
        stats: server + "/stats",
        updateStingray: server + "/settings/update/stingray",
    },
    animationDuration: 150,
    inactiveOpacity: 0.5,
    defaultImage: "apps/fit_app/res/default_video_image.png",
};

/**
 * App tabs
 */
this.tabs = [{
    id: "videos",
    title: {
        ru: "Видео",
        en: "Video",
    },
    url: server + "/videos",
    badgeInt: 0,
},
{
    id: "exercises",
    title: {
        ru: "Упражнения",
        en: "Exercises",
    },
    url: server + "/exercises",
    badgeInt: 0,
},
{
    id: "workouts",
    title: {
        ru: "Тренировки",
        en: "Workouts",
    },
    url: server + "/workouts",
    badgeInt: 0,
},
{
    id: "nutritions",
    title: {
        ru: "Питание",
        en: "Nutrition",
    },
    url: server + "/nutritions",
    badgeInt: 0,
},
{
    id: "bookmarks",
    title: {
        ru: "Закладки",
        en: "Bookmarks",
    },
    url: server + "/bookmarks",
    badgeInt: 0,
},
{
    id: "stats",
    title: {
        ru: "Статистика",
        en: "Stats",
    },
    url: server + "/stats",
    badgeInt: 0,
},
{
    id: "settings",
    title: {
        ru: "Настройки",
        en: "Settings",
    },
    url: server + "/settings",
    badgeInt: 0,
},
];

this.bookmarksTypes = [{
    type: "video",
    title: {
        ru: "Видео",
        en: "Video",
    },
    badgeInt: 0,
},
{
    type: "exercise",
    title: {
        ru: "Упражнения",
        en: "Exercises",
    },
    badgeInt: 0,
},
{
    type: "nutrition",
    title: {
        ru: "Питание",
        en: "Nutrition",
    },
    badgeInt: 0,
},
];

this.statsTypes = [{
    type: "dashboard",
    title: {
        ru: "Статистика",
        en: "Stats",
    },
},
{
    type: "leaderboard",
    title: {
        ru: "Топ 5 пользователей",
        en: "Top 5 users",
    },
},
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
        layout_background: "#f2f2f2",
    },
    dark: {
        background: "#121212",
        textColor: "#ffffff",
        border_color: "#222222",
        item_background: "#1A1B1E",
        item_background_2: "#3A3B3F",
        layout_background: "#0d0d0d",
    },
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
        height: 166,
    },
    tabCards: {
        width: 150,
        height: 120,
    },
    chips: {
        width: 220,
        height: 100,
    },
    exercise: {
        width: 280,
        height: 280,
    },
    nutrition: {
        width: 285,
        height: 260,
    },
};

/**
 * Format params
 * Set auth token and stingray id
 *
 * @param  {Object} params
 * @return {String} formated params like "?a=1&b=2&c=3"
 */
this.formatParams = (params) => {
    let stingray = JSON.parse(load("fit_stingray") || "{}");

    params.token = this.config.token;
    params.stingray = stingray.id || "";

    return (
        "?" +
        Object.keys(params)
            .map(function (key) {
                return key + "=" + encodeURIComponent(params[key]);
            })
            .join("&")
    );
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
    url = url + this.formatParams(params);

    let http = new XMLHttpRequest();
    http.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
    http.setRequestHeader("X-Requested-With", "XMLHttpRequest");
    http.timeout = 10000;

    http.open(method, url, true);
    http.send();

    http.onreadystatechange = () => {
        if (http.readyState === 4) {
            if (http.status === 200) {
                return callback(JSON.parse(http.responseText));
            }
            error(
                "\n----",
                "\nError http server status:",
                http.status,
                "\nFunction name:",
                functionName,
                "\nError url:",
                url,
                "\nText response:",
                http.responseText ? http.responseText : null,
                "\n----"
            );
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
        if (length + word.length >= maxLength) {
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
 * Parse Milliseconds Into Readable Time
 * @param {Number} milliseconds of timer
 */
this.parseMillisecondsIntoReadableTime = (milliseconds) => {
    //Get hours from milliseconds
    const hours = milliseconds / (1000 * 60 * 60);
    const absoluteHours = Math.floor(hours);
    const h = absoluteHours > 9 ? absoluteHours : "0" + absoluteHours;

    //Get remainder from hours and convert to minutes
    const minutes = (hours - absoluteHours) * 60;
    const absoluteMinutes = Math.floor(minutes);
    const m = absoluteMinutes > 9 ? absoluteMinutes : "0" + absoluteMinutes;

    //Get remainder from minutes and convert to seconds
    const seconds = (minutes - absoluteMinutes) * 60;
    const absoluteSeconds = Math.floor(seconds);
    const s = absoluteSeconds > 9 ? absoluteSeconds : "0" + absoluteSeconds;

    return {
        full: h + ":" + m + ":" + s,
        h: h,
        m: m,
        s: s,
    };
};

/**
 * On change tab select page
 * main.qml - 47 line.
 */
this.onTabChange = () => {
    // Hide all tab pages
    videoItems.visible = false;
    exercisesPageContainer.visible = false;
    workoutsPageContainer.visible = false;
    nutritionPageContainer.visible = false;
    bookmarkPageContainer.visible = false;
    statsPage.visible = false;
    settingPage.visible = false;

    // get current tab
    const tabCurrent = {
        index: tab.currentIndex,
        data: tab.model.get(tab.currentIndex),
    };

    // check tab id and active page
    switch (tabCurrent.data.id) {
        case "videos":
            videoItems.visible = true;
            videoItems.setFocus();
            videoItems.getVideos(tabCurrent.data.url);
            break;
        case "exercises":
            exercisesPageContainer.visible = true;
            exercisesPageContainer.setFocus();
            exercisesPageContainer.getChipsAndExercises();
            break;
        case "workouts":
            workoutsPageContainer.visible = true;
            workoutsPageContainer.setFocus();
            workoutsPageContainer.getWorkoutsCategory();
            break;
        case "nutritions":
            nutritionPageContainer.visible = true;
            nutritionItemsList.setFocus();
            nutritionItemsList.getNutritions(
                nutritionDays.model.get(nutritionDays.currentIndex).day
            );
            break;
        case "bookmarks":
            bookmarkPageContainer.visible = true;
            bookmarkPageContainer.setFocus();
            bookmarkPageContainer.getBookmarks(
                bookmarkTypes.model.get(bookmarkTypes.currentIndex).type
            );
            break;
        case "stats":
            statsPage.visible = true;
            statsPage.getStats();
            barCharts.setFocus();
            break;
        case "settings":
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
this.addToBookmark = (current, type, page, callback) => {
    fit.loading = true;
    this.httpServer(
        appMain.config.api.addDeleteBookmark,
        "GET", {
        id: type === "video" ? current.videoId : current.id,
        type: type,
    },
        "Add bookmark key: Red",
        (book) => {
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

            // check page, type and update item
            if (page === "main") {
                if (type === "video") {
                    videoItems.model.set(videoItems.currentIndex, current);
                } else if (type === "exercise") {
                    exerciseItemsList.model.set(exerciseItemsList.currentIndex, current);
                } else if (type === "nutrition") {
                    nutritionItems.model.set(nutritionItems.currentIndex, current);
                }
            }

            if (page === "bookmark") {
                if (type === "video") {
                    bookmarkVideoItemsList.model.remove(
                        bookmarkVideoItemsList.currentIndex,
                        1
                    );
                } else if (type === "exercise") {
                    bookmarkExerciseItemsList.model.remove(
                        bookmarkExerciseItemsList.currentIndex,
                        1
                    );
                } else if (type === "nutrition") {
                    bookmarkNutritionItemsList.model.remove(
                        bookmarkNutritionItemsList.currentIndex,
                        1
                    );
                }
            }

            if (page === "workout") {
                workoutItems.model.set(workoutItems.currentIndex, current);
            }

            fit.loading = false;

            callback(current.bookmark);
        }
    );
};