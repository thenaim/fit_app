import "js/app.js" as app;
import controls.Button;

Item {
    id: nutritionDetail;
    z: 2;
    property var stingray: {};
    property bool sended: false;

    property string vkId; 
    property int id;
    property string name;
    property string steps;
    property string ingredients;
    property string image;

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
        color: fit.isDark ? app.theme.dark.textColor : app.theme.light.textColor;
        text: nutritionDetail.name;
        wrapMode: Text.WordWrap;

        font: Font {
            family: "Times";
            pixelSize: 34;
            black: true;
        }
    }

    Image {
        id: imageNutrition;
        anchors.top: nameText.bottom;
        anchors.left: nutritionDetail.left;
        anchors.topMargin: app.sizes.margin / 2;
        opacity: 1.0;

        width: 350;
        height: 230;

        registerInCacheSystem: false;

        source: app.config.static + "/images/coverMeal/" + nutritionDetail.image;

        fillMode: PreserveAspectFit;
    }

    ScrollingText {
        id: ingredientsText;
        anchors.top: imageNutrition.top;
        anchors.left: imageNutrition.right;
        anchors.right: nutritionDetail.right;
        anchors.bottom: nutritionDetail.bottom;
        anchors.leftMargin: app.sizes.margin / 3;

        opacity: 1.0;

        visible: true;
        color: fit.isDark ? app.theme.dark.textColor : app.theme.light.textColor;
        text: nutritionDetail.ingredients;

        font: secondaryFont;
    }

    ScrollingText {
        id: stepsText;
        anchors.top: imageNutrition.bottom;
        anchors.left: nutritionDetail.left;
        anchors.right: nutritionDetail.right;
        anchors.bottom: nutritionDetail.bottom;
        anchors.topMargin: app.sizes.margin / 2;

        opacity: 1.0;

        visible: true;
        color: fit.isDark ? app.theme.dark.textColor : app.theme.light.textColor;
        text: nutritionDetail.steps;

        font: secondaryFont;
    }

    Button {
        id: vkButton;

        anchors.top: stepsText.bottom;
        anchors.horizontalCenter: nameText.horizontalCenter;
        anchors.topMargin: -app.sizes.margin;

        color: activeFocus ? "#4680C2" : app.theme.light.background;
        text: "Отправить в социальные сети";
        radius: app.sizes.radius;
        visible: true;
        opacity: activeFocus ? 1.0 : app.config.inactiveOpacity;
        font: Font {
            pixelSize: 15;
        }

        onSelectPressed: {
            sendSocial.visible = true;
            sendSocial.showSendSocial("nutrition", nutritionDetail.id);
        }
    }

    onVisibleChanged: {
        nutritionDetail.stingray = fit.stingray;
        vkButton.setFocus();
    }

    onUpPressed: {
        // go back
        nutritionDetail.visible = false;
        nutritionItems.visible = true;
        nutritionDays.visible = true;
        tab.setFocus();
    }

    onBackPressed: {
        // go back
        nutritionDetail.visible = false;
        nutritionItems.visible = true;
        nutritionDays.visible = true;
        nutritionItems.setFocus();
    }
}