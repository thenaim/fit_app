import "ModalControllerDelegate.qml";

Rectangle {
	id: modalContainerMain;
    property var focusElement;

    property string title: "";
    property string type: "";
    property string idContent: "";

	signal selectedModalItem(selected, type, idContent);

	color: fit.isDark ? appMain.theme.dark.layout_background : appMain.theme.light.layout_background;
	radius: appMain.sizes.radius;

    Text {
        id: modalTitle;
        z: 3;
        anchors.top: modalContainerMain.top;
        anchors.horizontalCenter: nutritionDetail.horizontalCenter;
        anchors.margins: appMain.sizes.margin;

        opacity: 1;
        color: fit.isDark ? appMain.theme.dark.textColor : appMain.theme.light.textColor;
        text: appMain.wrapText(modalContainerMain.title, 40);
        font: Font {
            family: "Proxima Nova Condensed";
            pixelSize: 28;
            black: true;
        }
    }

    /**
    * Modal list item
    */
    ListView {
        id: modalTypes;
        anchors.top: modalTitle.bottom;
        anchors.left: modalContainerMain.left;
        anchors.right: modalContainerMain.right;
        anchors.bottom: modalContainerMain.bottom;
        anchors.margins: appMain.sizes.margin;

        opacity: 1.0;
        spacing: 10;
	    width: modalController.width - (appMain.sizes.margin * 2);
        height: modalController.height - (appMain.sizes.margin * 2);
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
                if (current.id === "cancel") {
                    modalContainerMain.closeModal();
                } else {
                    modalContainerMain.selectedModalItem(current, modalContainerMain.type, modalContainerMain.idContent);
                }
            }
        }
    }

    /**
    * Adding data to modal list
    * 
    * @param  {Array} array
    * @param  {String} type items type
    * @param  {String} idContent optional
    * @param  {Element} elementToFocus to focus on close or confirm
    */
    function openModal(array, type, idContent, elementToFocus) {
        modalContainerMain.title = array.title[fit.lang];
        modalContainerMain.type = type;
        modalContainerMain.idContent = idContent;
        modalContainerMain.focusElement = elementToFocus;

        // reset model
        modalTypes.model.reset();
        
        // add items
        array["items"].forEach((element, index) => {
            modalTypes.model.append({ id: element.id, data: element.data[fit.lang] ? element.data[fit.lang] : element.data });
        });

        // show modal and set focus
        fit.modalController.visible = true;
        modalTypes.setFocus();
    }

    /**
    * Close modal
    */
    function closeModal() {
        modalController.visible = false;
        modalController.itemsWillBeInModal = 0;
        modalContainerMain.focusElement.setFocus();
    }

    onBackPressed: {
        modalContainerMain.closeModal();
    }
}
