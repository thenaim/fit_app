import "TabDelegate.qml";

ListView {
    id: tabList;
    z: 1;
    orientation: mainWindow.horizontal;
	anchors.horizontalCenter: parent.horizontalCenter;

	width: appMain.sizes.tabCards.width * appMain.tabs.length;
    height: appMain.sizes.tabCards.height;
	focus: true;
	clip: true;
	spacing: 10;
    delegate: TabDelegate {}
    model: ListModel { }

    onCompleted: {
        appMain.tabs.forEach((tab) => {
            model.append(tab);
        });
    }

	onLeftPressed: {
		tabList.currentIndex = tabList.count - 1;
	}

	onRightPressed: {
		tabList.currentIndex = 0;
	}

   /**
    * ListView tabHighlight
    */
    property int hlWidth: appMain.sizes.tabCards.width;
	property int hlHeight: 4;
	property Color highlightColor: appMain.theme.light.background;

	Rectangle {
		id: tabHighlight;
		color: tabList.highlightColor;
        anchors.bottom: tabList.bottom;
		visible: tabList.count;
        z: 1;
        opacity: tabList.activeFocus ? 1 : 0.6;
        radius: appMain.sizes.radius;

		doHighlight: {
			if (!tabList || !tabList.model || !tabList.count)
				return;

			var futurePos = tabList.getPositionViewAtIndex(tabList.currentIndex, tabList.positionMode);
			var itemRect = tabList.getItemRect(tabList.currentIndex);

			itemRect.Move(-futurePos.X, -futurePos.Y);

			if (tabList.hlHeight) {
				this.height = tabList.hlHeight;
				this.y = itemRect.Top;
			}

			if (tabList.hlWidth) {
				this.width = tabList.hlWidth;
				this.x = itemRect.Left;
			}
		}

		updateHighlight: {
			if (tabList.visible) {
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

		Behavior on height { animation: Animation { duration: 200; } }
	}

	Timer {	//TODO: Remove this when GetItemRect will work correctly.
		id: crunchTimer;
		interval: 200;
		repeat: false;
		running: false;

		onTriggered: {
			tabHighlight.doHighlight();
			this.stop();
		}
	}

	onActiveFocusChanged: {
		if (activeFocus)
			tabHighlight.updateHighlight();
	}

	resetHighlight: {
		tabHighlight.x = 0;
		highlightXAnim.complete();
		tabHighlight.y = 0;
		highlightYAnim.complete();
	}

	onVisibleChanged: {
		if (visible)
			this.resetHighlight();
	}

	onCountChanged:			{ if (count == 1) tabHighlight.updateHighlight(); }	// Call on first element added.
	onWidthChanged: 		{ tabHighlight.updateHighlight(); }
	onHeightChanged: 		{ tabHighlight.updateHighlight(); }
	onCurrentIndexChanged:	{ tabHighlight.updateHighlight(); }
}
