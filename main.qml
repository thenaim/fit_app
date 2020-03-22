/**
* Pages and controllers
*/
import "Dashboard.qml";
import "Tab.qml";
import "VideoItems.qml";
import "ExercisesPage.qml";
import "NutritionItems.qml";
import "NutritionDetail.qml";
import "SettingsPage.qml";
import "FitSmartPlayer.qml";

import controls.Spinner;

import "js/app.js" as app;

Application {
    id: fit;

    property var stingray: {};

    property bool isDark: true;
    property bool loading: false;

    color: fit.isDark ? app.theme.dark.layout_background : app.theme.light.layout_background;

    /**
    * Left side container (Dashboard)
    */
    Rectangle {
		id: menuView;
        visible: true;
		width: 320;
	
        anchors.left: mainWindow.left;
        anchors.top: tab.bottom;
        anchors.bottom: mainWindow.bottom;
        anchors.margins: app.sizes.margin;

		radius: app.sizes.radius;
		color: fit.isDark ? app.theme.dark.item_background : app.theme.light.item_background;

        /**
        * FitSmart logo
        */
        Image {
            id: fitSmartImage;

            anchors.bottom: menuView.top;
            anchors.topMargin: app.sizes.tabCards.width / 4;

            anchors.horizontalCenter: menuView.horizontalCenter;
            async: false;

            source: fit.isDark ? "apps/fit_app/res/dark_logo.png" : "apps/fit_app/res/light_logo.png";
        }

        /**
        * Dashboard (left side)
        */
        Dashboard {
            id: dashboard;

            anchors.top: menuView.top;
            anchors.left: menuView.left;
            anchors.right: menuView.right;
            anchors.bottom: menuView.bottom;
            anchors.margins: app.sizes.margin;

            anchors.verticalCenter: menuView.verticalCenter;

            spacing: app.sizes.margin;
            focus: false;
            opacity: 1.0;
        }
	}

    /**
    * Main tabs
    */
    Tab {
        id: tab;
        anchors.top: mainWindow.top;
        anchors.margins: app.sizes.margin;
        anchors.leftMargin: menuView.width + (app.sizes.margin * 3);

        anchors.horizontalCenter: mainWindow.horizontalCenter;
        width: app.sizes.tabCards.width * app.tabs.length;
        
        spacing: app.sizes.margin;
        keyNavigationWraps: false;

        onKeyPressed: {
            if (key === "Select" || key === "Down") {
                const tabCurrent = {
                    index: tab.currentIndex,
                    data: model.get(tab.currentIndex)
                };

                switch (tabCurrent.data.id) {
                    case "video":
                        videoItems.visible = true;
                        exercisesPageContainer.visible = false;
                        nutritionItems.visible = false;
                        settingPage.visible = false;
                        videoItems.setFocus();
                        videoItems.getVideos(tabCurrent.data.url);
                        break;
                    case "exercises":
                        videoItems.visible = false;
                        exercisesPageContainer.visible = true;
                        nutritionItems.visible = false;
                        settingPage.visible = false;
                        exercisesPageContainer.setFocus();
                        exercisesPageContainer.getChipsAndExercises("Abs");
                        break;
                    case "nutrition":
                        videoItems.visible = false;
                        exercisesPageContainer.visible = false;
                        nutritionItems.visible = true;
                        settingPage.visible = false;
                        nutritionItems.setFocus();
                        nutritionItems.getNutritions(tabCurrent.data.url);
                        break;
                    case "bookmark":
                        videoItems.visible = true;
                        exercisesPageContainer.visible = false;
                        nutritionItems.visible = false;
                        settingPage.visible = false;
                        videoItems.setFocus();
                        videoItems.getVideos(tabCurrent.data.url);
                        break;
                    case "setting":
                        videoItems.visible = false;
                        exercisesPageContainer.visible = false;
                        nutritionItems.visible = false;

                        settingPage.id = fit.stingray.id;
                        settingPage.integrated = fit.stingray.integrated;
                        settingPage.visible = true;
                        settingPage.setFocus();
                        break;
                    default:
                        break;
                }
            }
        }

        onLeftPressed: {
            const currentIndex = tab.currentIndex + 1;
            const tabItemModelCount = tab.model.count;
            if (tabItemModelCount) {
                if (currentIndex === 1) tab.currentIndex = tabItemModelCount - 1;
            }
        }

        onRightPressed: {
            const currentIndex = tab.currentIndex + 1;
            const tabItemModelCount = tab.model.count;
            if (tabItemModelCount) {
                if (currentIndex === tabItemModelCount) tab.currentIndex = 0;
            }
        }
    }

    /**
    * Main page container
    */
    Rectangle {
		id: mainView;

        anchors.top: tab.bottom;
        anchors.left: menuView.right;
        anchors.right: mainWindow.right;
        anchors.bottom: mainWindow.bottom;
        anchors.margins: app.sizes.margin;

		radius: app.sizes.radius;
		color: fit.isDark ? app.theme.dark.item_background : app.theme.light.item_background;

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

                    // TODO: Add Bookmarks
                    /*
                    let current = model.get(videoItems.currentIndex);
                    fit.loading = true;
                    app.httpServer(app.config.api.addDeleteBookmark, "GET", { stingray: load("stingray"), token: app.config.token, videoId: current.videoId }, (book) => {

                        if (book.added) {
                            current.bookmark = true;
                        }

                        if (book.deleted) {
                            current.bookmark = false;
                        }

                        log(JSON.stringify(book));
                        
                        model.remove(videoItems.currentIndex, 1);
                        model.insert(videoItems.currentIndex, current);

                        fit.loading = false;
                        videoItems.setFocus();
                    });
                    */
                }
            }

            onSelectPressed: {
                let videoId = model.get(videoItems.currentIndex).videoId;
                const url = app.config.api.watch + "/" + videoId;

                // Hide elements
                tab.visible = false;
                menuView.visible = false;
                mainView.visible = false;

                // Show player element and play url
                fitSmartPlayer.visible = true;
                fitSmartPlayer.title = model.get(videoItems.currentIndex).title;
                fitSmartPlayer.playVideos(url);
            }

            onUpPressed: {
                tab.setFocus();
            }

            onLeftPressed: {
                const currentIndex = videoItems.currentIndex + 1;
                const videoItemModelCount = videoItems.model.count;
                if (videoItemModelCount) {
                    if (currentIndex === 1) return;

                    if (currentIndex <= videoItemModelCount) {
                        videoItems.currentIndex -= 1;
                    }
                }
            }

            onRightPressed: {
                const currentIndex = videoItems.currentIndex + 1;
                const videoItemModelCount = videoItems.model.count;

                if (videoItemModelCount) {
                    if (currentIndex === videoItemModelCount) return;

                    if (currentIndex < videoItemModelCount) {
                        videoItems.currentIndex += 1;
                    }
                }
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
        * Nutrition Items
        */
        NutritionItems {
            id: nutritionItems;

            anchors.top: mainView.top;
            anchors.left: mainView.left;
            anchors.right: mainView.right;
            anchors.bottom: mainView.bottom;
            anchors.margins: app.sizes.margin;

            opacity: 1.0;

            onSelectPressed: {
                nutritionItems.visible = false;

                const currentNutritionItem = model.get(nutritionItems.currentIndex);
                nutritionDetail.id = currentNutritionItem.id;
                nutritionDetail.name = currentNutritionItem.name;
                nutritionDetail.steps = currentNutritionItem.steps;
                nutritionDetail.ingredients = currentNutritionItem.ingredients;
                nutritionDetail.image = currentNutritionItem.image;

                nutritionDetail.visible = true;
                nutritionDetail.setFocus();
            }

            onUpPressed: {
                tab.setFocus();
            }

            onDownPressed: {}

            onLeftPressed: {
                const currentIndex = nutritionItems.currentIndex + 1;
                const nutritionItemModelCount = nutritionItems.model.count;
                if (nutritionItemModelCount) {
                    if (currentIndex === 1) return;

                    if (currentIndex <= nutritionItemModelCount) {
                        nutritionItems.currentIndex -= 1;
                    }
                }
            }

            onRightPressed: {
                const currentIndex = nutritionItems.currentIndex + 1;
                const nutritionItemModelCount = nutritionItems.model.count;

                if (nutritionItemModelCount) {
                    if (currentIndex === nutritionItemModelCount) return;

                    if (currentIndex < nutritionItemModelCount) {
                        nutritionItems.currentIndex += 1;
                    }
                }
            }

            onBackPressed: {
                return log("Back => ", key);
            }
        }

        NutritionDetail {
            id: nutritionDetail;

            anchors.top: mainView.top;
            anchors.horizontalCenter: mainWindow.horizontalCenter;
            anchors.margins: app.sizes.margin;
            anchors.leftMargin: menuView.width + app.sizes.margin;

            width: 720;
            visible: false;
            keyNavigationWraps: true;

            opacity: 1.0;

            onClosed: {
                nutritionDetail.visible = false;
                nutritionItems.visible = true;
                nutritionItems.setFocus();
            }
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
    }

    /**
    * FitSmart Player
    */
    FitSmartPlayer {
        id: fitSmartPlayer;
        anchors.fill: mainWindow;

        visible: false;

        onBackPressed: {
            fit.hideFitSmartPlayer();
        }

        onFinished: {
            fit.hideFitSmartPlayer();
        }
    }

    /**
    * Spinner loading
    */
    Spinner {
        id: loadingCatalogSpinner;
        color: fit.isDark ? app.theme.dark.background : app.theme.light.background;

        anchors.centerIn: mainView;

        visible: fit.loading;
    }

    /**
    * Hide player function
    */
    function hideFitSmartPlayer() {
        // Hide elements
        tab.visible = true;
        menuView.visible = true;
        mainView.visible = true;

        // Hide player
        fitSmartPlayer.visible = false;
        fitSmartPlayer.abort();

        videoItems.setFocus();
    }


    /**
    * Change app theme
    */
    function changeTheme() {
        fit.isDark = !fit.isDark;
    }

    /**
    * App init
    * On first lunch - load & check stingray token and settings
    * @return {Object} Id, isDark, integrated
    */
    function appInit(callback) {
        app.httpServer(app.config.api.stingray, "GET", { stingray: load("stingray") || "", token: app.config.token }, (data) => {
            if (!data.id) return callback(false);
    
            // save stingray ID
            save("stingray", data.id);
            fit.stingray = data;
            callback(true);
        });
    }

    onBackPressed: {
        viewsFinder.closeApp();
    }

    onCompleted: {
        videoItems.setFocus();
        // Waiting stingray token/settings, then load page data
        fit.appInit((callback) => {
            if (callback) {
                videoItems.getVideos(app.tabs[0].url);
                videoItems.setFocus();
            }
        });
    }

    onVisibleChanged: {
        viewsFinder.ignoreScreenSaverForApp("fit", this.visible);
        fitSmartPlayer.abort();
        if (fitSmartPlayer.visible) fit.hideFitSmartPlayer();
    }
}
