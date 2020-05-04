Rectangle {
    id: badge;
    property alias newBadges: badgeLength.text;
    property alias atText: false;

    anchors.top: parent.top;
    anchors.right: parent.right;
    anchors.rightMargin: badge.atText ? -(badge.width + 4) : -(badge.width / 2);

    height: 20;
    width: badgeLength.width + 10;
    opacity: parent.opacity;
    color: "#f44336";
    radius: app.sizes.radius / 2;

    Text {
        id: badgeLength;
        anchors.centerIn: badge;
        opacity: parent.opacity;

        color: "#fff";

        font: Font {
            family: "Proxima Nova Condensed";
            pixelSize: 22;
            black: true;
        }
    }
}