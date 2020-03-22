import "TabDelegate.qml";

import "js/app.js" as app;

ListView {
    id: tabList;

    orientation: dashboardList.horizontal;
    property bool loading: false;

    visible: !loading;
    z: 1;
    height: app.sizes.tabCards.height;

    delegate: TabDelegate {}
    model: ListModel { }

    onCompleted: {
        app.tabs.forEach((tab) => {
            model.append({ id: tab.id, title: tab.title, url: tab.url });
        });
    }

   /**
    * ListView tabHighlight
    */
    property int hlWidth: app.sizes.tabCards.width - 21;
	property int hlHeight: 4;
	property Color highlightColor: app.theme.light.background;

	Rectangle {
		id: tabHighlight;
		color: tabList.highlightColor;
        anchors.top: tabList.bottom;
        // anchors.left: tabList.left;
		// visible: tabList.count;
        z: 1;
        opacity: 1;
        radius: app.sizes.radius;

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
