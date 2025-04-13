
import Toybox.Test;
import Toybox.Lang;

module WayfinderTests {
    class UnitConverterTest { 
        (:test)
        function testSpeedFromMStoMS(logger as Logger) as Boolean {
            var converter = new UnitConverter(new FakeSettingsController(SettingsController.UNITS_DISTANCE_DONOTUSE_UPPER_LIMIT, SettingsController.UNITS_SPEED_MS));

            Assert.isEqual(null, converter.speedFromMS(null));
            Assert.isEqual(0.0, converter.speedFromMS(0.0));
            Assert.isEqual(100.0, converter.speedFromMS(100.0));
            
            return true;
        }

        (:test)
        function testSpeedFromMStoKMH(logger as Logger) as Boolean {
            var converter = new UnitConverter(new FakeSettingsController(SettingsController.UNITS_DISTANCE_DONOTUSE_UPPER_LIMIT, SettingsController.UNITS_SPEED_KMH));

            Assert.isEqual(null, converter.speedFromMS(null));
            Assert.isEqual(0.0, converter.speedFromMS(0.0));
            Assert.isEqual(360.0, converter.speedFromMS(100.0));
            
            return true;
        }

        (:test)
        function testSpeedFromMStoMPS(logger as Logger) as Boolean {
            var converter = new UnitConverter(new FakeSettingsController(SettingsController.UNITS_DISTANCE_DONOTUSE_UPPER_LIMIT, SettingsController.UNITS_SPEED_MPH));

            Assert.isEqual(null, converter.speedFromMS(null));
            Assert.isEqual(0.0, converter.speedFromMS(0.0));
            Assert.isEqual(223.693634, converter.speedFromMS(100.0));
            
            return true;
        }

        (:test)
        function testSpeedFromMStoKnots(logger as Logger) as Boolean {
            var converter = new UnitConverter(new FakeSettingsController(SettingsController.UNITS_DISTANCE_DONOTUSE_UPPER_LIMIT, SettingsController.UNITS_SPEED_KNOTS));

            Assert.isEqual(null, converter.speedFromMS(null));
            Assert.isEqual(0.0, converter.speedFromMS(0.0));
            Assert.isEqual(194.384445, converter.speedFromMS(100.0));
            
            return true;
        }

        (:test)
        function testSpeedFromMStoUnknown(logger as Logger) as Boolean {
            var converter = new UnitConverter(new FakeSettingsController(SettingsController.UNITS_DISTANCE_DONOTUSE_UPPER_LIMIT, SettingsController.UNITS_SPEED_DONOTUSE_UPPER_LIMIT));

            Assert.isEqual(null, converter.speedFromMS(null));
            
            try {
                converter.speedFromMS(100.0);
            } catch(e) {
                Assert.exception(NotImplemented, e);

                return true;
            }

            Assert.exception(NotImplemented, null);
            
            return true;
        }

        (:test)
        function testDistanceFromMetersToKM(logger as Logger) as Boolean {
            var converter = new UnitConverter(new FakeSettingsController(SettingsController.UNITS_DISTANCE_METERS, SettingsController.UNITS_SPEED_KNOTS));

            Assert.isEqual(converter.distanceFromMeters(null), null);
            Assert.isEqual(converter.distanceFromMeters(0.0), 0.0);
            Assert.isEqual(converter.distanceFromMeters(100.0), 0.1);

            return true;
        }

        (:test)
        function testDistanceFromMetersToMiles(logger as Logger) as Boolean {
            var converter = new UnitConverter(new FakeSettingsController(SettingsController.UNITS_DISTANCE_MILES, SettingsController.UNITS_SPEED_KNOTS));

            Assert.isEqual(null, converter.distanceFromMeters(null));
            Assert.isEqual(0.0, converter.distanceFromMeters(0.0));
            Assert.isEqual(621.371216, converter.distanceFromMeters(1000000.0));

            return true;
        }

        (:test)
        function testDistanceFromMeterstoUnknown(logger as Logger) as Boolean {
            var converter = new UnitConverter(new FakeSettingsController(SettingsController.UNITS_DISTANCE_DONOTUSE_UPPER_LIMIT, SettingsController.UNITS_SPEED_DONOTUSE_UPPER_LIMIT));

            Assert.isEqual(null, converter.speedFromMS(null));
            
            try {
                converter.distanceFromMeters(100.0);
            } catch(e) {
                Assert.exception(NotImplemented, e);

                return true;
            }

            Assert.exception(NotImplemented, null);
            
            return true;
        }
    }
}
