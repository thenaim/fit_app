Player {
    id: fitPlayerMusic;
    focus: true;
    isFullscreen: true;

    function playMusicByUrl(url) {
        fitPlayerMusic.abort();
        fitPlayerMusic.playUrl(url);
        fitPlayerMusic.setFocus();
    }
}
