import "ChipsDelegate.qml";

ListView {
    id: chipsList;
    z: 1;
    property int position: 0;
    orientation: mainWindow.horizontal;

    height: appMain.sizes.chips.height;
    spacing: 10;
    focus: true;
    clip: true;
    delegate: ChipsDelegate {}
    model: ListModel { id: chipModel; }

    function getChips(url, callback) {
        appMain.httpServer(url, "GET", {}, "getChips", (chips) => {
            chipsList.chipModel.reset();
            if (chips.length) {
                chipsList.width = appMain.sizes.chips.width * chips.length;
                chips.forEach((vid) => {
                    chipsList.chipModel.append({
                        id: vid.id,
                        id_type: vid.id_type,
                        name: vid.name,
                        image: vid.image
                    });
                });
                callback(true);
            }
        });
    }

    /**
    * ListView chipHighlight
    */
    property int hlWidth: appMain.sizes.chips.width;
	property int hlHeight: 4;
	property Color highlightColor: appMain.theme.light.background;

	Rectangle {
		id: chipHighlight;
		anchors.top: chipsList.bottom;
		anchors.topMargin: - 4;
		color: chipsList.highlightColor;
        z: 2;
        opacity: 1;
        radius: appMain.sizes.radius;

		doHighlight: {
			if (!chipsList || !chipsList.model || !chipsList.count)
				return;

			var futurePos = chipsList.getPositionViewAtIndex(chipsList.currentIndex, chipsList.positionMode);
			var itemRect = chipsList.getItemRect(chipsList.currentIndex);

			itemRect.Move(-futurePos.X, -futurePos.Y);

			if (chipsList.hlHeight) {
				this.height = chipsList.hlHeight;
				this.y = itemRect.Top;
			}

			if (chipsList.hlWidth) {
				this.width = chipsList.hlWidth;
				this.x = itemRect.Left;
			}
		}

		updateHighlight: {
			if (chipsList.visible) {
				this.doHighlight();
				crunchTimer.restart();
			}
		}

		Behavior on color { animation: Animation { duration: 300; } }

		Behavior on x {
			id: highlightXAnim;
			animation: Animation {
				duration: 200;
			}
		}
	}

	Timer {
		id: crunchTimer;
		interval: 200;
		repeat: false;
		running: false;

		onTriggered: {
			chipHighlight.doHighlight();
			this.stop();
		}
	}

	onActiveFocusChanged: {
		if (activeFocus)
			chipHighlight.updateHighlight();
	}

	resetHighlight: {
		chipHighlight.x = 0;
		highlightXAnim.complete();
		chipHighlight.y = 0;
		highlightYAnim.complete();
	}

	onVisibleChanged: {
		if (visible)
			this.resetHighlight();
	}

	onCountChanged:			{ if (count == 1) chipHighlight.updateHighlight(); }	// Call on first element added.
	onWidthChanged: 		{ chipHighlight.updateHighlight(); }
	onHeightChanged: 		{ chipHighlight.updateHighlight(); }
	onCurrentIndexChanged:	{ chipHighlight.updateHighlight(); }
}
