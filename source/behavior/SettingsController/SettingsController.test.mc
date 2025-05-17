import Toybox.Lang;
import Toybox.Test;
import Toybox.System;

(:debug)
module WayfinderTests {
    class SettingsControllerTest {
        (:test)
        public function testInitializationDefaults(logger as Logger) as Boolean {
            Application.Properties.setValue("arrowSize", SettingsControllerInterface.ARROW_SIZE_NORMAL);
            Application.Properties.setValue("unitsSpeed", SettingsControllerInterface.SPEED_UNSET);
            Application.Properties.setValue("unitsDistance", SettingsControllerInterface.DISTANCE_UNSET);

            var settings = new SettingsController();

            Assert.isEqual(SettingsControllerInterface.DISTANCE_MILES, settings.distance());
            Assert.isEqual(SettingsControllerInterface.SPEED_MPH, settings.unitsSpeed());
            Assert.isEqual(SettingsControllerInterface.ARROW_SIZE_NORMAL, settings.arrowSize());

            return true;
        }

        (:test)
        public function testInitializationUsingProperties(logger as Logger) as Boolean {
            Application.Properties.setValue("unitsSpeed", SettingsControllerInterface.SPEED_KNOTS);
            Application.Properties.setValue("unitsDistance", SettingsControllerInterface.DISTANCE_METERS);
            Application.Properties.setValue("background", SettingsControllerInterface.BACKGROUND_BLACK);
            Application.Properties.setValue("activityType", SettingsControllerInterface.ACTIVITY_KITESURFING);
            Application.Properties.setValue("mapZoomDistance", 5000);
            Application.Properties.setValue("arrowSize", SettingsControllerInterface.ARROW_SIZE_SMALL);

            var settings = new SettingsController();

            Assert.isEqual(SettingsControllerInterface.DISTANCE_METERS, settings.distance());
            Assert.isEqual(SettingsControllerInterface.SPEED_KNOTS, settings.unitsSpeed());
            Assert.isEqual(SettingsControllerInterface.BACKGROUND_BLACK, settings.background());
            Assert.isEqual(SettingsControllerInterface.ACTIVITY_KITESURFING, settings.activityType());
            Assert.isEqual(SettingsControllerInterface.ARROW_SIZE_SMALL, settings.arrowSize());
            Assert.isEqual(5000, settings.mapZoomDistance());

            return true;
        }

        (:test)
        public function testToggleUnitSpeed(logger as Logger) as Boolean {
            Application.Properties.setValue("unitsSpeed", SettingsControllerInterface.SPEED_MPH);
            var settings = new SettingsController();

            var expected = [
                { :value => SettingsControllerInterface.SPEED_MPH, :res => Rez.Strings.settingsUnitsSpeedmph },
                { :value => SettingsControllerInterface.SPEED_KNOTS, :res => Rez.Strings.settingsUnitsSpeedknots },
                { :value => SettingsControllerInterface.SPEED_KMH, :res => Rez.Strings.settingsUnitsSpeedkms },
                { :value => SettingsControllerInterface.SPEED_MS, :res => Rez.Strings.settingsUnitsSpeedms },
                { :value => SettingsControllerInterface.SPEED_MPH, :res => Rez.Strings.settingsUnitsSpeedmph },
            ];

            for (var iX = 0; iX < expected.size(); iX++) {
                Assert.isEqual(expected[iX][:value], settings.unitsSpeed());
                Assert.isEqual(expected[iX][:res], settings.unitsSpeedRes());

                settings.toggleUnitsSpeed();
            }

            return true;
        }

        (:test)
        public function testToggleDistance(logger as Logger) as Boolean {
            Application.Properties.setValue("unitsDistance", SettingsControllerInterface.DISTANCE_MILES);
            var settings = new SettingsController();

            var expected = [
                { :value => SettingsControllerInterface.DISTANCE_MILES, :res => Rez.Strings.settingsUnitsDistanceMiles },
                { :value => SettingsControllerInterface.DISTANCE_METERS, :res => Rez.Strings.settingsUnitsDistanceMeters },
                { :value => SettingsControllerInterface.DISTANCE_MILES, :res => Rez.Strings.settingsUnitsDistanceMiles }
            ];

            for (var iX = 0; iX < expected.size(); iX++) {
                Assert.isEqual(expected[iX][:value], settings.distance());
                Assert.isEqual(expected[iX][:res], settings.unitsDistanceRes());

                settings.toggleUnitsDistance();
            }

            return true;
        }

