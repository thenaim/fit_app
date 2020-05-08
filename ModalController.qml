import "ModalControllerDelegate.qml";

import "js/app.js" as app;
import "js/languages.js" as appLangs;

Rectangle {
	id: modalContainerMain;
    property string type: "language";
    property string idContent: "language";
	signal selectedModalItem(selected, type, idContent);

	color: fit.isDark ? app.theme.dark.layout_background : app.theme.light.layout_background;
	radius: app.sizes.radius;

    /**
    * Modal list item
    */
    ListView {
        id: modalTypes;
        anchors.top: modalContainerMain.top;
        anchors.horizontalCenter: modalContainerMain.horizontalCenter;
        anchors.margins: app.sizes.margin;
        opacity: 1.0;
        spacing: 10;
	    width: parent.width - (app.sizes.margin * 2);
        height: parent.height - (app.sizes.margin * 2);
        focus: true;
        clip: true;

        model: ListModel {}

        delegate: ModalControllerDelegate {}

        onKeyPressed: {
            let current = modalTypes.model.get(modalTypes.currentIndex);
            if (key === "Up") {
                modalTypes.currentIndex = (model.count - 1);
            } else if (key === "Down") {
                modalTypes.currentIndex = 0;
            } else if (key === "Select") {
                modalContainerMain.selectedModalItem(current, modalContainerMain.type, modalContainerMain.idContent);
            }
        }
    }

    /**
    * Adding data to modal list
    * 
    * @param  {Array} array
    * @param  {String} type items type
    * id, data
    */
    function openModal(array, type, idContent) {
        modalContainerMain.type = type;
        modalContainerMain.idContent = idContent || "";

        // reset model
        modalTypes.model.reset();
        
        // add items
        array.forEach((lang, index) => {
            modalTypes.model.append(lang);

            // add cancel button on end
            if (index === array.length - 1) {
                modalTypes.model.append({
                    id: "cancel",
                    data: appLangs.texts[fit.lang].cancel
                });
            }
        });

        // show modal and set focus
        fit.modalController.visible = true;
        modalTypes.setFocus();
    }

    onBackPressed: {
        fit.modalController.visible = false;
    }
}
