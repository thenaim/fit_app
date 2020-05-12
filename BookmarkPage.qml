import "js/app.js" as appMain;
import "js/languages.js" as appLangs;

import "BookmarkTypesDelegate.qml";
import "VideosDelegate.qml";
import "ExerciseDelegate.qml";
import "NutritionDelegate.qml";

Item {
    id: bookmarkPage;
    z: 1;

    anchors.top: bookmarkPageContainer.top;
    anchors.left: bookmarkPageContainer.left;
    anchors.right: bookmarkPageContainer.right;
    anchors.bottom: bookmarkPageContainer.bottom;

    opacity: 1.0;

    /**
    * Bookmark Type tabs
    */
    ListView {
        id: bookmarkTypes;
        anchors.top: bookmarkPage.top;
        anchors.left: bookmarkPage.left;
        anchors.right: bookmarkPage.right;
        anchors.margins: -appMain.sizes.margin;

        // get main container width, then divided to tab length
        // will be responsive card
        property string typesCardWidth: (mainView.width) / 3;

        orientation: mainWindow.horizontal;
        opacity: 1.0;
        height: fit.fullscreen ? 70 : 50;
        width: typesCardWidth;
        focus: true;
        clip: true;
        model: ListModel {}
        delegate: BookmarkTypesDelegate {}

        onCompleted: {
            appMain.bookmarksTypes.forEach((tab) => {
                model.append(tab);
            });
        }

        onKeyPressed: {
            if (key === "Up") {
                tab.setFocus();
            } else if (key === "Down" || key === "Select") {
                const bookmarkTypeCurrent = {
                    index: bookmarkTypes.currentIndex,
                    data: bookmarkTypes.model.get(bookmarkTypes.currentIndex)
                };

                bookmarkPage.getBookmarks(bookmarkTypeCurrent.data.type);
            }
        }

        // ListView tabBookmarkTypesHighlight
        property int hlWidth: bookmarkTypes.typesCardWidth;
        property int hlHeight: 4;
        property Color highlightColor: appMain.theme.light.background;

        // Highlight back (line)
        Rectangle {
            id: tabBookmarkTypeHighlightBack;
            anchors.bottom: bookmarkTypes.bottom;
            anchors.left: bookmarkTypes.left;
            anchors.right: bookmarkTypes.right;
            color: fit.isDark ? appMain.theme.dark.layout_background : appMain.theme.light.layout_background;

            height: bookmarkTypes.hlHeight;
            visible: true;
            z: 2;
            opacity: 0.8;
        }
    
        // Highlight front
        Rectangle {
            id: tabBookmarkTypesHighlight;
            color: bookmarkTypes.highlightColor;
            anchors.top: tabBookmarkTypeHighlightBack.top;
            anchors.bottom: bookmarkTypes.bottom;
            visible: true;
            z: 3;
            opacity: bookmarkTypes.activeFocus && bookmarkTypes.count ? 0.8 : 0.2;

            doHighlight: {
                if (!bookmarkTypes || !bookmarkTypes.model || !bookmarkTypes.count)
                    return;

                var futurePos = bookmarkTypes.getPositionViewAtIndex(bookmarkTypes.currentIndex, bookmarkTypes.positionMode);
                var itemRect = bookmarkTypes.getItemRect(bookmarkTypes.currentIndex);

                itemRect.Move(-futurePos.X, -futurePos.Y);

                if (bookmarkTypes.hlHeight) {
                    this.height = bookmarkTypes.hlHeight;
                    this.y = itemRect.Top;
                }

                if (bookmarkTypes.hlWidth) {
                    this.width = bookmarkTypes.hlWidth;
                    this.x = itemRect.Left;
                }
            }

            updateHighlight: {
                if (bookmarkTypes.visible) {
                    this.doHighlight();
                    crunchTimer.restart();
                }
            }

            Behavior on color { animation: Animation { duration: 300; } }

            Behavior on x {
                id: highlightXAnim;
                animation: Animation {
                    duration: 200;
                }
            }

            Behavior on height { animation: Animation { duration: 200; } }
        }

        Timer {	//TODO: Remove this when GetItemRect will work correctly.
            id: crunchTimer;
            interval: 200;
            repeat: false;
            running: false;

            onTriggered: {
                tabBookmarkTypesHighlight.doHighlight();
                this.stop();
            }
        }

        onActiveFocusChanged: {
            if (activeFocus)
                tabBookmarkTypesHighlight.updateHighlight();
        }

        resetHighlight: {
            tabBookmarkTypesHighlight.x = 0;
            highlightXAnim.complete();
            tabBookmarkTypesHighlight.y = 0;
            highlightYAnim.complete();
        }

        onVisibleChanged: {
            if (visible)
                this.resetHighlight();
        }

        onCountChanged:			{ if (count == 1) tabBookmarkTypesHighlight.updateHighlight(); }	// Call on first element added.
        onWidthChanged: 		{ tabBookmarkTypesHighlight.updateHighlight(); }
        onHeightChanged: 		{ tabBookmarkTypesHighlight.updateHighlight(); }
        onCurrentIndexChanged:	{ tabBookmarkTypesHighlight.updateHighlight(); }
    }

    /**
    * Bookmark Video items
    */
    GridView {
        id: bookmarkVideoItemsList;
        z: 1;
        anchors.top: bookmarkTypes.bottom;
        anchors.left: bookmarkPage.left;
        anchors.right: bookmarkPage.right;
        anchors.bottom: bookmarkPage.bottom;
        anchors.topMargin: appMain.sizes.margin / 1.5;

        cellWidth: appMain.sizes.poster.width + 5;
        cellHeight: (appMain.sizes.poster.height * 2) + 5;
        visible: false;
        focus: false;
        clip: true;
        delegate: VideosDelegate {}
        model: ListModel { id: bookmarkVideoModel; }

        onKeyPressed: {
            if (key === "Up") {
                bookmarkTypes.setFocus();
            } else if (key === "Red") {
                let current = model.get(bookmarkVideoItemsList.currentIndex);
                appMain.addToBookmark(current, "video", "bookmark");
            } else if (key === "Select") {
                const video = bookmarkVideoItemsList.model.get(bookmarkVideoItemsList.currentIndex);
                const url = appMain.config.main + "/videos/" + video.videoId + ".mp4";
                videoItems.playVideo(video.title, url, "bookmark");
            }
        }

        onVisibleChanged: {
            if (visible) {
                // clear video bookmark tab badge
                let bookmarkTypeTab = bookmarkTypes.model.get(0);
                bookmarkTypeTab.badgeInt = 0;
                bookmarkTypes.model.set(0, bookmarkTypeTab);
            }
        }

        // GridView bookmarkVideoItemsList
        property Color highlightColor: appMain.theme.light.background;

        Rectangle {
            id: nutritionHighlight;
            z: 2;

            width: appMain.sizes.poster.width;
            height: appMain.sizes.poster.height * 2;

            visible: bookmarkVideoItemsList.count;

            opacity: parent.activeFocus && bookmarkVideoItemsList.count ? 0.4 : 0.2;
            color: bookmarkVideoItemsList.highlightColor;
            // radius: appMain.sizes.radius;

            updateHighlight: {
                this.doHighlight();
                crunchTimer.restart();
            }

            doHighlight: {
                if (!bookmarkVideoItemsList.model || !bookmarkVideoItemsList.model.count)
                    return;

                var futurePos = bookmarkVideoItemsList.getPositionViewAtIndex(bookmarkVideoItemsList.currentIndex, bookmarkVideoItemsList.positionMode);
                var itemRect = bookmarkVideoItemsList.getItemRect(bookmarkVideoItemsList.currentIndex);
                itemRect.Move(-futurePos.X, -futurePos.Y);

                highlightXAnim.complete();
                highlightYAnim.complete();
                this.y = itemRect.Top;
                this.x = itemRect.Left;
                // this.height = 255;
                // this.width =  280;
                if (this.y != itemRect.Top && this.x != itemRect.Left) {
                    highlightXAnim.complete();
                    highlightYAnim.complete();
                }
            }

            Behavior on y {
                id: highlightYAnim;
                animation: Animation {
                    duration: 250;
                }
            }

            Behavior on x {
                id: highlightXAnim;
                animation: Animation {
                    duration: 250;
                }
            }

            Behavior on width {
                animation: Animation {
                    duration: 250;
                }
            }

            Behavior on height {
                animation: Animation {
                    duration: 250;
                }
            }

            Behavior on opacity { animation: Animation { duration: 300; } }
        }

        Timer {	//TODO: Remove this when GetItemRect will work correctly.
            id: crunchTimer;
            interval: 200;
            repeat: false;
            running: false;

            onTriggered: {
                nutritionHighlight.doHighlight();
                this.stop();
            }
        }

        onContentHeightChanged:	{ nutritionHighlight.updateHighlight(); }
        onContentWidthChanged:	{ nutritionHighlight.updateHighlight(); }
        onCurrentIndexChanged:	{ nutritionHighlight.updateHighlight(); }
        onCountChanged:			{ nutritionHighlight.updateHighlight(); }
    }

    /**
    * Bookmark Exercise items
    */
    ListView {
        id: bookmarkExerciseItemsList;
        anchors.top: bookmarkTypes.bottom;
        anchors.left: bookmarkPage.left;
        anchors.right: bookmarkPage.right;
        anchors.bottom: bookmarkPage.bottom;
        anchors.topMargin: appMain.sizes.margin;
        z: 2;
        orientation: mainWindow.horizontal;

        spacing: 10;
        height: appMain.sizes.exercise.height + 100;
        opacity: 1.0;
        visible: false;
        focus: false;
        clip: true;
        delegate: ExerciseDelegate {}
        model: ListModel { id: bookmarkExerciseItemModel; }

        onKeyPressed: {
            if (key === "Up") {
                bookmarkTypes.setFocus();
            } else if (key === "Red") {
                let current = model.get(bookmarkExerciseItemsList.currentIndex);
                appMain.addToBookmark(current, "exercise", "bookmark");
            } else if (key === "Select") {
                bookmarkPage.openExerciseDetailPage();
            }
        }

        onVisibleChanged: {
            if (visible) {
                // clear exercise bookmark tab badge
                let bookmarkTypeTab = bookmarkTypes.model.get(1);
                bookmarkTypeTab.badgeInt = 0;
                bookmarkTypes.model.set(1, bookmarkTypeTab);
            }
        }

        // ListView exerciseHighlight
        property int hlWidth: appMain.sizes.exercise.width;
        property int hlHeight: appMain.sizes.exercise.height + 100;
        property Color highlightColor: appMain.theme.light.background;

        Rectangle {
            id: exerciseHighlight;
            z: 2;
            color: bookmarkExerciseItemsList.highlightColor;
            opacity: bookmarkExerciseItemsList.activeFocus ? 0.4 : 0.2;
            visible: bookmarkExerciseItemsList.count;

            doHighlight: {
                if (!bookmarkExerciseItemsList || !bookmarkExerciseItemsList.model || !bookmarkExerciseItemsList.count)
                    return;

                var futurePos = bookmarkExerciseItemsList.getPositionViewAtIndex(bookmarkExerciseItemsList.currentIndex, bookmarkExerciseItemsList.positionMode);
                var itemRect = bookmarkExerciseItemsList.getItemRect(bookmarkExerciseItemsList.currentIndex);

                itemRect.Move(-futurePos.X, -futurePos.Y);

                if (bookmarkExerciseItemsList.hlHeight) {
                    this.height = bookmarkExerciseItemsList.hlHeight;
                    this.y = itemRect.Top;
                }

                if (bookmarkExerciseItemsList.hlWidth) {
                    this.width = bookmarkExerciseItemsList.hlWidth;
                    this.x = itemRect.Left;
                }
            }

            updateHighlight: {
                if (bookmarkExerciseItemsList.visible) {
                    this.doHighlight();
                    crunchTimer.restart();
                }
            }

            Behavior on color { animation: Animation { duration: 300; } }


            Behavior on x {
                id: highlightXAnim;
                animation: Animation {
                    duration: 200;
                }
            }

            // Behavior on height { animation: Animation { duration: 200; } }
        }

        Timer {	//TODO: Remove this when GetItemRect will work correctly.
            id: crunchTimer;
            interval: 200;
            repeat: false;
            running: false;

            onTriggered: {
                exerciseHighlight.doHighlight();
                this.stop();
            }
        }

        onActiveFocusChanged: {
            if (activeFocus)
                exerciseHighlight.updateHighlight();
        }

        resetHighlight: {
            exerciseHighlight.x = 0;
            highlightXAnim.complete();
            exerciseHighlight.y = 0;
            highlightYAnim.complete();
        }

        onVisibleChanged: {
            if (visible)
                this.resetHighlight();
        }

        onCountChanged:			{ if (count == 1) exerciseHighlight.updateHighlight(); }	// Call on first element added.
        onWidthChanged: 		{ exerciseHighlight.updateHighlight(); }
        onHeightChanged: 		{ exerciseHighlight.updateHighlight(); }
        onCurrentIndexChanged:	{ exerciseHighlight.updateHighlight(); }
    }

    /**
    * Bookmark Nutrition items
    */
    GridView {
        id: bookmarkNutritionItemsList;
        z: 2;
        anchors.top: bookmarkTypes.bottom;
        anchors.left: bookmarkPage.left;
        anchors.right: bookmarkPage.right;
        anchors.bottom: bookmarkPage.bottom;
        anchors.topMargin: appMain.sizes.margin;

        cellWidth: appMain.sizes.nutrition.width;
        cellHeight: appMain.sizes.nutrition.height + 40;

        visible: false;
        focus: false;
        clip: true;
        delegate: NutritionDelegate {}
        model: ListModel { id: bookmarkNutritionModel; }

        onKeyPressed: {
            if (key === "Up") {
                bookmarkTypes.setFocus();
            } else if (key === "Red") {
                let current = model.get(bookmarkNutritionItemsList.currentIndex);
                appMain.addToBookmark(current, "nutrition", "bookmark");
            } else if (key === "Select") {
                bookmarkPage.openNutritionDetailPage();
            }
        }

        onVisibleChanged: {
            if (visible) {
                // clear nutrition bookmark tab badge
                let bookmarkTypeTab = bookmarkTypes.model.get(2);
                bookmarkTypeTab.badgeInt = 0;
                bookmarkTypes.model.set(2, bookmarkTypeTab);
            }
        }

        // GridView nutritionHighlight
        property Color highlightColor: appMain.theme.light.background;

        Rectangle {
            id: nutritionHighlight;
            z: 2;

            width: bookmarkNutritionItemsList.cellWidth - 5;
            height: bookmarkNutritionItemsList.cellHeight - 5;

            visible: bookmarkNutritionItemsList.count;

            opacity: parent.activeFocus && bookmarkNutritionItemsList.count ? 0.2 : 0.1;
            color: bookmarkNutritionItemsList.highlightColor;
            radius: appMain.sizes.radius;

            updateHighlight: {
                this.doHighlight();
                crunchTimer.restart();
            }

            doHighlight: {
                if (!bookmarkNutritionItemsList.model || !bookmarkNutritionItemsList.model.count)
                    return;

                var futurePos = bookmarkNutritionItemsList.getPositionViewAtIndex(bookmarkNutritionItemsList.currentIndex, bookmarkNutritionItemsList.positionMode);
                var itemRect = bookmarkNutritionItemsList.getItemRect(bookmarkNutritionItemsList.currentIndex);
                itemRect.Move(-futurePos.X, -futurePos.Y);

                highlightXAnim.complete();
                highlightYAnim.complete();
                this.y = itemRect.Top;
                this.x = itemRect.Left;
                if (this.y != itemRect.Top && this.x != itemRect.Left) {
                    highlightXAnim.complete();
                    highlightYAnim.complete();
                }
            }

            Behavior on y {
                id: highlightYAnim;
                animation: Animation {
                    duration: 250;
                }
            }

            Behavior on x {
                id: highlightXAnim;
                animation: Animation {
                    duration: 250;
                }
            }

            Behavior on width {
                animation: Animation {
                    duration: 250;
                }
            }

            Behavior on height {
                animation: Animation {
                    duration: 250;
                }
            }

            Behavior on opacity { animation: Animation { duration: 300; } }
        }

        Timer {	//TODO: Remove this when GetItemRect will work correctly.
            id: crunchTimer;
            interval: 200;
            repeat: false;
            running: false;

            onTriggered: {
                nutritionHighlight.doHighlight();
                this.stop();
            }
        }

        onContentHeightChanged:	{ nutritionHighlight.updateHighlight(); }
        onContentWidthChanged:	{ nutritionHighlight.updateHighlight(); }
        onCurrentIndexChanged:	{ nutritionHighlight.updateHighlight(); }
        onCountChanged:			{ nutritionHighlight.updateHighlight(); }
    }

    /**
    * Get bookmarks
    * @param  {String} type bookmark type
    * gets and appends to models of bookmarks
    */
    function getBookmarks(type) {
        const activeBookmarkType = bookmarkTypes.model.get(bookmarkTypes.currentIndex).type;
        fit.loading = true;
        appMain.httpServer(appMain.config.api.getBookmarks, "GET", {type: activeBookmarkType}, "getBookmarks", (bookmarks) => {
            // reset all bookmarks data
            bookmarkVideoItemsList.bookmarkVideoModel.reset();
            bookmarkExerciseItemsList.bookmarkExerciseItemModel.reset();
            bookmarkNutritionItemsList.bookmarkNutritionModel.reset();
            // hide bookmarks items
            bookmarkVideoItemsList.visible = false;
            bookmarkExerciseItemsList.visible = false;
            bookmarkNutritionItemsList.visible = false;

            // check type bookmark, then add data
            if (type === "video") {
                bookmarks.forEach((vid) => {
                    bookmarkVideoItemsList.bookmarkVideoModel.append({
                        videoId: vid["videoId"],
                        title: vid["title"],
                        bookmark: vid["bookmark"],
                        image: vid["thumbnail"].thumbnails[vid["thumbnail"].thumbnails.length - 1].url
                    });
                });
                bookmarkVideoItemsList.visible = true;
                bookmarkVideoItemsList.setFocus();
            } else if (type === "exercise") {
                bookmarks.forEach((vid) => {
                    bookmarkExerciseItemsList.bookmarkExerciseItemModel.append({
                        id: vid["id"],
                        title: vid["name"],
                        description: vid["text"],
                        bookmark: vid["bookmark"],
                        images: vid["images"]
                    });
                });
                bookmarkExerciseItemsList.visible = true;
                bookmarkExerciseItemsList.setFocus();
            } else if (type === "nutrition") {
                bookmarks.forEach((vid) => {
                    bookmarkNutritionItemsList.bookmarkNutritionModel.append({
                        id: vid["id"],
                        name: vid["name"],
                        steps: vid["steps"],
                        ingredients: vid["ingredients"],
                        bookmark: vid["bookmark"],
                        image: vid["image"] //.split(".")[0]
                    });
                });
                bookmarkNutritionItemsList.visible = true;
                bookmarkNutritionItemsList.setFocus();
            }

            fit.loading = false;
        });
    }

    Text {
        id: errorMessage;
        anchors.centerIn: bookmarkPage;
        opacity: parent.opacity;
        color: "#fff";

        // No items message
        // Video bookmark, Exercise bookmark and Nutrition bookmark
        // Check conditions [loadnig], [model visible] and [model count]
        // if condition true, then show no text
        text: !fit.loading && bookmarkVideoItemsList.visible
                && !bookmarkVideoItemsList.bookmarkVideoModel.count
                ? appLangs.texts[fit.lang].videoNotAdded
                : !fit.loading && bookmarkExerciseItemsList.visible
                && !bookmarkExerciseItemsList.bookmarkExerciseItemModel.count
                ? appLangs.texts[fit.lang].exersicesNotAdded
                : !fit.loading && bookmarkNutritionItemsList.visible
                && !bookmarkNutritionItemsList.bookmarkNutritionModel.count
                ? appLangs.texts[fit.lang].nutritionNotAdded
                : "";

        font: Font {
            family: "Proxima Nova Condensed";
            pixelSize: 28;
            black: true;
        }
    }

    /**
    * Open Exercise Detail Page
    */
    function openExerciseDetailPage() {
        const currentExerciseItemsList = bookmarkExerciseItemsList.model.get(bookmarkExerciseItemsList.currentIndex);

        exerciseDetailContainer.page = "bookmark";

        exerciseDetailContainer.id = currentExerciseItemsList.id;
        exerciseDetailContainer.title = currentExerciseItemsList.title;
        exerciseDetailContainer.description = currentExerciseItemsList.description;
        exerciseDetailContainer.images = currentExerciseItemsList.images;

        bookmarkPage.visible = false;
        exerciseDetailContainer.visible = true;
        exerciseDetailContainer.setFocus();

        // stats
        appMain.httpServer(appMain.config.api.stats, "GET", { type: "exercise" }, "statsExercise", () => {});
    }

    /**
    * Open Nutrition Detail Page
    */
    function openNutritionDetailPage() {
        const currentNutritionItem = model.get(nutritionItems.currentIndex);

        nutritionDetail.page = "bookmark";

        nutritionDetail.id = currentNutritionItem.id;
        nutritionDetail.day = nutritionDays.model.get(nutritionDays.currentIndex).day;
        nutritionDetail.name = currentNutritionItem.name;
        nutritionDetail.steps = currentNutritionItem.steps;
        nutritionDetail.ingredients = currentNutritionItem.ingredients;
        nutritionDetail.image = currentNutritionItem.image;

        bookmarkPage.visible = false;
        nutritionDetail.visible = true;
        nutritionDetail.setFocus();

        // stats
        appMain.httpServer(appMain.config.api.stats, "GET", { type: "nutrition" }, "statsNutrition", () => {});
    }

    onVisibleChanged: {
		if (visible) {
            // clear bookmark tab badge, when visible = true
            let bookmarkTab = tab.model.get(4);
            bookmarkTab.badgeInt = 0;
            tab.model.set(4, bookmarkTab);
        }
	}
}