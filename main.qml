/**
* Pages and controllers
*/
import "Tab.qml";
import "VideoItems.qml";
import "ExercisesPage.qml";
import "ExerciseDetail.qml";
import "NutritionPage.qml";
import "NutritionDetail.qml";
import "BookmarkPage.qml";
import "StatsPage.qml";
import "SettingsPage.qml";
import "SendSocial.qml";
import "FitSmartPlayer.qml";

import controls.Spinner;

import "js/app.js" as app;

Application {
    id: fit;

    property var stingray: {};

    property bool isDark: true;
    property string lang: "ru";
    property bool fullscreen: false;
    property bool loading: false;

    color: fit.isDark ? app.theme.dark.layout_background : app.theme.light.layout_background;

    /**
    * Main tabs
    */
    Tab {
        id: tab;
        anchors.top: mainWindow.top;
        anchors.margins: app.sizes.margin;

        anchors.horizontalCenter: mainWindow.horizontalCenter;
        width: app.sizes.tabCards.width * app.tabs.length;
        
        spacing: app.sizes.margin;
        keyNavigationWraps: false;

        onKeyPressed: {
            if (key === "Select" || key === "Down") {
                app.onTabChange();
            }
        }

        onLeftPressed: {}

        onRightPressed: {}
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
        anchors.margins: fit.fullscreen ? 0 : app.sizes.margin;

		radius: fit.fullscreen ? 0 : app.sizes.radius;
		color: fit.isDark ? app.theme.dark.item_background : app.theme.light.item_background;

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
            anchors.margins: app.sizes.margin;

            focus: true;
            visible: true;

            opacity: activeFocus ? 1.0 : app.config.inactiveOpacity;

            keyNavigationWraps: false;

            onKeyPressed: {
                if (key === "Red") {
                    let current = model.get(videoItems.currentIndex);
                    app.addToBookmark(current, "video", "main");
                }
            }

            onSelectPressed: {
                videoItems.openVideoPlay("main");
            }

            onUpPressed: {
                tab.setFocus();
            }

            /**
            * Play Video function
            */
            function openVideoPlay(page) {
                const video = videoItems.model.get(videoItems.currentIndex);

                // Hide elements
                tab.visible = false;
                mainView.visible = false;

                fitSmartPlayer.page = "main";

                // Show player element and play url
                fitSmartPlayer.title = video.title;
                fitSmartPlayer.visible = true;
                fitSmartPlayer.playVideos(app.formatParams(app.config.api.watch + "/" + video.videoId, {}));
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
            anchors.margins: app.sizes.margin;

            visible: false;
            focus: false;

            opacity: activeFocus ? 1.0 : app.config.inactiveOpacity;
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
            anchors.margins: app.sizes.margin;

            visible: false;
            focus: false;

            opacity: activeFocus ? 1.0 : app.config.inactiveOpacity;
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
            anchors.margins: app.sizes.margin;

            visible: false;
            focus: false;

            opacity: activeFocus ? 1.0 : app.config.inactiveOpacity;
        }

        /**
        * Nutrition Detail
        */
        NutritionDetail {
            id: nutritionDetail;

            anchors.top: mainView.top;
            anchors.horizontalCenter: mainWindow.horizontalCenter;
            anchors.margins: app.sizes.margin;

            width: 920;
            visible: false;
            keyNavigationWraps: true;

            opacity: activeFocus ? 1.0 : app.config.inactiveOpacity;

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
            anchors.margins: app.sizes.margin;

            visible: false;
            focus: false;

            opacity: activeFocus ? 1.0 : app.config.inactiveOpacity;
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
            anchors.margins: app.sizes.margin;

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
            anchors.margins: app.sizes.margin;

            visible: false;
            focus: false;

            onUpPressed: {
                tab.setFocus();
            }
            
        }

        /**
        * Send social modal
        */
        SendSocial {
			id: sendSocial;
            z: 4;

			width: 420;
			height: 225;

			anchors.centerIn: mainView;
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
    * FitSmart Player
    */
    FitSmartPlayer {
        id: fitSmartPlayer;
        property string page;
        z: 5;
        anchors.fill: mainWindow;

        visible: false;

        onBackPressed: {
            fitSmartPlayer.hideFitSmartPlayer(fitSmartPlayer.page);
        }

        onFinished: {
            fitSmartPlayer.hideFitSmartPlayer(fitSmartPlayer.page);
        }

        /**
        * Hide player function
        * @param {String} page main|bookmark
        * page param for setting focus, after close player
        */
        function hideFitSmartPlayer(page) {
            // Show (main) elements
            tab.visible = true;
            mainView.visible = true;

            // Hide player
            fitSmartPlayer.visible = false;
            fitSmartPlayer.abort();

            // Set focus
            if (page === "main") {
                videoItems.setFocus();
            } else if (page === "bookmark") {
                bookmarkVideoItemsList.setFocus();
            }
        }
    }

    /**
    * Spinner loading
    */
    Spinner {
        id: loadingCatalogSpinner;
        color: fit.isDark ? app.theme.dark.background : app.theme.light.background;

        anchors.centerIn: fit;

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
    * Add/Delete Badge
    * @param {String} added true|false
    * @param {String} type bookmark type index video=0|exercise=|nutrition
    */
    function addDeleteBadge(added, type) {
        const tabIndex = app.tabs.findIndex(tab => tab.id === "bookmark");
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
            const bookmarkTabIndex = app.bookmarksTypes.findIndex(tab => tab.type === type);
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
    * Show Notification
    */
    function showNotification(text) {
        notificatorManager.text = text;
        notificatorManager.addNotify();
    }

    /**
    * App init
    * On first lunch - load & check stingray token and settings
    * @return {Object} Id, isDark, vkIntegrated
    */
    function appInit(callback) {
        app.httpServer(app.config.api.stingray, "GET", {}, "appInit", (data) => {
            if (!data.id) return callback(false);
    
            // save stingray
            save("fit_stingray", JSON.stringify(data));
            fit.stingray = JSON.parse(load("fit_stingray"));
            fit.stingray = JSON.parse(load("fit_stingray"));

            fit.isDark = data.isDark;
            fit.lang = data.lang;

            if (data.vkIntegrated) {
                fit.showNotification(app.texts[fit.lang].vkIntegrated);
            }
            if (data.tgIntegrated) {
                fit.showNotification(app.texts[fit.lang].tgIntegrated);
            }

            callback(true);
        });
    }

    onKeyPressed: {
        if (key === "Green") {
            fit.fullscreen = !fit.fullscreen;
        } else if (key === "Yellow") {
            fit.stingray.isDark = !fit.stingray.isDark;
            settingPageItem.updateTheme(fit.stingray.isDark);
        }
    }

    onBackPressed: {
        viewsFinder.closeApp();
    }

    onCompleted: {
        tab.currentIndex = 1;
        tab.currentIndex = 0;

        // Waiting stingray token/settings, then load page data
        fit.appInit((callback) => {
            if (callback) {
                videoItems.getVideos(tab.model.get(tab.currentIndex).url);
                videoItems.setFocus();
            }
        });

        // default nutrition type
        save("nutrition_type", "muscle_building");
    }

    onVisibleChanged: {
        viewsFinder.ignoreScreenSaverForApp("fit", this.visible);
        fitSmartPlayer.abort();
        if (fitSmartPlayer.visible) fit.hideFitSmartPlayer();
    }
}
