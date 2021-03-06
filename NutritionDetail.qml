Item {
    id: nutritionDetail;
    z: 2;
    property var stingray: {};
    property bool sended: false;

    property string vkId;

    property string page;
    property string id;
    property int day;
    property string name;
    property string steps;
    property string ingredients;
    property string image;
    property bool bookmark: false;

    opacity: 1.0;
    width: nutritionItems.width;
    height: nutritionItems.height;
    focus: true;

    Text {
        id: nameText;
        z: 3;
        anchors.top: nutritionDetail.top;
        anchors.horizontalCenter: nutritionDetail.horizontalCenter;

        opacity: 1;
        color: fit.isDark ? appMain.theme.dark.textColor : appMain.theme.light.textColor;
        text: nutritionDetail.name;
        font: Font {
            family: "Proxima Nova Condensed";
            pixelSize: 34;
            black: true;
        }
    }

    Image {
        id: imageNutritionDefault;
        anchors.top: nameText.bottom;
        anchors.left: nutritionDetail.left;
        anchors.topMargin: appMain.sizes.margin / 2;

        width: fit.fullscreen ? 450 : 350;
        height: fit.fullscreen ? 300 : 230;
        
        opacity: 1.0;
        visible: imageNutrition.status !== ui.Image.Ready;
        opacity: imageNutrition.status !== ui.Image.Ready ? 1.0 : appMain.config.inactiveOpacity;
        registerInCacheSystem: false;
        source: "apps/fit_app/res/default_nutrition.png";
        fillMode: PreserveAspectFit;
    }

    Image {
        id: imageNutrition;
        anchors.top: nameText.bottom;
        anchors.left: nutritionDetail.left;
        anchors.topMargin: appMain.sizes.margin / 2;

        width: fit.fullscreen ? 450 : 350;
        height: fit.fullscreen ? 300 : 230;

        opacity: 1.0;
        registerInCacheSystem: false;
        source: appMain.config.static + "/images/coverMeal/" + nutritionDetail.image;
        fillMode: PreserveAspectFit;
    }

    ScrollingText {
        id: ingredientsText;
        anchors.top: imageNutrition.top;
        anchors.left: imageNutrition.right;
        anchors.right: nutritionDetail.right;
        anchors.bottom: nutritionDetail.bottom;
        anchors.leftMargin: appMain.sizes.margin / 3;

        opacity: 1.0;
        visible: true;
        color: fit.isDark ? appMain.theme.dark.textColor : appMain.theme.light.textColor;
        text: nutritionDetail.ingredients;
        font: secondaryFont;
    }

    ScrollingText {
        id: stepsText;
        anchors.top: imageNutrition.bottom;
        anchors.left: nutritionDetail.left;
        anchors.right: nutritionDetail.right;
        anchors.bottom: nutritionDetail.bottom;
        anchors.topMargin: appMain.sizes.margin / 2;

        opacity: 1.0;
        visible: true;
        color: fit.isDark ? appMain.theme.dark.textColor : appMain.theme.light.textColor;
        text: nutritionDetail.steps;
        font: secondaryFont;
    }

    Button {
        id: sendSocialNutritionButton;

        anchors.top: stepsText.bottom;
        anchors.horizontalCenter: nameText.horizontalCenter;
        anchors.topMargin: -appMain.sizes.margin;

        color: activeFocus ? appMain.theme.light.background : appMain.theme.dark.layout_background;
        text: appLangs.texts[fit.lang].sendToSocial;
        radius: appMain.sizes.radius;
        visible: true;
        opacity: activeFocus ? 1.0 : appMain.config.inactiveOpacity;
        font: Font {
            pixelSize: 15;
        }

        onSelectPressed: {
            fit.modalController.itemsWillBeInModal = 3;
            fit.modalController.openModal(appModals.social, "nutrition", nutritionDetail.id, sendSocialNutritionButton, fit.lang);
        }
    }

    Image {
        z: 4;

        anchors.top: mainView.top;
        anchors.right: mainView.right;
        anchors.margins: appMain.sizes.margin;

        width: 35;
        height: 25;

        visible: true;
        registerInCacheSystem: false;
        source: nutritionDetail.bookmark ? "apps/fit_app/res/heart_added.png" : "apps/fit_app/res/heart_add.png";
        fillMode: PreserveAspectFit;
    }

    onKeyPressed: {
        if (key === "Red") {
            let current = nutritionItemsList.nutritionModel.get(nutritionItemsList.currentIndex);
            appMain.addToBookmark(current, "nutrition", "main", (boolean) => {
                nutritionDetail.bookmark = boolean;
            });
        }
    }

    onVisibleChanged: {
        nutritionDetail.stingray = fit.stingray;
        sendSocialNutritionButton.setFocus();
    }

    onUpPressed: {
        nutritionDetail.visible = false;
        if (nutritionDetail.page === "main") {
            nutritionPage.visible = true;
            nutritionItems.setFocus();
        } else if (nutritionDetail.page === "bookmark") {
            bookmarkPage.visible = true;
        }
        tab.setFocus();
    }

    onBackPressed: {
        nutritionDetail.visible = false;
        if (nutritionDetail.page === "main") {
            nutritionPage.visible = true;
            nutritionItems.setFocus();
        } else if (nutritionDetail.page === "bookmark") {
            bookmarkPage.visible = true;
            bookmarkExerciseItemsList.setFocus();
        }
    }
}