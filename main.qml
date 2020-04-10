/**
* Pages and controllers
*/
import "Dashboard.qml";
import "Tab.qml";
import "VideoItems.qml";
import "ExercisesPage.qml";
import "ExerciseDetail.qml";
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
        // anchors.leftMargin: menuView.width + (app.sizes.margin * 3);

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

                        fit.appInit((callback) => {
                            if (callback) {
                                settingPageItem.id = fit.stingray.id;
                                settingPageItem.vkIntegrated = fit.stingray.vkIntegrated;
                                settingPage.visible = true;
                                settingPage.setFocus();
                            }
                        });

                        break;
                    default:
                        break;
                }
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
                    
                    let current = model.get(videoItems.currentIndex);
                    fit.loading = true;
                    app.httpServer(app.config.api.addDeleteBookmark, "GET", { videoId: current.videoId }, "Add bookmark key: Red", (book) => {

                        if (book.added) {
                            current.bookmark = true;
                        }

                        if (book.deleted) {
                            current.bookmark = false;
                        }
                        
                        model.remove(videoItems.currentIndex, 1);
                        model.insert(videoItems.currentIndex, current);

                        fit.loading = false;
                        videoItems.setFocus();
                    });
                    
                }
            }

            onSelectPressed: {
                let videoId = model.get(videoItems.currentIndex).videoId;
                const url = app.config.api.watch + "/" + videoId;

                // Hide elements
                tab.visible = false;
                // menuView.visible = false;
                mainView.visible = false;

                // Show player element and play url
                fitSmartPlayer.title = model.get(videoItems.currentIndex).title;
                fitSmartPlayer.visible = true;
                fitSmartPlayer.playVideos(url);
            }

            onUpPressed: {
                tab.setFocus();
            }

            onLeftPressed: {}

            onRightPressed: {}
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

        ExerciseDetail {
            id: exerciseDetailContainer;
            anchors.top: mainView.top;
            anchors.left: mainView.left;
            anchors.right: mainView.right;
            anchors.bottom: mainView.bottom;
            anchors.margins: app.sizes.margin;

            visible: false;
            focus: false;
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

            onLeftPressed: {}

            onRightPressed: {}

            onBackPressed: {}
        }

        /**
        * Nutrition Detail
        */
        NutritionDetail {
            id: nutritionDetail;

            anchors.top: mainView.top;
            anchors.horizontalCenter: mainWindow.horizontalCenter;
            anchors.margins: app.sizes.margin;
            // anchors.leftMargin: menuView.width + app.sizes.margin;

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
        // Show (main) elements
        tab.visible = true;
        // menuView.visible = true;
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
    * @return {Object} Id, isDark, vkIntegrated
    */
    function appInit(callback) {
        app.httpServer(app.config.api.stingray, "GET", {}, "appInit", (data) => {
            if (!data.id) return callback(false);
    
            // save stingray
            save("fit_stingray", data.id);
            save("fit_integratedVk", data.vkIntegrated);
            fit.stingray = data;

            callback(true);
        });
    }

    onKeyPressed: {
        if (key === "Blue") {
            fit.fullscreen = !fit.fullscreen;
        }
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
