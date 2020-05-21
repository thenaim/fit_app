Item {
	id: modalListContainer;
	// add margin to top if button id is [cancel]
	height: model.id === "cancel" ? modalListButton.height + appMain.sizes.margin : modalListButton.height;
	width: parent.width;
	focus: true;

	Button {
		id: modalListButton;
		anchors.bottom: modalListContainer.bottom;
		z: 1;
		opacity: modalListContainer.activeFocus ? 1.0 : appMain.config.inactiveOpacity;
		color: modalListContainer.activeFocus ? appMain.theme.light.background : appMain.theme.dark.item_background;
		text: model.data;
		radius: appMain.sizes.radius;
		width: parent.width;
	}
}
