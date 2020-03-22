import "js/app.js" as app;

Item {
    z: 1;
    height: 140;
    width: 280;

    Text {
		id: progressText;
        // anchors.bottomMargin: app.sizes.margin; 
        opacity: 1.0;

		color: fit.isDark ? app.theme.dark.textColor : app.theme.light.textColor;

		text: model.title;

 		font: Font {
			  family: "Times";
			  pixelSize: 32;
              black: true;
		}
	}
    Rectangle {
        id: progressDelegate;
        anchors.top: progressText.bottom;
        anchors.topMargin: app.sizes.margin;
        z: 1;
        height: 100;
        width: 280;
        radius: 12;

        opacity: 1.0;
        color: fit.isDark ? app.theme.dark.layout_background : app.theme.light.layout_background;

        focus: true;

        Rectangle {
            id: progressBar;
            z: 10;
            anchors.top: progressDelegate.top;
            anchors.left: progressDelegate.left;
            anchors.topMargin: 2;
            anchors.leftMargin: 2;
            // anchors.right: progressDelegate.right;
            height: 96;
            width: model.percent;
            radius: 12;

            opacity: 1.0;
            color: model.color;

            focus: true;

            BodyText {
                id: categoryText;
                anchors.verticalCenter: parent.verticalCenter;
                anchors.horizontalCenter: parent.horizontalCenter;
                text: model.points + "/1000";
                font.pointSize: 14;

                color: fit.isDark ? app.theme.dark.textColor : app.theme.light.textColor;
            }
        }
    }
}



