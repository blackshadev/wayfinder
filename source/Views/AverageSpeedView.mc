import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Position;
import Toybox.Lang;
import Toybox.System;
import Toybox.Timer;

class AverageSpeedView extends WatchUi.View {
    private var activityInfo as ActivityInfoProvider;
    private var averageSpeeds as AverageSpeedsProvider;

    private var arrows as WaypointArrows;
    private var time as Time;
    private var currentSpeed as CurrentSpeed;
    private var avgSpeeds as AverageSpeeds;
    private var avgSpeeds2 as AverageSpeeds2;

    private var quarterLayout as QuarterLayout;
    
    private var timerSubscription as TimerSubscription;

    function initialize(
        waypoint as WaypointsController,
        activityInfo as ActivityInfoProvider,
        averageSpeeds as AverageSpeedsProvider,
        unitConverter as SettingsBoundUnitConverter,
        settings as SettingsController
    ) {
        View.initialize();

        self.activityInfo = activityInfo;
        self.averageSpeeds = averageSpeeds;

        self.arrows = new WaypointArrows(settings, waypoint, false);
        
        self.time = new Time(new TimeProvider(), [0, 0]);
        self.currentSpeed = new CurrentSpeed(unitConverter, [0, 0]);
        self.avgSpeeds = new AverageSpeeds(unitConverter, [0, 0]);
        self.avgSpeeds2 = new AverageSpeeds2(unitConverter, [0, 0]);

        self.quarterLayout = new QuarterLayout(
            self.currentSpeed,
            self.time,
            self.avgSpeeds2,
            self.avgSpeeds
        );

        self.timerSubscription = AppTimer.onUpdate();
    }

    function onLayout(dc as Dc) as Void {
        self.arrows.layout(dc);
        self.quarterLayout.layout(dc);
    }

    function forceUpdate() as Void {
        self.updateValues();

        WatchUi.requestUpdate();
    }

    function updateValues() as Void {
        self.arrows.update();
        self.currentSpeed.setValue(self.activityInfo.speed());
        self.avgSpeeds.setValue(self.averageSpeeds.value());
        self.avgSpeeds2.setAvgSpeeds(self.averageSpeeds.value());
    }

    function onUpdate(dc as Dc) as Void {
        dc.setColor(Utils.Colors.background, Utils.Colors.background);
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
