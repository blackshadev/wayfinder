import Toybox.Lang;
import Toybox.Test;

module WayfinderTests {
    (:debug)
    class MovingAverageTest {

        (:test)
        function testEmptyMovingAverage(logger as Logger) as Boolean {
            var avg = new MovingAverage(0);

            Assert.isEqual(0.0, avg.value());

            return true;
        }

        (:test)
        function testMovingAverageAverages(logger as Logger) as Boolean {
            var avg = new MovingAverage(6);
            avg.add(0.0, 0.0);
            avg.add(10.0, 0.0);

            Assert.isEqual(5.0, avg.value());

            avg.add(0.0, 0.0);
            avg.add(10.0, 0.0);

            Assert.isEqual(5.0, avg.value());


            avg.add(0.0, 0.0);
            avg.add(40.0, 0.0);

            Assert.isEqual(10.0, avg.value());

            return true;
        }

        (:test)
        function testMovingAverageOverLimit(logger as Logger) as Boolean {
        
            var avg = new MovingAverage(2);
            avg.add(8.0, 0.0);
            avg.add(8.0, 0.0);

            Assert.isEqual(8.0, avg.value());

            avg.add(10.0, 8.0);

            Assert.isEqual(9.0, avg.value());

            avg.add(0.0, 8.0);

            Assert.isEqual(5.0, avg.value());

            return true;
        }

        (:test)
        function testMovingAverageResets(logger as Logger) as Boolean {
            var avg = new MovingAverage(2);
            
            avg.add(8.0, 0.0);
            avg.add(8.0, 0.0);

            Assert.isEqual(8.0, avg.value());

            avg.reset();

            Assert.isEqual(0.0, avg.value());
            avg.add(10.0, 0.0);

            return true;
        }
    }
}