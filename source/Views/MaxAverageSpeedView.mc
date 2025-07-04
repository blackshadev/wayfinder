import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Position;
import Toybox.Lang;
import Toybox.System;
import Toybox.Timer;

class MaxAverageSpeedView extends WatchUi.View {
    private var activityInfo as ActivityInfoProvider;
    private var maxAvgSpeed as MaxAverageSpeedsProvider;
    private var waypoint as WaypointController;

    private var arrow as Arrow;
    private var time as Time;
    private var maxSpeed as MaxSpeed;
    private var maxSpeeds as MaxAverageSpeeds;
    private var maxSpeeds2 as MaxAverageSpeeds2;

    private var quarterLayout as QuarterLayout;
    
    private var timerSubscription as TimerSubscription;

    function initialize(
        waypoint as WaypointController,
        activityInfo as ActivityInfoProvider,
        maxAvgSpeed as MaxAverageSpeedsProvider,
        unitConverter as SettingsBoundUnitConverter
    ) {
        View.initialize();

        self.activityInfo = activityInfo;
        self.maxAvgSpeed = maxAvgSpeed;
        self.waypoint = waypoint;

        self.arrow = new Arrow(Utils.Sizing.arrow);
        
        self.time = new Time(new TimeProvider(), [0, 0]);
        self.maxSpeed = new MaxSpeed(unitConverter, [0, 0]);
        self.maxSpeeds = new MaxAverageSpeeds(unitConverter, [0, 0]);
        self.maxSpeeds2 = new MaxAverageSpeeds2(unitConverter, [0, 0]);

        self.quarterLayout = new QuarterLayout(
            self.maxSpeed,
            self.time,
            self.maxSpeeds2,
            self.maxSpeeds
        );

        self.timerSubscription = AppTimer.subscribeOnUpdate(method(:forceUpdate));
    }

    function onLayout(dc as Dc) as Void {
        self.arrow.layout(dc);
        self.quarterLayout.layout(dc);
    }

    function forceUpdate() as Void {
        self.updateValues();

        WatchUi.requestUpdate();
    }

    function updateValues() as Void {
        self.arrow.setAngle(self.waypoint.angle());
        self.maxSpeed.setValue(self.activityInfo.speed());
        self.maxSpeeds.setMaxAvgSpeeds(self.maxAvgSpeed.value());
        self.maxSpeeds2.setMaxAvgSpeeds(self.maxAvgSpeed.value());
    }

    function onUpdate(dc as Dc) as Void {
        dc.setColor(Utils.Colors.background, Utils.Colors.background);
        dc.clear();

        self.arrow.draw(dc);
        self.quarterLayout.draw(dc);
    }

    function onShow() as Void {
        self.updateValues();
        self.timerSubscription.start();
    }

    function onHide() as Void {
        self.timerSubscription.stop();
    }
}
