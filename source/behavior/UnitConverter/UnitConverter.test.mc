
import Toybox.Test;
import Toybox.Lang;

(:debug)
module WayfinderTests {
    class UnitConverterTest { 
        
        (:test)
        function testDistanceConversion(logger as Logger) as Boolean {
            var converter = new UnitConverter();

            Assert.isEqual(null, converter.distanceFromMeters(null, SettingsControllerInterface.DISTANCE_METERS));
            Assert.isEqual(0.0, converter.distanceFromMeters(0.0, SettingsControllerInterface.DISTANCE_METERS));
            Assert.isEqual(10.0, converter.distanceFromMeters(10000.0, SettingsControllerInterface.DISTANCE_METERS));
            Assert.isEqual(6.213712, converter.distanceFromMeters(10000.0, SettingsControllerInterface.DISTANCE_MILES));

            return true;
        }

        (:test)
        function testSpeedConversion(logger as Logger) as Boolean {
            var converter = new UnitConverter();

            Assert.isEqual(null, converter.speedFromMS(null, SettingsControllerInterface.SPEED_KNOTS));
            Assert.isEqual(0.0, converter.speedFromMS(0.0, SettingsControllerInterface.SPEED_KNOTS));
            Assert.isEqual(10.0, converter.speedFromMS(10.0, SettingsControllerInterface.SPEED_MS));
            Assert.isEqual(19.438444, converter.speedFromMS(10.0, SettingsControllerInterface.SPEED_KNOTS));
            Assert.isEqual(22.369364, converter.speedFromMS(10.0, SettingsControllerInterface.SPEED_MPH));
            Assert.isEqual(36.0, converter.speedFromMS(10.0, SettingsControllerInterface.SPEED_KMH));

            return true;
        }
    }
}
