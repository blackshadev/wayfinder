import Toybox.Lang;
import Toybox.Test;

(:debug)
module WayfinderTests {
    class AverageSpeedsProviderTest {
        (:test)
        public function testItReturnsNullWhenNotStarted(logger as Logger) as Boolean {
            var aggregator = new AverageSpeedsProvider(new WayfinderTests.StubSensorProvider(), new WayfinderTests.StubTimer());
            Assert.isNull(aggregator.value());

            return true;
        }

        (:test)
        public function testItReturnsZeroByDefault(logger as Logger) as Boolean {
            var aggregator = new AverageSpeedsProvider(new WayfinderTests.StubSensorProvider(), new WayfinderTests.StubTimer());
            aggregator.start();

            var value = aggregator.value();
            Assert.isNotNull(value);
            Assert.isEqual(0.0, value.speed2s.value);
            Assert.isEqual(false, value.speed2s.isComplete);
            Assert.isEqual(0.0, value.speed10s.value);
            Assert.isEqual(false, value.speed10s.isComplete);
            Assert.isEqual(0.0, value.speed30m.value);
            Assert.isEqual(false, value.speed30m.isComplete);
            Assert.isEqual(0.0, value.speed60m.value);
            Assert.isEqual(false, value.speed60m.isComplete);

            return true;
        }

        (:test)
        public function testItMaxesOverTime(logger as Logger) as Boolean {
            var stubSensor = new WayfinderTests.StubSensorProvider();
            var aggregator = new AverageSpeedsProvider(stubSensor, new WayfinderTests.StubTimer());
            aggregator.start();

            stubSensor.setSpeed(110.0);
            SpeedAggregatorHelper.sampleTime(aggregator, 7200);

            stubSensor.setSpeed(100.0);
            SpeedAggregatorHelper.sampleTime(aggregator, 1000);


            stubSensor.setSpeed(95.0);
            SpeedAggregatorHelper.sampleTime(aggregator, 30);

            stubSensor.setSpeed(90.0);
            SpeedAggregatorHelper.sampleTime(aggregator, 2);

            stubSensor.setSpeed(80.0);
            SpeedAggregatorHelper.sampleTime(aggregator, 8);

            var value = aggregator.value();
            Assert.isNotNull(value);
            Assert.isEqual(80.0, value.speed2s.value);
            Assert.isEqual(true, value.speed2s.isComplete);
            Assert.isEqual(82.0, value.speed10s.value);
            Assert.isEqual(true, value.speed10s.isComplete);
            Assert.isEqual(104.038887, value.speed30m.value);
            Assert.isEqual(true, value.speed30m.isComplete);
            Assert.isEqual(107.019447, value.speed60m.value);
            Assert.isEqual(true, value.speed60m.isComplete);

            return true;
        }

        (:test)
        public function testItClearsOnReset(logger as Logger) as Boolean {
            var fakeSensor = new WayfinderTests.StubSensorProvider();
            var aggregator = new AverageSpeedsProvider(fakeSensor, new WayfinderTests.StubTimer());
            aggregator.start();

            fakeSensor.setSpeed(100.0);
            SpeedAggregatorHelper.sampleTime(aggregator, 10);
            
            aggregator.reset();
            aggregator.start();

            var value = aggregator.value();
            Assert.isNotNull(value);
            Assert.isEqual(0.0, value.speed2s.value);
            Assert.isEqual(false, value.speed2s.isComplete);
            Assert.isEqual(0.0, value.speed10s.value);
            Assert.isEqual(false, value.speed10s.isComplete);
            Assert.isEqual(0.0, value.speed30m.value);
            Assert.isEqual(false, value.speed30m.isComplete);
            Assert.isEqual(0.0, value.speed60m.value);
            Assert.isEqual(false, value.speed60m.isComplete);

            return true;
        }

        (:test)
        public function testItReturnsNullOnPause(logger as Logger) as Boolean {
            var fakeSensor = new WayfinderTests.StubSensorProvider();
            var aggregator = new AverageSpeedsProvider(fakeSensor, new WayfinderTests.StubTimer());
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