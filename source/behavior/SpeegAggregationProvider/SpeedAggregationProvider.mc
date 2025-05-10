import Toybox.WatchUi;
import Toybox.Position;
import Toybox.System;
import Toybox.Lang;
import Toybox.Timer;

class SpeedAggregationProvider {
    private const SAMPLE_TIME = 500;

    private const SEC_2 = 2000;
    private const SEC_10 = 10000;
    private const SEC_30 = 30000;
    private const MAX_TIME = SEC_30;

    private const SIZE_2_SEC = SEC_2 / SAMPLE_TIME;
    private const SIZE_10_SEC = SEC_10 / SAMPLE_TIME;
    private const SIZE_30_SEC = SEC_30 / SAMPLE_TIME;
    private const SIZE_MAX = SIZE_30_SEC;

    private var rawSpeedData as FloatRingBuffer;
    private var updateTimer as Timer.Timer;
    private var sensor as SensorProviderInterface;

    private var speeds as Array<Float> = [0.0, 0.0, 0.0];

    private var isStarted as Boolean = false;

    function initialize(sensor as SensorProviderInterface, timer as Timer.Timer) {
        self.sensor = sensor;

        self.rawSpeedData = new FloatRingBuffer(SIZE_MAX, 0.0);
        self.updateTimer = timer;
    }

    public function start() as Void {
        self.updateTimer.start(method(:sample), SAMPLE_TIME, true);
        self.isStarted = true;
    }

    public function reset() as Void {
        self.pause();
        self.speeds = [0.0, 0.0, 0.0];
        self.rawSpeedData = new FloatRingBuffer(SIZE_MAX, 0.0);
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

        self.rawSpeedData.add(speed);

        if (speed > self.speeds[0]) {
            self.speeds[0] = speed;
        }

        if (speed > self.speeds[1]) {
            self.speeds[1] = speed;
        }

        if (speed > self.speeds[2]) {
            self.speeds[2] = speed;
        }

        self.speeds[0] = self.rawSpeedData.max(SIZE_2_SEC);
        self.speeds[1] = self.rawSpeedData.max(SIZE_10_SEC);
        self.speeds[2] = self.rawSpeedData.max(SIZE_30_SEC);
    }

    public function value() as MaxSpeedValues? {
        if (!self.isStarted) {
            return null;
        }

        return new MaxSpeedValues(
            self.speeds[0],
            self.speeds[1],
            self.speeds[2]
        );
    }
}

