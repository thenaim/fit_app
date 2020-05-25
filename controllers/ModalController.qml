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
	    width: parent.width - (appMain.sizes.margin * 2);
        height: parent.height - (appMain.sizes.margin * 2);
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
    * @param  {String} lang ru|en
    * @param  {String} itemActiveId
    */
    function openModal(array, type, idContent, elementToFocus, lang, itemActiveId) {
        modalContainerMain.title = array.title[lang];
        modalContainerMain.type = type;
        modalContainerMain.idContent = idContent;
        modalContainerMain.focusElement = elementToFocus;

        // reset model
        modalTypes.model.reset();
        
        // add items
        const activeIndex = array["items"].findIndex(i => i.id == itemActiveId);
        array["items"].forEach((element, index) => {
            modalTypes.model.append({ id: element.id, data: element.data[lang] ? element.data[lang] : element.data });
        });
        modalTypes.currentIndex = activeIndex !== -1 ? activeIndex : 0;

        // show modal and set focus
        this.visible = true;
        modalTypes.setFocus();
    }

    /**
    * Close modal
    */
    function closeModal() {
        this.visible = false;
        this.itemsWillBeInModal = 0;
        modalContainerMain.focusElement.setFocus();
    }

    onVisibleChanged: {
        if (!visible) {
            modalContainerMain.closeModal();
        }
    }

    onBackPressed: {
        modalContainerMain.closeModal();
    }
}
