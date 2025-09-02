import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Position;
import Toybox.Lang;
import Toybox.System;
import Toybox.Timer;

class MainView extends WatchUi.View {
    private var waypoint as WaypointsController;
    private var activityInfo as ActivityInfoProvider;

    private var arrows as WaypointArrows;

    private var time as Time;
    private var duration as Duration;
    private var speed as Speed;
    private var distance as Distance;

    private var quarterLayout as QuarterLayout;
    private var timerSubscription as TimerSubscription;

    function initialize(
        waypoint as WaypointsController,
        activityInfo as ActivityInfoProvider,
        unitConverter as SettingsBoundUnitConverter,
        settings as SettingsController
    ) {
        View.initialize();

        self.waypoint = waypoint;
        self.activityInfo = activityInfo;

        self.arrows = new WaypointArrows(settings, waypoint);

        self.time = new Time(new TimeProvider(), [0, 0]);
        self.duration = new Duration([0, 0]);
        self.speed = new Speed(unitConverter, [0, 0]);
        self.distance = new Distance(unitConverter, [0, 0]);

        self.quarterLayout = new QuarterLayout(
            self.duration,
            self.time,
            self.distance,
            self.speed
        );

        self.timerSubscription = AppTimer.onUpdate();
    }

    function onLayout(dc as Dc) as Void {
        self.arrows.layout(dc);
        self.quarterLayout.layout(dc);
    }

    function updateArrow(angle as Number) as Void {
    }

    function forceUpdate() as Void {
        self.updateValues();

        WatchUi.requestUpdate();
    }

    function updateValues() as Void {
        self.arrows.update();
        self.duration.setValue(self.activityInfo.duration());
        self.speed.setValue(self.activityInfo.speed());
        self.distance.setValue(self.activityInfo.distance());
    }

    function onUpdate(dc as Dc) as Void {
        var color = Utils.Colors.background;
        dc.setColor(color, color);
        dc.clear();

        self.arrows.draw(dc);
        self.quarterLayout.draw(dc);
    }

    function onShow() as Void {
        self.updateValues();

        self.timerSubscription.start(method(:forceUpdate));

    }

    function onHide() as Void {
        self.timerSubscription.stop();
    }
}
