import "js/app.js" as app;

Rectangle {
	id: itemRect;

	property alias menuText: textItem.text;

	width: 300;
	height: 41;

	color: itemRect.activeFocus ? app.theme.light.item_background : app.theme.dark.item_background;
	radius: app.sizes.radius;
	focus: true;

	BodyText {
		id: textItem;

		anchors.centerIn: itemRect;

		color: itemRect.activeFocus ? app.theme.light.textColor : app.theme.dark.textColor;
		opacity: itemRect.activeFocus ? 1.0 : app.config.inactiveOpacity;

		font: Font {
			family: "Times";
			pixelSize: itemRect.activeFocus ? 28 : 26;
			black: true;
		}
	}
}
