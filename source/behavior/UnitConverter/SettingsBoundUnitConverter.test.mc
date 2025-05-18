
import Toybox.Test;
import Toybox.Lang;

(:debug)
module WayfinderTests {
    class SettingsBoundUnitConverterTest { 
        (:test)
        function testSettingsSpeedFromMStoMS(logger as Logger) as Boolean {
            var converter = new SettingsBoundUnitConverter(new SettingsControllerFake(SettingsControllerInterface.DISTANCE_METERS, SettingsControllerInterface.SPEED_MS));

            Assert.isEqual(null, converter.speedFromMS(null));
            Assert.isEqual(0.0, converter.speedFromMS(0.0));
            Assert.isEqual(100.0, converter.speedFromMS(100.0));
            
            return true;
        }

        (:test)
        function testSettingsSpeedFromMStoKMH(logger as Logger) as Boolean {
            var converter = new SettingsBoundUnitConverter(new SettingsControllerFake(SettingsControllerInterface.DISTANCE_METERS, SettingsControllerInterface.SPEED_KMH));

            Assert.isEqual(null, converter.speedFromMS(null));
            Assert.isEqual(0.0, converter.speedFromMS(0.0));
            Assert.isEqual(360.0, converter.speedFromMS(100.0));
            
            return true;
        }

        (:test)
        function testSettingsSpeedFromMStoMPS(logger as Logger) as Boolean {
            var converter = new SettingsBoundUnitConverter(new SettingsControllerFake(SettingsControllerInterface.DISTANCE_METERS, SettingsControllerInterface.SPEED_MPH));

            Assert.isEqual(null, converter.speedFromMS(null));
            Assert.isEqual(0.0, converter.speedFromMS(0.0));
            Assert.isEqual(223.693634, converter.speedFromMS(100.0));
            
            return true;
        }

        (:test)
        function testSettingsSpeedFromMStoKnots(logger as Logger) as Boolean {
            var converter = new SettingsBoundUnitConverter(new SettingsControllerFake(SettingsControllerInterface.DISTANCE_METERS, SettingsControllerInterface.SPEED_KNOTS));

            Assert.isEqual(null, converter.speedFromMS(null));
            Assert.isEqual(0.0, converter.speedFromMS(0.0));
            Assert.isEqual(194.384445, converter.speedFromMS(100.0));
            
            return true;
        }

        (:test)
        function testSettingsDistanceFromMetersToKM(logger as Logger) as Boolean {
            var converter = new SettingsBoundUnitConverter(new SettingsControllerFake(SettingsControllerInterface.DISTANCE_METERS, SettingsControllerInterface.SPEED_KNOTS));

            Assert.isEqual(converter.distanceFromMeters(null), null);
            Assert.isEqual(converter.distanceFromMeters(0.0), 0.0);
            Assert.isEqual(converter.distanceFromMeters(100.0), 0.1);

            return true;
        }

        (:test)
        function testSettingsDistanceFromMetersToMiles(logger as Logger) as Boolean {
            var converter = new SettingsBoundUnitConverter(new SettingsControllerFake(SettingsControllerInterface.DISTANCE_MILES, SettingsControllerInterface.SPEED_KNOTS));

            Assert.isEqual(null, converter.distanceFromMeters(null));
            Assert.isEqual(0.0, converter.distanceFromMeters(0.0));
            Assert.isEqual(621.371216, converter.distanceFromMeters(1000000.0));

            return true;
        }
    }
}
