import Toybox.WatchUi;
import Toybox.Position;
import Toybox.System;
import Toybox.Lang;
import Toybox.Timer;

class AverageSpeedsProvider extends AverageSpeedsProviderInterface {
    private const SEC_2 = 2000;
    private const SEC_10 = 10000;
    private const MIN_30 = 1800000;
    private const MIN_60 = 3600000;
    private const MAX_TIME = MIN_60;

    private var rawSpeedData as FloatRingBuffer;
    private var updateTimer as TimerSubscription;
    private var sensor as SensorProviderInterface;

    private var speeds as AverageValueList;

    private var isStarted as Boolean = false;

    function initialize(sensor as SensorProviderInterface, timer as Timer.Timer) {
        AverageSpeedsProviderInterface.initialize();
        
        self.sensor = sensor;
        self.updateTimer = getApp().sampleTimer.subscribeOnSample(method(:sample));

        var sampleTime = getApp().sampleTimer.time;
        self.speeds = new AverageValueList([
            SEC_2 / sampleTime,
            SEC_10 / sampleTime,
            MIN_30 / sampleTime,
            MIN_60 / sampleTime
        ]);

        self.rawSpeedData = new FloatRingBuffer(MAX_TIME / sampleTime);
    }

    public function start() as Void {
        self.updateTimer.start();
        self.isStarted = true;
    }

    public function reset() as Void {
        self.pause();
        self.speeds.reset();
        self.rawSpeedData.reset();
    }

    public function pause() as Void {
        self.updateTimer.stop();
        self.isStarted = false;
    }

    public function sample() as Void {
        var speed = self.sensor.speed();
        if (speed == null) {
            return;
        }

        var oldValues = self.rawSpeedData.values(
            self.speeds.limitIndices()
        );

        self.rawSpeedData.add(speed);
        self.speeds.add(speed, oldValues);
    }

    public function value() as AverageSpeedValues? {
        if (!self.isStarted) {
            return null;
        }

        var values = self.speeds.values();
        
        return new AverageSpeedValues(
            values[0],
            values[1],
            values[2],
            values[3]
        );
    }
}

