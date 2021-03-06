Rectangle {
    id: nutritionDelegate;
	z: 1;
    anchors.top: parent.top;

    width: appMain.sizes.nutrition.width - 5;
    height: appMain.sizes.nutrition.height + 35;

	opacity: activeFocus ? 1.0 : appMain.config.inactiveOpacity;
    color: fit.isDark ? appMain.theme.dark.layout_background : appMain.theme.light.layout_background;
    radius: appMain.sizes.radius;
    focus: true;

    Item {
        id: imageNutritionItem;
        anchors.top: nutritionDelegate.top;
        anchors.left: nutritionDelegate.left;

        width: appMain.sizes.nutrition.width - 5;
        height: 185;

        Image {
            id: imageNutritionDefault;
            anchors.top: imageNutritionItem.top;

            width: appMain.sizes.nutrition.width - 5;
            height: 185;
            
            visible: imageNutrition.status !== ui.Image.Ready;
            opacity: imageNutrition.status !== ui.Image.Ready ? 1.0 : appMain.config.inactiveOpacity;
            registerInCacheSystem: false;
            source: "apps/fit_app/res/default_nutrition.png";
            fillMode: PreserveAspectFit;
        }

        Image {
            id: imageNutrition;
            anchors.top: imageNutritionItem.top;
            opacity: nutritionDelegate.activeFocus ? 1.0 : 0.8;

            width: appMain.sizes.nutrition.width - 5;
            height: 185;

            registerInCacheSystem: false;
            source: appMain.config.static + "/images/coverMeal/" + model.image;
            fillMode: PreserveAspectFit;
        }

        Rectangle {
            id: typeNut;
            z: 3;
            anchors.right: imageNutritionItem.right;
            anchors.bottom: imageNutritionItem.bottom;
            anchors.margins: appMain.sizes.margin / 2;
            radius: 10;
            width: 100;
            height: 30;

            opacity: imageNutritionItem.activeFocus ? 1.0 : 0.8;
            color: fit.isDark ? appMain.theme.dark.item_background : appMain.theme.light.item_background;
            focus: true;

            Text {
                id: indexTxt;
                anchors.centerIn: parent;

                opacity: imageNutritionItem.activeFocus ? 1.0 : 0.8;
                color: fit.isDark ? appMain.theme.dark.textColor : appMain.theme.light.textColor;
                text: model.type;
                font: Font {
                    family: "Proxima Nova Condensed";
                    pixelSize: 26;
                    black: true;
                }
            }
        }
    }

    Item {
        id: contentNutritionItem;
        anchors.top: imageNutritionItem.bottom;
        anchors.left: imageNutritionItem.left;
        anchors.leftMargin: 10;
        anchors.rightMargin: 10;
        anchors.bottomMargin: 10;
        width: appMain.sizes.nutrition.width - 5;
        height: appMain.sizes.nutrition.height - 5;

        Text {
            id: nutritionText;
            z: 3;
            anchors.top: parent.top;
            anchors.margins: appMain.sizes.margin / 2;

            width: appMain.sizes.nutrition.width - 5;
            height: 100;

            opacity: nutritionDelegate.activeFocus ? 1.0 : appMain.config.inactiveOpacity;
            color: fit.isDark ? appMain.theme.dark.textColor : appMain.theme.light.textColor;
            text: appMain.wrapText(model.name, 28);
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

        anchors.horizontalCenter: nutritionDelegate.horizontalCenter;
        anchors.bottom: nutritionDelegate.bottom;
        anchors.margins: appMain.sizes.margin / 2;

        width: 25;
        height: 25;

        visible: true;
        registerInCacheSystem: false;
        source: model.bookmark ? "apps/fit_app/res/heart_added.png" : "apps/fit_app/res/heart_add.png";
        fillMode: PreserveAspectFit;
    }
}

