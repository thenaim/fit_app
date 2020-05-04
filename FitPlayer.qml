import controls.Player;

Player {
    id: fitPlayer;
    focus: true;
    isFullscreen: true;

    function playVideoByUrl(url) {
        fitPlayer.abort();
        fitPlayer.playUrl(url);
        fitPlayer.setFocus();
    }
}
