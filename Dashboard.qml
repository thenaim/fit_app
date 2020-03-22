import "DashboardDelegate.qml";

import "js/app.js" as app;

ListView {
    id: dashboardList;
    opacity: 1.0;

    height: 360;
    width: 280;
    focus: true;
    clip: true;

    model: ListModel {}

    delegate: DashboardDelegate {}

    onCompleted: {
        // TODO: write server side (points and activities)
        // TODO: get and show on dashboard

        // Simple Example
        model.append( { title: "Баллы за Активность", points: 34, percent: 145, color: "#FF005C" });
        model.append( { title: "Баллы за Видео", points: 86, percent: 250, color: "#7C3668"  });
        model.append( { title: "Баллы за Упражнения", points: 22, percent: 121, color: "#3F0B81"  });
    }
}
