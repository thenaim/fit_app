import "VideosDelegate.qml";

GridView {
    id: videoItemsList;
	z: 2;

    cellWidth: appMain.sizes.poster.width + 5;
    cellHeight: (appMain.sizes.poster.height * 2) + 5;

    focus: false;
    clip: true;
    delegate: VideosDelegate {}
    model: ListModel { id: videoModel; }

    function getVideos(url) {
        appMain.httpServer(url, "GET", {}, "getVideos", (videos) => {
        	videoItemsList.videoModel.reset();
            if (videos.length) {
                videos.forEach((vid) => {
                    videoItemsList.videoModel.append({
                        videoId: vid["videoId"],
                        title: vid["title"],
                        bookmark: vid["bookmark"],
                        image: vid["thumbnail"].thumbnails[vid["thumbnail"].thumbnails.length - 1].url
                    });
                });
            };

            fit.loading = false;
        });
    }

    /**
    * GridView videoItemsList
    */
	property Color highlightColor: appMain.theme.light.background;

	Rectangle {
		id: highlight;
		z: 1;

        width: appMain.sizes.poster.width;
        height: appMain.sizes.poster.height * 2;
        visible: videoItemsList.count && !parent.activeFocus;
		opacity: parent.activeFocus && videoItemsList.count ? 0.2 : 0.1;
		color: videoItemsList.highlightColor;
        // radius: appMain.sizes.radius;

		updateHighlight: {
			this.doHighlight();
			crunchTimer.restart();
		}

		doHighlight: {
			if (!videoItemsList.model || !videoItemsList.model.count)
				return;

			var futurePos = videoItemsList.getPositionViewAtIndex(videoItemsList.currentIndex, videoItemsList.positionMode);
			var itemRect = videoItemsList.getItemRect(videoItemsList.currentIndex);
			itemRect.Move(-futurePos.X, -futurePos.Y);

			highlightXAnim.complete();
			highlightYAnim.complete();
			this.y = itemRect.Top;
			this.x = itemRect.Left;
			// this.height = 255;
			// this.width =  280;
			if (this.y != itemRect.Top && this.x != itemRect.Left) {
				highlightXAnim.complete();
				highlightYAnim.complete();
			}
		}

		Behavior on y {
			id: highlightYAnim;
			animation: Animation {
				duration: 250;
			}
		}

		Behavior on x {
			id: highlightXAnim;
			animation: Animation {
				duration: 250;
			}
		}

		Behavior on width {
			animation: Animation {
				duration: 250;
			}
		}

		Behavior on height {
			animation: Animation {
				duration: 250;
			}
		}

		Behavior on opacity { animation: Animation { duration: 300; } }
	}

	Timer {	//TODO: Remove this when GetItemRect will work correctly.
		id: crunchTimer;
		interval: 200;
		repeat: false;
		running: false;

		onTriggered: {
			highlight.doHighlight();
			this.stop();
		}
	}

	onContentHeightChanged:	{ highlight.updateHighlight(); }
	onContentWidthChanged:	{ highlight.updateHighlight(); }
	onCurrentIndexChanged:	{ highlight.updateHighlight(); }
	onCountChanged:			{ highlight.updateHighlight(); }
}
