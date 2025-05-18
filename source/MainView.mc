import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Position;
import Toybox.Lang;
import Toybox.System;
import Toybox.Timer;

class MainView extends WatchUi.View {
    private var waypoint as WaypointController;
    private var activityInfo as ActivityInfoProvider;

    private var arrow as Arrow;

    private var updateTimer as Timer.Timer;
    private var time as Time;
    private var duration as Duration;
    private var speed as Speed;
    private var distance as Distance;

    private var quarterLayout as QuarterLayout;

    function initialize(
        waypoint as WaypointController,
        activityInfo as ActivityInfoProvider,
        unitConverter as SettingsBoundUnitConverter
    ) {
        View.initialize();

        self.waypoint = waypoint;
        self.activityInfo = activityInfo;

        self.arrow = new Arrow(Utils.Sizing.arrow);

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

        self.updateTimer = new Timer.Timer();
    }

    function onLayout(dc as Dc) as Void {
        self.arrow.layout(dc);
        self.quarterLayout.layout(dc);
    }

    function updateArrow(angle as Number) as Void {
    }

    function forceUpdate() as Void {
        self.updateValues();

        WatchUi.requestUpdate();
    }

    function updateValues() as Void {
        self.arrow.setAngle(self.waypoint.angle());      
        self.duration.setValue(self.activityInfo.duration());
        self.speed.setValue(self.activityInfo.speed());
        self.distance.setValue(self.activityInfo.distance());
    }

    function onUpdate(dc as Dc) as Void {
        var color = Utils.Colors.background;
        dc.setColor(color, color);
        dc.clear();

        self.arrow.draw(dc);
        self.quarterLayout.draw(dc);
    }

    function onShow() as Void {
        self.updateValues();
        self.updateTimer.start(method(:forceUpdate), 1000, true);
    }

    function onHide() as Void {
        self.updateTimer.stop();
    }
}
