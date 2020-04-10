import "js/app.js" as app;
import controls.Button;

Item {
    id: statsPage;

    z: 1;

    Text {
        id: statsTodo;
        z: 3;

        anchors.top: statsPage.top;
        anchors.left: statsPage.left;
        anchors.topMargin: app.sizes.margin;

        opacity: 1;
        visible: true;
        color: fit.isDark ? app.theme.dark.textColor : app.theme.light.textColor;
        text: "TODO: Add stats data";
        wrapMode: Text.WordWrap;

        font: Font {
            family: "Times";
            pixelSize: 30;
            black: true;
        }
    }

    onVisibleChanged: {}
}