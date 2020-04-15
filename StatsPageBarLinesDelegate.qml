import "js/app.js" as app;

Rectangle {
    id: daysDelegate;
    z: 1;
    height: 2;
    width: 960;
    opacity: 1.0;
    color: fit.isDark ? app.theme.dark.item_background : app.theme.light.item_background;
    focus: true;
}
