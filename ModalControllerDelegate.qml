import "js/app.js" as app;
import "js/languages.js" as appLangs;

Button {
	id: modalListButton;
	z: 1;
	opacity: activeFocus ? 1.0 : app.config.inactiveOpacity;
	color: activeFocus ? app.theme.light.background : app.theme.dark.item_background;
	text: model.data;
	radius: app.sizes.radius;
	width: parent.width;
}
