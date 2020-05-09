import "js/app.js" as app;
Rectangle {
    id: nutritionDelegate;
	z: 1;
    anchors.top: parent.top;

    width: app.sizes.nutrition.width - 5;
    height: app.sizes.nutrition.height + 35;

    opacity: 1;
    color: fit.isDark ? app.theme.dark.layout_background : app.theme.light.layout_background;
    radius: app.sizes.radius;
    focus: true;

    Item {
        id: imageNutritionItem;
        anchors.top: nutritionDelegate.top;
        anchors.left: nutritionDelegate.left;

        width: app.sizes.nutrition.width - 5;
        height: 185;

        Image {
            id: imageNutritionDefault;
            anchors.top: imageNutritionItem.top;

            width: app.sizes.nutrition.width - 5;
            height: 185;
            
            visible: imageNutrition.status !== ui.Image.Ready;
            opacity: imageNutrition.status !== ui.Image.Ready ? 1.0 : app.config.inactiveOpacity;
            registerInCacheSystem: false;
            source: "apps/fit_app/res/default_nutrition.png";
            fillMode: PreserveAspectFit;
        }

        Image {
            id: imageNutrition;
            anchors.top: imageNutritionItem.top;
            opacity: nutritionDelegate.activeFocus ? 1.0 : 0.8;

            width: app.sizes.nutrition.width - 5;
            height: 185;

            registerInCacheSystem: false;
            source: app.config.static + "/images/coverMeal/" + model.image;
            fillMode: PreserveAspectFit;
        }
    }

    Item {
        id: contentNutritionItem;
        anchors.top: imageNutritionItem.bottom;
        anchors.left: imageNutritionItem.left;
        anchors.leftMargin: 10;
        anchors.rightMargin: 10;
        anchors.bottomMargin: 10;
        width: app.sizes.nutrition.width - 5;
        height: app.sizes.nutrition.height - 5;

        Text {
            id: nutritionText;
            z: 3;
            anchors.top: parent.top;
            anchors.margins: app.sizes.margin / 2;

            width: app.sizes.nutrition.width - 5;
            height: 100;

            opacity: nutritionDelegate.activeFocus ? 1.0 : app.config.inactiveOpacity;
            color: fit.isDark ? app.theme.dark.textColor : app.theme.light.textColor;
            text: app.wrapText(model.name, 28);
            font: Font {
                family: "Proxima Nova Condensed";
                pixelSize: 26;
                black: true;
            }
        }
    }

    Image {
        id: bookmarkImage;
        z: 2;
        anchors.left: nutritionDelegate.left;
        anchors.right: nutritionDelegate.right;
        anchors.bottom: nutritionDelegate.bottom;
        anchors.margins: app.sizes.margin / 2;

        width: 20;
        height: 20;

        visible: true;
        registerInCacheSystem: false;
        source: model.bookmark ? "apps/fit_app/res/heart_added.png" : "apps/fit_app/res/heart_add.png";
        fillMode: PreserveAspectFit;
    }
}

