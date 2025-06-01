import Toybox.Lang;
import Toybox.Test;

module WayfinderTests {
    (:debug)
    class MovingAverageTest {
        (:test)
        function testEmptyMovingAverage(logger as Logger) as Boolean {
            var avg = new MovingAverage(1);

            Assert.isEqual(0.0, avg.value().value);
            Assert.isEqual(false, avg.value().isComplete);

            return true;
        }

        (:test)
        function testMovingAverageAverages(logger as Logger) as Boolean {
            var avg = new MovingAverage(6);
            avg.add(0.0, 0.0);
            avg.add(10.0, 0.0);

            var value = avg.value();
            Assert.isEqual(5.0, value.value);
            Assert.isEqual(false, value.isComplete);

            avg.add(0.0, 0.0);
            avg.add(10.0, 0.0);

            value = avg.value();
            Assert.isEqual(5.0, value.value);
            Assert.isEqual(false, value.isComplete);

            avg.add(0.0, 0.0);
            avg.add(40.0, 0.0);

            value = avg.value();
            Assert.isEqual(10.0, value.value);
            Assert.isEqual(true, value.isComplete);

            return true;
        }

        (:test)
        function testMovingAverageOverLimit(logger as Logger) as Boolean {
        
            var avg = new MovingAverage(2);
            avg.add(8.0, 0.0);
            avg.add(8.0, 0.0);

            var value = avg.value();
            Assert.isEqual(8.0, value.value);
            Assert.isEqual(true, value.isComplete);

            avg.add(10.0, 8.0);

            value = avg.value();
            Assert.isEqual(9.0, value.value);
            Assert.isEqual(true, value.isComplete);

            avg.add(0.0, 8.0);

            value = avg.value();
            Assert.isEqual(5.0, value.value);
            Assert.isEqual(true, value.isComplete);

            return true;
        }

        (:test)
        function testMovingAverageResets(logger as Logger) as Boolean {
            var avg = new MovingAverage(2);
            
            avg.add(8.0, 0.0);
            avg.add(8.0, 0.0);

            var value = avg.value();
            Assert.isEqual(8.0, value.value);
            Assert.isEqual(true, value.isComplete);

            avg.reset();

            value = avg.value();
            Assert.isEqual(0.0, value.value);
            Assert.isEqual(false, value.isComplete);
            
            return true;
        }
    }
}