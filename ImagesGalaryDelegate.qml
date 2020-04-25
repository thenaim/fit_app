import "js/app.js" as app;

Item {
    id: galaryItems;
    width: parent.height;
    height: parent.height;
    opacity: galaryItems.activeFocus ? 1.0 : 0.8;
    focus: true;

    Image {
        width: parent.height;
        height: parent.height;
        opacity: galaryItems.activeFocus ? 1.0 : 0.8;

        visible: true;
        registerInCacheSystem: false;

        source: app.config.static + "/images/img/" + model.image;

        fillMode: PreserveAspectFit;
    }
}
