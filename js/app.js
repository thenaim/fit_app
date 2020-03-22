/**
 * Server adress with IPv4 (for local tests)
 */

const server = "http://192.168.1.64:8080";

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
        themeChange: server + "/settings/themechange"
    },
    animationDuration: 150,
    inactiveOpacity: 0.4,
    defaultImage: "apps/fit_app/res/default_video_image.png"
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
        id: "setting",
        title: "Настройки",
        url: server + "/settings"
    }
];

/**
 * Theme colors - light and dark
 */
this.theme = {
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
        width: 285,
        height: 155 // 135
    },
    tabCards: {
        width: 150,
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
 * @param  {Object} params
 * @return {String} formated params like "?a=1&b=2&c=3"
 */
this.formatParams = (params) => {
    // params.token = this.config.token;
    return "?" + Object
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
this.httpServer = (url, method, params, callback) => {
    url = url + this.formatParams(params);

    const http = new XMLHttpRequest();
    // http.setRequestHeader("Content-Type", "application/json");
    // http.setRequestHeader("X-Requested-With", "XMLHttpRequest");
    http.onreadystatechange = () => {
        if (http.readyState !== XMLHttpRequest.DONE) return callback(false);
        if (http.status !== 200) {
            log("Error status [httpServer function]", request.status);
            return callback(false);
        }

        return callback(JSON.parse(http.responseText));
    };

    http.open(method, url, true);

    http.send();
};