        (:test)
        public function testToggleMapZoom(logger as Logger) as Boolean {
            Application.Properties.setValue("mapZoomDistance", 2000);
            var settings = new SettingsController();

            var expected = [
                { :value => 2000, :res => Rez.Strings.settings2km },
                { :value => 5000, :res => Rez.Strings.settings5km },
                { :value => 1000, :res => Rez.Strings.settings1000m },
                { :value => 1500, :res => Rez.Strings.settings1500m },
                { :value => 2000, :res => Rez.Strings.settings2km },
            ];

            for (var iX = 0; iX < expected.size(); iX++) {
                Assert.isEqual(expected[iX][:value], settings.mapZoomDistance());
                Assert.isEqual(expected[iX][:res], settings.mapZoomDistanceRes());

                settings.toggleMapZoomDistance();
            }

            return true;
        }

        (:test)
        public function testToggleBackground(logger as Logger) as Boolean {
            Application.Properties.setValue("background", SettingsControllerInterface.BACKGROUND_BLACK);
            var settings = new SettingsController();

            var expected = [
                { :value => SettingsControllerInterface.BACKGROUND_BLACK, :res => Rez.Strings.settingsBackgroundBlack, :bg => Graphics.COLOR_BLACK, :fg => Graphics.COLOR_WHITE },
                { :value => SettingsControllerInterface.BACKGROUND_WHITE, :res => Rez.Strings.settingsBackgroundWhite, :bg => Graphics.COLOR_WHITE, :fg => Graphics.COLOR_BLACK },
                { :value => SettingsControllerInterface.BACKGROUND_BLACK, :res => Rez.Strings.settingsBackgroundBlack, :bg => Graphics.COLOR_BLACK, :fg => Graphics.COLOR_WHITE },
            ];

            for (var iX = 0; iX < expected.size(); iX++) {
                Assert.isEqual(expected[iX][:value], settings.background());
                Assert.isEqual(expected[iX][:res], settings.backgroundRes());
                Assert.isEqual(expected[iX][:bg], Utils.Colors.background);
                Assert.isEqual(expected[iX][:fg], Utils.Colors.foreground);

                settings.toggleBackground();
            }

            return true;
        }

        (:test)
        public function testToggleActivityType(logger as Logger) as Boolean {
            Application.Properties.setValue("activityType", SettingsController.ACTIVITY_WINDSURFING);
            var settings = new SettingsController();

            var expected = [
                { :value => SettingsController.ACTIVITY_WINDSURFING, :res => Rez.Strings.settingsActivityTypeWindsurfing },
                { :value => SettingsController.ACTIVITY_KITESURFING, :res => Rez.Strings.settingsActivityTypeKitesurfing },
                { :value => SettingsController.ACTIVITY_SURFING, :res => Rez.Strings.settingsActivityTypeSurfing },
                { :value => SettingsController.ACTIVITY_OPENWATER_SWIMMING, :res => Rez.Strings.settingsActivityTypeOpenwaterSwimming },
                { :value => SettingsController.ACTIVITY_OTHER, :res => Rez.Strings.settingsActivityTypeOther },
                { :value => SettingsController.ACTIVITY_WINDSURFING, :res => Rez.Strings.settingsActivityTypeWindsurfing },
            ];

            for (var iX = 0; iX < expected.size(); iX++) {
                Assert.isEqual(expected[iX][:value], settings.activityType());
                Assert.isEqual(expected[iX][:res], settings.activityTypeRes());

                settings.toggleActivityType();
            }

            return true;
        }

        (:test)
        public function testToggleArrowSize(logger as Logger) as Boolean {
            Application.Properties.setValue("arrowSize", SettingsControllerInterface.ARROW_SIZE_LARGE);
            var settings = new SettingsController();

            var expected = [
                { :value => SettingsControllerInterface.ARROW_SIZE_LARGE, :res => Rez.Strings.settingsArrowSizeLarge },
                { :value => SettingsControllerInterface.ARROW_SIZE_EXTRA_LARGE, :res => Rez.Strings.settingsArrowSizeExtraLarge },
                { :value => SettingsControllerInterface.ARROW_SIZE_NONE, :res => Rez.Strings.settingsArrowSizeNone },
                { :value => SettingsControllerInterface.ARROW_SIZE_SMALL, :res => Rez.Strings.settingsArrowSizeSmall },
                { :value => SettingsControllerInterface.ARROW_SIZE_NORMAL, :res => Rez.Strings.settingsArrowSizeNormal },
                { :value => SettingsControllerInterface.ARROW_SIZE_LARGE, :res => Rez.Strings.settingsArrowSizeLarge },
                { :value => SettingsControllerInterface.ARROW_SIZE_EXTRA_LARGE, :res => Rez.Strings.settingsArrowSizeExtraLarge },
            ];

            for (var iX = 0; iX < expected.size(); iX++) {
                Assert.isEqual(expected[iX][:value], settings.arrowSize());
                Assert.isEqual(expected[iX][:res], settings.arrowSizeRes());

                settings.toggleArrowSize();
            }

            return true;
        }
    }
}