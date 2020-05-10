/**
* Pages and controllers
*/
import "Tab.qml";
import "VideoItems.qml";
import "ExercisesPage.qml";
import "ExerciseDetail.qml";
import "WorkoutsPage.qml";
import "NutritionPage.qml";
import "NutritionDetail.qml";
import "BookmarkPage.qml";
import "StatsPage.qml";
import "SettingsPage.qml";
import "ModalController.qml";
import "FitPlayer.qml";

import controls.Spinner;

import "js/app.js" as appMain;
import "js/languages.js" as appLangs;

Application {
    id: fit;
    property var stingray: {};
    property int isDark: 1;
    property string lang: "ru";
    property bool fullscreen: false;
    property bool loading: false;

    color: fit.isDark ? appMain.theme.dark.layout_background : appMain.theme.light.layout_background;

    /**
    * Main tabs
    */
    Tab {
        id: tab;
        anchors.top: mainWindow.top;
        anchors.margins: appMain.sizes.margin;
        anchors.horizontalCenter: mainWindow.horizontalCenter;

        width: (appMain.sizes.tabCards.width + tabList.spacing) * appMain.tabs.length;
        
        keyNavigationWraps: false;
        onKeyPressed: {
            if (key === "Select" || key === "Down") {
                appMain.onTabChange();
            }
        }
    }

    /**
    * Main page container
    */
    Rectangle {
		id: mainView;
        z: 2;

        anchors.top: fit.fullscreen ? mainWindow.top : tab.bottom;
        anchors.left: mainWindow.left;
        anchors.right: mainWindow.right;
        anchors.bottom: mainWindow.bottom;
        anchors.margins: fit.fullscreen ? 0 : appMain.sizes.margin;

		radius: fit.fullscreen ? 0 : appMain.sizes.radius;
		color: fit.isDark ? appMain.theme.dark.item_background : appMain.theme.light.item_background;

        Behavior on height { animation: Animation { duration: 100; } }
        Behavior on width { animation: Animation { duration: 100; } }
        /**
        * Video Items
        */
        VideoItems {
            id: videoItems;

            anchors.top: mainView.top;
            anchors.left: mainView.left;
            anchors.right: mainView.right;
            anchors.bottom: mainView.bottom;
            anchors.margins: appMain.sizes.margin;

            focus: true;
            visible: true;

            opacity: activeFocus ? 1.0 : appMain.config.inactiveOpacity;

            keyNavigationWraps: false;

            onKeyPressed: {
                if (key === "Red") {
                    let current = model.get(videoItems.currentIndex);
                    appMain.addToBookmark(current, "video", "main");
                }
            }

            onSelectPressed: {
                const video = videoItems.model.get(videoItems.currentIndex);
                const url = appMain.config.main + "/videos/" + video.videoId + ".mp4";

                videoItems.playVideo(video.title, url, "main");
            }

            onUpPressed: {
                tab.setFocus();
            }

            /**
            * Play video on select
            * @param {String} title video title
            * @param {String} url video url
            */
            function playVideo(title, url, page) {
                // Hide elements
                tab.visible = false;
                mainView.visible = false;

                // Show player element and play url
                fitPlayer.title = title;
                fitPlayer.page = page;
                fitPlayer.visible = true;
                fitPlayer.playVideoByUrl(url);
            }
        }

        /**
        * Exercises Page
        */
        ExercisesPage {
            id: exercisesPageContainer;
            anchors.top: mainView.top;
            anchors.left: mainView.left;
            anchors.right: mainView.right;
            anchors.bottom: mainView.bottom;
            anchors.margins: appMain.sizes.margin;

            visible: false;
            focus: false;
            opacity: activeFocus ? 1.0 : appMain.config.inactiveOpacity;
        }

        /**
        * Exercises detail
        */
        ExerciseDetail {
            id: exerciseDetailContainer;
            anchors.top: mainView.top;
            anchors.left: mainView.left;
            anchors.right: mainView.right;
            anchors.bottom: mainView.bottom;
            anchors.margins: appMain.sizes.margin;

            visible: false;
            focus: false;
            opacity: activeFocus ? 1.0 : appMain.config.inactiveOpacity;
        }

        /**
        * Workouts Page
        */
        WorkoutsPage {
            id: workoutsPageContainer;
            anchors.top: mainView.top;
            anchors.left: mainView.left;
            anchors.right: mainView.right;
            anchors.bottom: mainView.bottom;
            anchors.margins: appMain.sizes.margin;

            visible: false;
            focus: false;
            opacity: activeFocus ? 1.0 : appMain.config.inactiveOpacity;
        }

        /**
        * Nutrition page
        */
        NutritionPage {
            id: nutritionPageContainer;
            anchors.top: mainView.top;
            anchors.left: mainView.left;
            anchors.right: mainView.right;
            anchors.bottom: mainView.bottom;
            anchors.margins: appMain.sizes.margin;

            visible: false;
            focus: false;
            opacity: activeFocus ? 1.0 : appMain.config.inactiveOpacity;
        }

        /**
        * Nutrition Detail
        */
        NutritionDetail {
            id: nutritionDetail;

            anchors.top: mainView.top;
            anchors.horizontalCenter: mainWindow.horizontalCenter;
            anchors.margins: appMain.sizes.margin;

            width: 920;
            visible: false;
            keyNavigationWraps: true;
            opacity: activeFocus ? 1.0 : appMain.config.inactiveOpacity;

            onClosed: {
                nutritionDetail.visible = false;
                nutritionPageContainer.visible = true;
                nutritionPageContainer.setFocus();
            }
        }

        /**
        * Bookmark page
        */
        BookmarkPage {
            id: bookmarkPageContainer;
            anchors.top: mainView.top;
            anchors.left: mainView.left;
            anchors.right: mainView.right;
            anchors.bottom: mainView.bottom;
            anchors.margins: appMain.sizes.margin;

            visible: false;
            focus: false;
            opacity: activeFocus ? 1.0 : appMain.config.inactiveOpacity;
        }

        /**
        * Stats Page
        */
        StatsPage {
            id: statsPage;

            anchors.top: mainView.top;
            anchors.left: mainView.left;
            anchors.right: mainView.right;
            anchors.bottom: mainView.bottom;
            anchors.margins: appMain.sizes.margin;

            opacity: 1.0;
            visible: false;
            focus: true;
        }

        /**
        * Settings Page
        */
        SettingsPage {
            id: settingPage;
            anchors.top: mainView.top;
            anchors.left: mainView.left;
            anchors.right: mainView.right;
            anchors.bottom: mainView.bottom;
            anchors.margins: appMain.sizes.margin;

            visible: false;
            focus: false;

            onUpPressed: {
                tab.setFocus();
            }
        }

        /**
        * Main view background image
        */
        Image {
            id: backThemeLogo;
            anchors.centerIn: mainView;

            opacity: 0.09;
            height: 400;
            registerInCacheSystem: false;
            async: false;
            fillMode: PreserveAspectFit;
            source: "apps/fit_app/res/video_page_" + (fit.isDark ? "dark.png" : "light.png");
        }
    }

    /**
    * Modal component
    */
    ModalController {
        id: modalController;
        anchors.centerIn: mainView;
        z: 4;
        property int oneItemHeight: 77;
        property int itemsWillBeInModal: 3;
        width: 420;
        height: modalController.oneItemHeight * modalController.itemsWillBeInModal;
        visible: false;

        // Check what select user in modal, then run function
        // If cancel clicked, then return focus to button
        onSelectedModalItem: {
            switch (type) {
                case "theme":
                    if (selected.id === "cancel") {
                        themeChanger.setFocus();
                    } else {
                        fit.updateTheme(selected.id);
                        themeChanger.setFocus();
                    }
                    break;
                case "nutrition_type":
                    if (selected.id === "cancel") {
                        nutritionTypeButton.setFocus();
                    } else {
                        fit.updateNutritionType(selected.id);
                        nutritionTypeButton.setFocus();
                    }
                    break;
                case "gender":
                    if (selected.id === "cancel") {
                        genderTypeButton.setFocus();
                    } else {
                        fit.updatedGenderType(selected.id);
                        genderTypeButton.setFocus();
                    }
                    break;
                case "workouts_type":
                    if (selected.id === "cancel") {
                        workoutTypeButton.setFocus();
                    } else {
                        fit.updateWorkoutType(selected);
                        workoutTypeButton.setFocus();
                    }
                    break;
                case "language":
                    if (selected.id === "cancel") {
                        languageTypeButton.setFocus();
                    } else {
                        fit.updateLanguage(selected.id);
                        languageTypeButton.setFocus();
                    }
                    break;
                case "nutrition":
                    if (selected.id === "cancel") {
                        sendSocialNutritionButton.setFocus();
                    } else {
                        fit.sendToSocial(idContent, type, selected.id);
                        sendSocialNutritionButton.setFocus();
                    }
                    break;
                case "exercise":
                    if (selected.id === "cancel") {
                        sendSocialExerciseButton.setFocus();
                    } else {
                        fit.sendToSocial(idContent, type, selected.id);
                        sendSocialExerciseButton.setFocus();
                    }
                    break;

                default:
                    break;
            }

            modalController.itemsWillBeInModal = 3;
            modalController.visible = false;
        }
    }

    /**
    * Spinner loading
    */
    Spinner {
        id: loadingSpinner;
        anchors.centerIn: mainView;
        z: 3;
        visible: fit.loading;
    }

    /**
    * NotificatorManager
    */
    NotificatorManager {
        id: notificatorManager;
        text: "";
    }

    /**
    * VirtualKeyboard
    */
    VirtualKeyboard {
        id: keyboard;
        visible: true;
    }

    /**
    * FitSmart Player
    */
    FitPlayer {
        id: fitPlayer;
        z: 4;
        anchors.fill: mainWindow;
        property string page: "main";

        visible: false;

        onBackPressed: {
            fitPlayer.hideFitPlayer(page);
        }

        onFinished: {
            fitPlayer.hideFitPlayer(page);
        }

        /**
        * Hide player function
        * @param {String} page main|bookmark
        * page param for setting focus, after close player
        */
        function hideFitPlayer(page, action) {
            // Show (main) elements
            tab.visible = true;
            mainView.visible = true;

            // Hide player
            fitPlayer.abort();
            fitPlayer.visible = false;

            // Set focus
            if (page === "main") {
                videoItems.setFocus();
            } else if (page === "bookmark") {
                bookmarkVideoItemsList.setFocus();
            }
        }
    }

    /**
    * Show Notification
    * @param {String} text text to show notification 
    */
    function showNotification(text) {
        notificatorManager.text = text;
        notificatorManager.addNotify();
    }

    /**
    * Send To Social
    * @param {String} id content id, what sending
    * @param {String} type type content
    * @param {String} social type social, where will send
    */
    function sendToSocial(id, type, social) {
		const stingray = JSON.parse(load("fit_stingray"));
        if (social === "vk") {
            if (!stingray.vkIntegrated) {
                return fit.showNotification(appLangs.texts[fit.lang].vkNotIntegrated);
            }
        } else if (social === "tg") {
            if (!stingray.tgIntegrated) {
                return fit.showNotification(appLangs.texts[fit.lang].tgNotIntegrated);
            }
        }
        appMain.httpServer(appMain.config.api.sendToSocial, "GET", {
            id: id,
            type: type,
            social: social
        }, "sendToSocial", (ok) => {
            if (ok.sended) {
                if (type === "nutrition") {
                    fit.showNotification(appLangs.texts[fit.lang].nutritionSended);
                } else if (type === "exercise") {
                    fit.showNotification(appLangs.texts[fit.lang].exerciseSended);
                }
            };
        });
    }

    /**
    * Update Theme
    * @param {String} theme 1|0
    */
    function updateTheme(theme) {
        let stingray = JSON.parse(load("fit_stingray"));
        if (stingray.isDark === parseInt(theme)) return;

        fit.loading = true;
        appMain.httpServer(appMain.config.api.updateStingray, "GET", { isDark: theme }, "themeChanger", (is) => {
            if (is.updated) {
                stingray.isDark = parseInt(theme);
                fit.isDark = parseInt(theme);

                if (parseInt(theme)) {
                    fit.showNotification(appLangs.texts[fit.lang].darkThemeActive);
                } else {
                    fit.showNotification(appLangs.texts[fit.lang].lightThemeActive);
                }

                save("fit_stingray", JSON.stringify(stingray));
            }

            fit.loading = false;
        });
    }

    /**
    * Update Nutrition Type
    * @param {String} meal 1|0
    */
    function updateNutritionType(meal) {
        let stingray = JSON.parse(load("fit_stingray"));
        if (stingray.meal === parseInt(meal)) return;

        appMain.httpServer(appMain.config.api.updateStingray, "GET", { meal: meal }, "nutrition_type", (res) => {
            if (res.updated) {
                stingray.meal = parseInt(meal);
                if (parseInt(meal)) {
                    fit.showNotification(appLangs.texts[fit.lang].nutritionMuscleBuildingChanged);
                } else {
                    fit.showNotification(appLangs.texts[fit.lang].nutritionWeightLossChanged);
                }

                save("fit_stingray", JSON.stringify(stingray));
                fit.stingray = JSON.parse(load("fit_stingray"));
            }
        });
    }

    /**
    * Update Gender Type
    * @param {String} gender man|woman
    */
    function updatedGenderType(gender) {
        let stingray = JSON.parse(load("fit_stingray"));
        if (stingray.gender === gender) return;

        appMain.httpServer(appMain.config.api.updateStingray, "GET", { gender: gender }, "genderTypeButton", (res) => {
            if (res.updated) {
                stingray.gender = gender;
                if (gender === "woman") {
                    fit.showNotification(appLangs.texts[fit.lang].genderFemaleChanged);
                } else if (gender === "man") {
                    fit.showNotification(appLangs.texts[fit.lang].genderMaleChanged);
                }

                save("fit_stingray", JSON.stringify(stingray));
                fit.stingray = JSON.parse(load("fit_stingray"));
            }
        });
    }

    function updateWorkoutType(selected) {
        let stingray = JSON.parse(load("fit_stingray"));
        if (stingray.workoutDays === parseInt(selected.id)) return;

        appMain.httpServer(appMain.config.api.updateStingray, "GET", { workoutDays: selected.id }, "genderTypeButton", (res) => {
            if (res.updated) {
                stingray.workoutDays = parseInt(selected.id);
                fit.showNotification(appLangs.texts[fit.lang].workoutDay + " " + selected.data);

                save("fit_stingray", JSON.stringify(stingray));
                fit.stingray = JSON.parse(load("fit_stingray"));
            }
        });
    }

    /**
    * Update Language
    * @param {String} lang ru|en
    */
    function updateLanguage(lang) {
        let stingray = JSON.parse(load("fit_stingray"));
        if (stingray.lang === lang) return;

        appMain.httpServer(appMain.config.api.updateStingray, "GET", { lang: lang }, "updateLanguage", (res) => {
            if (res.updated) {
                stingray.lang = lang;
                fit.lang = lang;
                fit.showNotification(appLangs.texts[fit.lang].languageChanged);

                save("fit_stingray", JSON.stringify(stingray));
                fit.stingray = JSON.parse(load("fit_stingray"));
            }
        });
    }

    /**
    * Add/Delete Badge
    * @param {String} added true|false
    * @param {String} type bookmark type index video=0|exercise=|nutrition
    */
    function addDeleteBadge(added, type) {
        const tabIndex = appMain.tabs.findIndex(tab => tab.id === "bookmarks");
        let bookmarkTab = tab.model.get(tabIndex);
        
        // main tab badge
        if (added) {
            bookmarkTab.badgeInt += 1;
        } else if (!added && bookmarkTab.badgeInt) {
            bookmarkTab.badgeInt -= 1;
        }
        tab.model.set(tabIndex, bookmarkTab);

        // bookmark page tabs badges
        if (bookmarkTypes.model.count != 0) {
            const bookmarkTabIndex = appMain.bookmarksTypes.findIndex(tab => tab.type === type);
            const getTypeBookmarkTab = bookmarkTypes.model.get(bookmarkTabIndex);
            if (added) {
                getTypeBookmarkTab.badgeInt += 1;
            } else if (!added && getTypeBookmarkTab.badgeInt) {
                getTypeBookmarkTab.badgeInt -= 1;
            }

            bookmarkTypes.model.set(bookmarkTabIndex, getTypeBookmarkTab);
        }
    }

    /**
    * App init
    * On first lunch - load & check stingray token and settings
    * @return {Object} id, isDark, vkIntegrated
    */
    function appInit(callback) {
        appMain.httpServer(appMain.config.api.stingray, "GET", {}, "appInit", (data) => {
            if (!data.id) return callback(false);

            // save stingray
            save("fit_stingray", JSON.stringify(data));
            fit.stingray = JSON.parse(load("fit_stingray"));

            fit.isDark = data.isDark ? true : false;
            fit.lang = data.lang;

            callback(true);
        });
    }

    onKeyPressed: {
        if (key === "Green") {
            fit.fullscreen = !fit.fullscreen;
        } else if (key === "Yellow") {
            let theme = (fit.isDark === 1) ? 0 : 1;
            log(theme);
            fit.updateTheme(theme);
        } else if (key === "Blue") {
            let lang = fit.stingray["lang"] === "ru" ? "en" : "ru";
            fit.updateLanguage(lang);
        }
    }

    onCompleted: {
        fit.loading = true;
        tab.currentIndex = 1;
        tab.currentIndex = 0;

        // Waiting stingray token/settings, then load page data
        fit.appInit((callback) => {
            if (callback) {
                videoItems.getVideos(tab.model.get(tab.currentIndex).url);
                videoItems.setFocus();
            } else {
                fit.showNotification("Server is not available or access denied.");
            }
        });
    }

    onBackPressed: {
        if (fit.fullscreen) {
            fit.fullscreen = false;
            return;
        }
        viewsFinder.closeApp();
    }

    onVisibleChanged: {
        viewsFinder.ignoreScreenSaverForApp("fit", this.visible);
        fitPlayer.abort();
        if (fitPlayer.visible) {
            fit.hideFitPlayer();
        }
    }
}
