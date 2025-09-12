
import Toybox.Test;
import Toybox.Lang;

(:debug)
module WayfinderTests {
    class UnitConverterTest { 
        
        (:test)
        function testDistanceConversion(logger as Logger) as Boolean {
            var converter = new UnitConverter();

            Assert.isEqual(null, converter.distanceFromMeters(null, SettingsControllerInterface.DISTANCE_METERS));
            Assert.isApproxEqual(0.0, converter.distanceFromMeters(0.0, SettingsControllerInterface.DISTANCE_METERS), 0.001);
            Assert.isApproxEqual(10.0, converter.distanceFromMeters(10000.0, SettingsControllerInterface.DISTANCE_METERS), 0.001);
            Assert.isApproxEqual(6.213712, converter.distanceFromMeters(10000.0, SettingsControllerInterface.DISTANCE_MILES), 0.001);

            return true;
        }
        
        (:test)
        function testSmallDistanceConversion(logger as Logger) as Boolean {
            var converter = new UnitConverter();

            Assert.isEqual(null, converter.smallDistanceFromMeters(null, SettingsControllerInterface.DISTANCE_METERS));
            Assert.isApproxEqual(0.0, converter.smallDistanceFromMeters(0.0, SettingsControllerInterface.DISTANCE_METERS), 0.001);
            Assert.isApproxEqual(10000.0, converter.smallDistanceFromMeters(10000.0, SettingsControllerInterface.DISTANCE_METERS), 0.001);
            Assert.isApproxEqual(9143.9999861, converter.smallDistanceFromMeters(10000.0, SettingsControllerInterface.DISTANCE_MILES), 0.001);

            return true;
        }

        (:test)
        function testSpeedConversion(logger as Logger) as Boolean {
            var converter = new UnitConverter();

            Assert.isEqual(null, converter.speedFromMS(null, SettingsControllerInterface.SPEED_KNOTS));
            Assert.isApproxEqual(0.0, converter.speedFromMS(0.0, SettingsControllerInterface.SPEED_KNOTS), 0.001);
            Assert.isApproxEqual(10.0, converter.speedFromMS(10.0, SettingsControllerInterface.SPEED_MS), 0.001);
            Assert.isApproxEqual(19.438444, converter.speedFromMS(10.0, SettingsControllerInterface.SPEED_KNOTS), 0.001);
            Assert.isApproxEqual(22.369364, converter.speedFromMS(10.0, SettingsControllerInterface.SPEED_MPH), 0.001);
            Assert.isApproxEqual(36.0, converter.speedFromMS(10.0, SettingsControllerInterface.SPEED_KMH), 0.001);

            return true;
        }
        
    }
}
