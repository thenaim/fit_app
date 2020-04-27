import "SendSocialItem.qml";

import "js/app.js" as app;

Rectangle {
	id: sendSocialContainer;
	property string type;
    property string id;
	property int day;
	property string option;

	color: fit.isDark ? app.theme.dark.layout_background : app.theme.light.layout_background;
	radius: app.sizes.radius;

	visible: false;

	Text {
		id: sendSocialText;
        opacity: 1.0;

        anchors.top: sendSocialContainer.top;
        anchors.horizontalCenter: sendSocialContainer.horizontalCenter;
        anchors.topMargin: app.sizes.margin / 1.2;

		color: fit.isDark ? app.theme.dark.textColor : app.theme.light.textColor;

		text: "Отправьте в ВК или Телеграм";

 		font: Font {
			  family: "Proxima Nova Condensed";
			  pixelSize: 30;
              black: true;
		}
	}

	Column {
		id: sendSocialColumn;
		anchors.top: sendSocialText.bottom;
        anchors.horizontalCenter: sendSocialContainer.horizontalCenter;
        anchors.topMargin: app.sizes.margin / 1.2;

		height: sendSocialContainer.height - 66;

		spacing: 10;
		focus: false;

		SendSocialItem {
			id: vkSendButton;

			menuText: app.texts[fit.lang].sendToVk;

			onSelectPressed: {
				const stingray = JSON.parse(load("fit_stingray"));
				if (stingray.vkIntegrated) {
					app.httpServer(app.config.api.sendToSocial, "GET", {
						type: sendSocialContainer.type,
						id: sendSocialContainer.id,
						day: sendSocialContainer.day,
						option: sendSocialContainer.option,
						social: "vk"
					}, "vkButton", (ok) => {

						if (ok.sended) {
							vkSendButton.menuText = app.texts[fit.lang].sended;
							timerSend.start();
							fit.showNotification(sendSocialContainer.type === "nutrition" ? "Рецепт успешно отправлен!" : "Упражнения успешно отправлен!");
						};
					});
				} else {
					fit.showNotification(app.texts[fit.lang].vkNotIntegrated);
				}
			}
		}

		SendSocialItem {
			id: tgSendButton;

			menuText: app.texts[fit.lang].sendToTg;

			onSelectPressed: {
				const stingray = JSON.parse(load("fit_stingray"));
				if (stingray.tgIntegrated) {
					app.httpServer(app.config.api.sendToSocial, "GET", {
						type: sendSocialContainer.type,
						id: sendSocialContainer.id,
						day: sendSocialContainer.day,
						option: sendSocialContainer.option,
						social: "tg"
					}, "vkButton", (ok) => {

						if (ok.sended) {
							tgSendButton.menuText = app.texts[fit.lang].sended;
							timerSend.start();
							fit.showNotification(sendSocialContainer.type === "nutrition" ? "Рецепт успешно отправлен!" : "Упражнения успешно отправлен!");
						}
					});
				} else {
					fit.showNotification(app.texts[fit.lang].tgNotIntegrated);
				}
			}
		}

		SendSocialItem {
			id: cancelSend;

			menuText: app.texts[fit.lang].cancel;

			onSelectPressed: { 
				sendSocialContainer.visible = false;
				vkButton.setFocus();
			}
		}

		function sendSocialMessage(type, id, day, option, social) {
			app.httpServer(app.config.api.sendToSocial, "GET", {
				type: type,
				id: id,
				day: day,
				option: option,
				social: social
				}, "vkButton", (ok) => {

				if (ok.sended) {
					if (social === "vk") {
						vkSendButton.menuText = app.texts[fit.lang].sended;
						timerSend.start();
					}
					if (social === "tg") {
						tgSendButton.menuText = app.texts[fit.lang].sended;
						timerSend.start();
					}
				};
			});
		}
	}

	function showSendSocial(type, id, day, option) {
		sendSocialContainer.type = type;
		sendSocialContainer.id = id
		sendSocialContainer.day = day;
		sendSocialContainer.option = option;
		sendSocialColumn.setFocus();
	}

	Timer {
		id: timerSend;
		interval: 5000;
		repeat: false;
		
		onTriggered: {
            this.stop();
			vkSendButton.menuText = app.texts[fit.lang].sendToVk;
			tgSendButton.menuText = app.texts[fit.lang].sendToTg;
		}
	}

    onBackPressed: {
		sendSocialContainer.visible = false;
		vkButton.setFocus();
    }

	onKeyPressed: {}
}
