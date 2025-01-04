import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Position;
import Toybox.Lang;
import Toybox.System;
import Toybox.Timer;

class SpeedView extends WatchUi.View {
    private var activityInfo as ActivityInfoProvider;
    private var speedAggregator as SpeedAggregationProvider;
    private var waypoint as WaypointController;

    private var arrow as Arrow;
    private var time as Time;
    private var speed as Speed;
    private var averageSpeed as AverageSpeed;
    private var maxSpeeds as MaxSpeeds;

    private var quarterLayout as QuarterLayout;
    
    private var updateTimer as Timer.Timer;

    function initialize(
        waypoint as WaypointController,
        activityInfo as ActivityInfoProvider,
        speedAggregator as SpeedAggregationProvider
    ) {
        View.initialize();

        self.activityInfo = activityInfo;
        self.speedAggregator = speedAggregator;
        self.waypoint = waypoint;

        self.arrow = new Arrow(Utils.Sizing.arrow);
        
        self.time = new Time(new TimeProvider(), [0, 0]);
        self.averageSpeed = new AverageSpeed([0, 0]);
        self.speed = new Speed([0, 0]);
        self.maxSpeeds = new MaxSpeeds([0, 0]);

        self.quarterLayout = new QuarterLayout(
            self.averageSpeed,
            self.time,
            self.maxSpeeds,
            self.speed
        );

        self.updateTimer = new Timer.Timer();
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
        self.averageSpeed.setValue(self.activityInfo.speed());
        self.speed.setValue(self.activityInfo.speed());
        self.maxSpeeds.setValue(self.speedAggregator.value());

    }

    function onUpdate(dc as Dc) as Void {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
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
