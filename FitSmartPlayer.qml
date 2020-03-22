import controls.Player;

Player {
    id: fitSmartPlayer;

    focus: true;

    isFullscreen: true;

    function playVideos(url) {
        fitSmartPlayer.abort();
        fitSmartPlayer.playUrl(url);
        fitSmartPlayer.setFocus();
    }
}
