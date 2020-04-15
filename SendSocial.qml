import "SendSocialItem.qml";

import "js/app.js" as app;

Rectangle {
	id: sendSocial;
	property string type;
    property int id;

	color: fit.isDark ? app.theme.dark.layout_background : app.theme.light.layout_background;
	radius: app.sizes.radius;

	visible: false;

	Text {
		id: sendSocialText;
        opacity: 1.0;

        anchors.top: sendSocial.top;
        anchors.horizontalCenter: sendSocial.horizontalCenter;
        anchors.topMargin: app.sizes.margin / 1.2;

		color: fit.isDark ? app.theme.dark.textColor : app.theme.light.textColor;

		text: "Отправьте в ВК или Телеграм";

 		font: Font {
			  family: "Times";
			  pixelSize: 30;
              black: true;
		}
	}

	Column {
		id: sendSocialColumn;
		anchors.top: sendSocialText.bottom;
        anchors.horizontalCenter: sendSocial.horizontalCenter;
        anchors.topMargin: app.sizes.margin / 1.2;

		height: sendSocial.height - 66;

		spacing: 10;
		focus: false;

		SendSocialItem {
			id: vkSendButton;

			menuText: "Отправить в ВК";

			onSelectPressed: {
				if (fit.stingray.vkIntegrated) {
					fit.showNotification("Успешно отправлено в ВК!");
				} else {
					fit.showNotification("ВК не интегрирован.");
				}
			}
		}

		SendSocialItem {
			id: tgSendButton;

			menuText: "Отправить в Телеграм";

			onSelectPressed: { 
				if (fit.stingray.tgIntegrated) {
					fit.showNotification("Успешно отправлено в Телеграм!");
				} else {
					fit.showNotification("Телеграм не интегрирован.");
				}
			}
		}

		SendSocialItem {
			id: cancelSend;

			menuText: "Отменить";

			onSelectPressed: { 
				sendSocial.visible = false;
				vkButton.setFocus();
			}
		}
	}

	function showSendSocial(type, id) {
		sendSocial.type = type;
		sendSocial.id = +id
		sendSocialColumn.setFocus();
	}

    onBackPressed: {
		sendSocial.visible = false;
		vkButton.setFocus();
    }

	onKeyPressed: {}
}
