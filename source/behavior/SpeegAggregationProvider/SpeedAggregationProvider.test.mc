import Toybox.Lang;
import Toybox.Test;

(:debug)
module WayfinderTests {
    class SpeedAggregationProviderTest {
        (:test)
        public function testItReturnsNullWhenNotStarted(logger as Logger) as Boolean {
            var aggregator = new SpeedAggregationProvider(new SensorProviderFake(), new NoopTimer());
            Assert.isNull(aggregator.value());

            return true;
        }

        (:test)
        public function testItReturnsZeroByDefault(logger as Logger) as Boolean {
            var aggregator = new SpeedAggregationProvider(new SensorProviderFake(), new NoopTimer());
            aggregator.start();

            var value = aggregator.value();
            Assert.isNotNull(value);
            Assert.isEqual(0.0, value.speed2s);
            Assert.isEqual(0.0, value.speed10s);
            Assert.isEqual(0.0, value.speed30m);
            Assert.isEqual(0.0, value.speed60m);

            return true;
        }

        (:test)
        public function testItMaxesOverTime(logger as Logger) as Boolean {
            var fakeSensor = new SensorProviderFake();
            var aggregator = new SpeedAggregationProvider(fakeSensor, new NoopTimer());
            aggregator.start();

            fakeSensor.setSpeed(110.0);
            SpeedAggregatorHelper.sampleTime(aggregator, 7200);

            fakeSensor.setSpeed(100.0);
            SpeedAggregatorHelper.sampleTime(aggregator, 1000);


            fakeSensor.setSpeed(95.0);
            SpeedAggregatorHelper.sampleTime(aggregator, 30);

            fakeSensor.setSpeed(90.0);
            SpeedAggregatorHelper.sampleTime(aggregator, 2);

            fakeSensor.setSpeed(80.0);
            SpeedAggregatorHelper.sampleTime(aggregator, 8);

            var value = aggregator.value();
            Assert.isNotNull(value);
            Assert.isEqual(80.0, value.speed2s);
            Assert.isEqual(82.0, value.speed10s);
            Assert.isEqual(104.038887, value.speed30m);
            Assert.isEqual(107.019447, value.speed60m);

            return true;
        }

        (:test)
        public function testItClearsOnReset(logger as Logger) as Boolean {
            var fakeSensor = new SensorProviderFake();
            var aggregator = new SpeedAggregationProvider(fakeSensor, new NoopTimer());
            aggregator.start();

            fakeSensor.setSpeed(100.0);
            SpeedAggregatorHelper.sampleTime(aggregator, 10);
            
            aggregator.reset();
            aggregator.start();

            var value = aggregator.value();
            Assert.isNotNull(value);
            Assert.isEqual(0.0, value.speed2s);
            Assert.isEqual(0.0, value.speed10s);
            Assert.isEqual(0.0, value.speed30m);
            Assert.isEqual(0.0, value.speed60m);

            return true;
        }

        (:test)
        public function testItReturnsNullOnPause(logger as Logger) as Boolean {
            var fakeSensor = new SensorProviderFake();
            var aggregator = new SpeedAggregationProvider(fakeSensor, new NoopTimer());
            aggregator.start();

            fakeSensor.setSpeed(100.0);
            SpeedAggregatorHelper.sampleTime(aggregator, 10);
            
            aggregator.pause();

            var value = aggregator.value();
            Assert.isNull(value);

            return true;
        }
    }
}