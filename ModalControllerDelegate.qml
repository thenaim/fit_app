Button {
	id: modalListButton;
	z: 1;
	opacity: activeFocus ? 1.0 : appMain.config.inactiveOpacity;
	color: activeFocus ? appMain.theme.light.background : appMain.theme.dark.item_background;
	text: model.data;
	radius: appMain.sizes.radius;
	width: parent.width;
}
