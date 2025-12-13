import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Position;
import Toybox.Lang;
import Toybox.System;
import Toybox.Timer;

class MainView extends WatchUi.View {
    private var activityInfo as ActivityInfoProvider;

    private var windDirectionArrow as WindDirectionArrow;
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
        settings as SettingsControllerInterface,
        windDirection as WindDirectionControllerInterface
    ) {
        View.initialize();

        self.activityInfo = activityInfo;

        self.windDirectionArrow = new WindDirectionArrow(settings, windDirection, false);
        self.arrows = new WaypointArrows(settings, waypoint, false);

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
        self.windDirectionArrow.layout(dc);
        self.quarterLayout.layout(dc);
    }

    function forceUpdate() as Void {
        self.updateValues();

        WatchUi.requestUpdate();
    }

    function updateValues() as Void {
        self.windDirectionArrow.update();
        self.arrows.update();
        self.duration.setValue(self.activityInfo.duration());
        self.speed.setValue(self.activityInfo.speed());
        self.distance.setValue(self.activityInfo.distance());
    }

    function onUpdate(dc as Dc) as Void {
        var color = Utils.Colors.background;
        dc.setColor(color, color);
        dc.clear();

        self.windDirectionArrow.draw(dc);
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
