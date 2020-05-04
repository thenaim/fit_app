import "js/app.js" as app;
import "Badge.qml";

Rectangle {
    id: typesDelegate;
    z: 1;
    height: parent.height;
    width: parent.typesCardWidth;
    opacity: 1.0;
    color: fit.isDark ? app.theme.dark.item_background : app.theme.light.item_background;
    radius: fit.fullscreen ? 0 : app.sizes.radius;
    focus: true;

    Text {
		id: typesTabText;
        anchors.centerIn: parent;
        opacity: typesDelegate.activeFocus ? 1.0 : app.config.inactiveOpacity;

		color: fit.isDark ? app.theme.dark.textColor : app.theme.light.textColor;

		text: model.title[fit.lang];

 		font: Font {
			  family: "Proxima Nova Condensed";
			  pixelSize: fit.fullscreen ? 34 : 28;
              black: true;
		}
	}

    Rectangle {
        id: badge;
        anchors.top: typesTabText.top;
        anchors.right: typesTabText.right;
        anchors.rightMargin: -(badge.width + 4);

        height: 20;
        width: badgeLength.width + 10;
        radius: app.sizes.radius / 2;

        opacity: 1;
        color: "#f44336";
        visible: model.badgeInt;

        Text {
            id: badgeLength;
            anchors.centerIn: badge;
            opacity: parent.opacity;

            color: "#fff";
            text: model.badgeInt;
            font: Font {
                family: "Proxima Nova Condensed";
                pixelSize: 22;
                black: true;
            }
        }
    }
}



