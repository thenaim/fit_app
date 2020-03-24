import "VideosDelegate.qml";

import "js/app.js" as app;

GridView {
    id: videoItemsList;

    property bool loading: false;

    cellWidth: app.sizes.poster.width;
    cellHeight: app.sizes.poster.height * 2;

    visible: !loading;

    focus: true;
    clip: true;

    delegate: VideosDelegate {}

    model: ListModel { id: videoModel; }

    function getVideos(url) {
        fit.loading = true;

        app.httpServer(url, "GET", { stingray: load("fit_stingray"), token: app.config.token }, (videos) => {
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
            videoItems.setFocus();
        });
    }

    Image {
        id: videoThemeLogo;
        anchors.bottom: videoItemsList.bottom;
        anchors.horizontalCenter: videoItemsList.horizontalCenter;

        opacity: 0.1;
        height: 300;

        registerInCacheSystem: false;
        async: false;
        fillMode: PreserveAspectFit;

        source: "apps/fit_app/res/video_page_" + (fit.isDark ? "dark.png" : "light.png");

        Behavior on width  { animation: Animation { duration: app.config.animationDuration; } }
        Behavior on height { animation: Animation { duration: app.config.animationDuration; } }
    }



    /**
    * GridView videoItemsList
    */
	property Color highlightColor: app.theme.light.background;

	Rectangle {
		id: highlight;
        z: 2;

        width: app.sizes.poster.width - 4;
        height: app.sizes.poster.height * 2 - 12;

        visible: videoItemsList.count;

		opacity: parent.activeFocus && videoItemsList.count ? 0.3 : 0.6;
		color: videoItemsList.highlightColor;
        // radius: app.sizes.radius;

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
