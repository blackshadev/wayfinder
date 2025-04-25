import Toybox.WatchUi;
import Toybox.Position;
import Toybox.System;
import Toybox.Lang;
import Toybox.Timer;

class SpeedAggregationProvider {
    private const SAMPLE_TIME = 500;
    private const MAX_TIME = 10000;
    private const SEC_2 = 2000;
    private const SEC_10 = 10000;

    private const SIZE_MAX = MAX_TIME / SAMPLE_TIME;
    private const SIZE_2_SEC = SEC_2 / SAMPLE_TIME;
    private const SIZE_10_SEC = SEC_10 / SAMPLE_TIME;

    private var rawSpeedData as Array<Float>;
    private var updateTimer as Timer.Timer;
    private var sensor as SensorProvider or FakeSensorProvider;

    private var speeds as Array<Float> = [0.0, 0.0];

    private var isStarted as Boolean = false;

    function initialize(sensor as SensorProvider or FakeSensorProvider, timer as Timer.Timer) {
        self.sensor = sensor;
        self.rawSpeedData = [];
        self.updateTimer = timer;
    }

    public function start() as Void {
        self.updateTimer.start(method(:sample), SAMPLE_TIME, true);
        self.isStarted = true;
    }

    public function reset() as Void {
        self.pause();
        self.speeds = [0.0, 0.0];
        self.rawSpeedData = [];
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

        var sampleSize = self.rawSpeedData.size();
        var iX = 0;
        var iMin = 0;
        var iOld = 0;
        var maxSpeed = 0.0;


        iMin = Utils.max(self.rawSpeedData.size() - SIZE_2_SEC + 1, 0);
        iOld = Utils.max(iMin - 1, 0);
        if (sampleSize > SIZE_2_SEC && self.speeds[0] >= self.rawSpeedData[iOld]) {
            maxSpeed = 0.0;
            for (iX = self.rawSpeedData.size() - 1; iX >= iMin; iX--) {
                maxSpeed = Utils.max(maxSpeed, self.rawSpeedData[iX]);
            }
            self.speeds[0] = maxSpeed;
        }

        iMin = Utils.max(self.rawSpeedData.size() - SIZE_10_SEC + 1, 0);
        if (sampleSize > SIZE_10_SEC && self.speeds[1] >= self.rawSpeedData[iOld]) {
            maxSpeed = 0.0;
            
            for (iX = self.rawSpeedData.size() - 1; iX >= iMin; iX--) {
                maxSpeed = Utils.max(maxSpeed, self.rawSpeedData[iX]);
            }
            self.speeds[1] = maxSpeed;
        }

        if (self.rawSpeedData.size() > SIZE_MAX) {
            self.rawSpeedData = self.rawSpeedData.slice(1, SIZE_MAX - 1);
        }
    }

    public function value() as MaxSpeedValues? {
        if (!self.isStarted) {
            return null;
        }

        return new MaxSpeedValues(
            self.speeds[0],
            self.speeds[1]
        );
    }
}

