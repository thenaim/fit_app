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

    // color: "#17a81a";

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

    Text {
        id: stepsText;
        z: 3;
        anchors.top: imageNutrition.top;
        anchors.left: imageNutrition.right;
        anchors.horizontalCenter: imageNutrition.horizontalCenter;
        anchors.topMargin: app.sizes.margin / 6;
        anchors.leftMargin: app.sizes.margin / 3;

        opacity: 1;
        color: fit.isDark ? app.theme.dark.textColor : app.theme.light.textColor;
        text: app.wrapText(nutritionDetail.steps, 44);
        wrapMode: Text.WordWrap;

        font: Font {
            family: "Times";
            pixelSize: 26;
            black: true;
        }
    }

    Image {
        id: vkButtonImage;
        anchors.top: imageNutrition.bottom;
        anchors.horizontalCenter: nameText.horizontalCenter;
        anchors.margins: app.sizes.margin;

        width: 50;
        height: 50;

        visible: false;
        registerInCacheSystem: false;

        source: "apps/fit_app/res/VK_logo.png";

        fillMode: PreserveAspectFit;
    }

    Text {
        id: sendedText;
        z: 3;

        anchors.top: vkButtonImage.bottom;
        anchors.horizontalCenter: nameText.horizontalCenter;
        anchors.margins: app.sizes.margin;

        opacity: 1;
        visible: false;
        color: fit.isDark ? app.theme.dark.textColor : app.theme.light.textColor;
        text: app.texts.nutritionSended;
        wrapMode: Text.WordWrap;

        font: Font {
            family: "Times";
            pixelSize: 26;
            black: true;
        }
    }

    Text {
        id: integrateText;
        z: 3;

        anchors.top: vkButtonImage.bottom;
        anchors.horizontalCenter: nameText.horizontalCenter;
        anchors.margins: app.sizes.margin;

        opacity: 1;
        visible: false;
        color: fit.isDark ? app.theme.dark.textColor : app.theme.light.textColor;
        text: app.texts.notIntegrateSendVk;
        wrapMode: Text.WordWrap;

        font: Font {
            family: "Times";
            pixelSize: 26;
            black: true;
        }
    }

    Button {
        id: vkButton;

        anchors.top: vkButtonImage.bottom;
        anchors.horizontalCenter: nameText.horizontalCenter;
        anchors.margins: app.sizes.margin;

        visible: false;
        opacity: activeFocus ? 1.0 : app.config.inactiveOpacity;

        color: !activeFocus ? app.theme.light.background : "#4680C2";

        text: app.texts.fullNutritionSend;

        onSelectPressed: {
            nutritionDetail.sendVk(nutritionDetail.id);
        }
    }

    function sendVk(id) {
        fit.loading = true;
        app.httpServer(app.config.api.nutritionSend, "GET", { id: id }, "sendVk", (vk) => {

            if (vk.sended) {
                vkButton.visible = false;
                sendedText.visible = true;
            };

            fit.loading = false;
            nutritionDetail.setFocus();
        });
    }

    onVisibleChanged: {
        nutritionDetail.stingray = fit.stingray;

        // On page load check vkIntegrated or not
        // integrate texts and button hide/show
        if (nutritionDetail.stingray.vkIntegrated) {
            sendedText.visible = false;
            integrateText.visible = false
            vkButton.visible = true;
            vkButtonImage.visible = true;
        } else {
            sendedText.visible = false;
            integrateText.visible = true
            vkButton.visible = false;
            vkButtonImage.visible = true;
        }

        vkButton.setFocus();
    }

    onUpPressed: {
        // integrate texts and button
        sendedText.visible = false;
        integrateText.visible = true
        vkButton.visible = false;
        vkButtonImage.visible = true;

        // go back
        nutritionDetail.visible = false;
        nutritionItems.visible = true;
        tab.setFocus();
    }

    onBackPressed: {
        // integrate texts and button
        sendedText.visible = false;
        integrateText.visible = true
        vkButton.visible = false;
        vkButtonImage.visible = true;

        // go back
        nutritionDetail.visible = false;
        nutritionDays.visible = true;
        nutritionItems.visible = true;
        nutritionItems.setFocus();
    }
}