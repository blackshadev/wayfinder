import Toybox.WatchUi;
import Toybox.Position;
import Toybox.System;
import Toybox.Lang;
import Toybox.Timer;

class SpeedAggregationProvider {

    class AverageValueList {
        private var _averages as Array<MovingAverage> = [];
        private var _limitIndices as Array<Number> = [];

        function initialize(sizes as Array<Number>) {
            for (var iX = 0; iX < sizes.size(); iX++) {
                self._averages.add(new MovingAverage(sizes[iX]));
                self._limitIndices.add(sizes[iX] - 1);
            }
        }

        public function add(value as Float, oldValues as Array<Float>) as Void {
            for (var iX = 0; iX < self._averages.size(); iX++) {
                self._averages[iX].add(value, oldValues[iX]);
            }
        }

        public function values() as Array<Float> {
            var values = [] as Array<Float>;
            for (var iX = 0; iX < self._averages.size(); iX++) {
                values.add(self._averages[iX].value());
            }

            return values;
        }

        public function reset() as Void {
            for (var iX = 0; iX < self._averages.size(); iX++) {
                self._averages[iX].reset();
            }
        }

        public function limitIndices() as Array<Number> {
            return self._limitIndices;
        }
    }

    private const SAMPLE_TIME = 500;

    private const SEC_2 = 2000;
    private const SEC_10 = 10000;
    private const MIN_30 = 1800000;
    private const MIN_60 = 3600000;
    private const MAX_TIME = MIN_60;

    private const SIZE_2_SEC = SEC_2 / SAMPLE_TIME;
    private const SIZE_10_SEC = SEC_10 / SAMPLE_TIME;
    private const SIZE_30_MIN = MIN_30 / SAMPLE_TIME;
    private const SIZE_60_MIN = MIN_60 / SAMPLE_TIME;
    private const SIZE_MAX = SIZE_60_MIN;

    private var rawSpeedData as FloatRingBuffer;
    private var updateTimer as Timer.Timer;
    private var sensor as SensorProviderInterface;

    private var speeds as AverageValueList;

    private var isStarted as Boolean = false;

    function initialize(sensor as SensorProviderInterface, timer as Timer.Timer) {
        self.sensor = sensor;
        self.updateTimer = timer;

        self.rawSpeedData = new FloatRingBuffer(SIZE_MAX, 0.0);
        self.speeds = new AverageValueList([
            SIZE_2_SEC,
            SIZE_10_SEC,
            SIZE_30_MIN,
            SIZE_60_MIN,
        ]);
    }

    public function start() as Void {
        self.updateTimer.start(method(:sample), SAMPLE_TIME, true);
        self.isStarted = true;
    }

    public function reset() as Void {
        self.pause();
        self.speeds.reset();
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

