import Toybox.Lang;
import Toybox.Test;

(:debug)
module WayfinderTests {
    class MaxAverageSpeedsProviderTest {
        (:test)
        public function testMaxAverageSpeedsProviderInitialState(logger as Logger) as Boolean {
            var averageSpeeds = new StubAverageSpeedsProvider();
            averageSpeeds.setValue(null);

            var maxAverageSpeedsProvider = new MaxAverageSpeedsProvider(averageSpeeds);

            var emptyMaxValues = MaxAverageSpeedValues.empty();

            var values = maxAverageSpeedsProvider.value();
            values.equals(emptyMaxValues);

            maxAverageSpeedsProvider.update();
            values = maxAverageSpeedsProvider.value();
            values.equals(emptyMaxValues);

            return true;
        }

        (:test)
        public function testSkipsIncompleteAverageValues(logger as Logger) as Boolean {
            var averageSpeeds = new StubAverageSpeedsProvider();
            var maxAverageSpeedsProvider = new MaxAverageSpeedsProvider(averageSpeeds);

            averageSpeeds.setValue(new AverageSpeedValues(
                new AverageValue(1.0, false), 
                new AverageValue(2.0, false),
                new AverageValue(3.0, false),
                new AverageValue(4.0, false)
            ));
            maxAverageSpeedsProvider.update();

            var values = maxAverageSpeedsProvider.value();
            values.equals(MaxAverageSpeedValues.empty());

            return true;
        }

        (:test)
        public function testMaximizingAverageValues(logger as Logger) as Boolean {
            var averageSpeeds = new StubAverageSpeedsProvider();
            var maxAverageSpeedsProvider = new MaxAverageSpeedsProvider(averageSpeeds);

            averageSpeeds.setValue(new AverageSpeedValues(
                new AverageValue(1.0, true), 
                new AverageValue(2.0, true),
                new AverageValue(3.0, true),
                new AverageValue(4.0, true)
            ));
            maxAverageSpeedsProvider.update();

            var values = maxAverageSpeedsProvider.value();
            values.equals(
                new MaxAverageSpeedValues(
                    1.0, 
                    2.0, 
                    3.0, 
                    4.0
                )
            );

            averageSpeeds.setValue(new AverageSpeedValues(
                new AverageValue(10.0, true), 
                new AverageValue(2.0, true),
                new AverageValue(3.0, true),
                new AverageValue(4.0, true)
            ));
            maxAverageSpeedsProvider.update();

            values = maxAverageSpeedsProvider.value();
            values.equals(
                new MaxAverageSpeedValues(
                    10.0, 
                    2.0, 
                    3.0, 
                    4.0
                )
            );

            averageSpeeds.setValue(new AverageSpeedValues(
                new AverageValue(1.0, true), 
                new AverageValue(20.0, true),
                new AverageValue(3.0, true),
                new AverageValue(4.0, true)
            ));
            maxAverageSpeedsProvider.update();

            values = maxAverageSpeedsProvider.value();
            values.equals(
                new MaxAverageSpeedValues(
                    10.0, 
                    20.0, 
                    3.0, 
                    4.0
                )
            );

            averageSpeeds.setValue(new AverageSpeedValues(
                new AverageValue(1.0, true), 
                new AverageValue(2.0, true),
                new AverageValue(30.0, true),
                new AverageValue(4.0, true)
            ));
            maxAverageSpeedsProvider.update();

            values = maxAverageSpeedsProvider.value();
            values.equals(
                new MaxAverageSpeedValues(
                    10.0, 
                    20.0, 
                    30.0, 
                    4.0
                )
            );

            averageSpeeds.setValue(new AverageSpeedValues(
                new AverageValue(1.0, true), 
                new AverageValue(2.0, true),
                new AverageValue(3.0, true),
                new AverageValue(40.0, true)
            ));
            maxAverageSpeedsProvider.update();

            values = maxAverageSpeedsProvider.value();
            values.equals(
                new MaxAverageSpeedValues(
                    10.0, 
                    20.0, 
                    30.0, 
                    40.0
                )
            );

            return true;
        }
    }
}