Player {
    id: fitPlayer;
    focus: true;
    isFullscreen: true;

    function playVideoByUrl(url, type) {
        fitPlayer.type = type;
        fitPlayer.abort();
        fitPlayer.playUrl(url);
        fitPlayer.setFocus();
    }
}
