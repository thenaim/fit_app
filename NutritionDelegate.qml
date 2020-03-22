import "js/app.js" as app;
Rectangle {
    id: nutritionDelegate;
    
    anchors.top: nutritionItems.top;

    width: app.sizes.nutrition.width - 5;
    height: app.sizes.nutrition.height - 5;

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
            id: imageNutrition;
            anchors.top: imageNutritionItem.top;
            opacity: nutritionDelegate.activeFocus ? 1.0 : app.config.inactiveOpacity;

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
            wrapMode: Text.WordWrap;

            font: Font {
                family: "Times";
                pixelSize: 26;
                black: true;
            }
        }
    }
}

