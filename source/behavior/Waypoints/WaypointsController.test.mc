
import Toybox.Test;
import Toybox.Lang;

(:debug)
module WayfinderTests {
    class WaypointsControllerTest {
        (:test)
        public function testWaypointsControllerShouldSaveWaypoints(logger as Logger) as Boolean {
            var storage = new WayfinderTests.MockWaypointStorage();
            var settings = new WayfinderTests.StubSettingsController();
            var controller = new WaypointsController(
                new WayfinderTests.StubLocationProvider(),
                new WayfinderTests.StubSensorProvider(),
                storage,
                settings,
                new SettingsBoundUnitConverter(settings)
            );

            var waypoints = [
                Waypoint.fromArray([37.7749, -122.4194]),
                Waypoint.fromArray([34.0522, -118.2437])
            ];

            controller.setWaypoints(waypoints);
            Assert.isEqual(2, controller.count());

            Assert.isTrue(storage.hasSavedWaypoints(waypoints));
            Assert.isEqual(waypoints[0], controller.currentWaypoint());

            return true;
        }

        (:test)
        public function testWaypointsControllerShouldShowWaypoint(logger as Logger) as Boolean {
            var settings = new WayfinderTests.StubSettingsController();

            var controller = new WaypointsController(
                new WayfinderTests.StubLocationProvider(),
                new WayfinderTests.StubSensorProvider(),
                new WayfinderTests.MockWaypointStorage(),
                settings,
                new SettingsBoundUnitConverter(settings)
            );

            settings.setReturnWaypointVisibility(SettingsControllerInterface.RETURN_WAYPOINT_NEVER);
            Assert.isFalse(controller.shouldShowReturnWaypoint());
            Assert.isFalse(controller.shouldShowCurrentWaypoint());

            settings.setReturnWaypointVisibility(SettingsControllerInterface.RETURN_WAYPOINT_ALWAYS);
            Assert.isTrue(controller.shouldShowReturnWaypoint());
            Assert.isFalse(controller.shouldShowCurrentWaypoint());

            settings.setReturnWaypointVisibility(SettingsControllerInterface.RETURN_WAYPOINT_AFTER_LAST);
            Assert.isFalse(controller.shouldShowCurrentWaypoint());
            Assert.isTrue(controller.shouldShowReturnWaypoint());

            controller.setWaypoints([Waypoint.fromArray([37.7749, -122.4194])]);
            Assert.isTrue(controller.shouldShowCurrentWaypoint());
            Assert.isFalse(controller.shouldShowReturnWaypoint());

            return true;
        }

        (:test)
        public function testWaypointsControllerShouldClearWaypoints(logger as Logger) as Boolean {
            var storage = new WayfinderTests.MockWaypointStorage();
            var settings = new WayfinderTests.StubSettingsController();

            var controller = new WaypointsController(
                new WayfinderTests.StubLocationProvider(),
                new WayfinderTests.StubSensorProvider(),
                storage,
                settings,
                new SettingsBoundUnitConverter(settings)
            );
            
            controller.setWaypoints([
                Waypoint.fromArray([37.7749, -122.4194]),
                Waypoint.fromArray([34.0522, -118.2437])
            ]);

            controller.clearWaypoints();

            Assert.isTrue(storage.isCleared());
            Assert.isNull(controller.currentWaypoint());
            Assert.isEqual(0, controller.count());

            return true;
        }

        (:test)
        public function testWaypointControllerAutosetAfterUpdateSetsReturnWaypoint(logger as Logger) as Boolean {
            var location = new WayfinderTests.StubLocationProvider();
            var sensor = new WayfinderTests.StubSensorProvider();
            var settings = new WayfinderTests.StubSettingsController();

            var controller = new WaypointsController(
                location,
                sensor,
                new WayfinderTests.MockWaypointStorage(),
                settings,
                new SettingsBoundUnitConverter(settings)
            );

            var position = new Position.Location({
                    :latitude => 52.52437,
                    :longitude => 13.41053,
                    :format => :degrees
                });
                
            location.setLastPosition(position);
            
            Assert.isFalse(controller.isSet());
            Assert.isFalse(controller.isSettable());
            controller.update();

            Assert.isNull(controller.returnWaypoint());
            controller.autoSet();

            Assert.isEqual(position, controller.returnWaypoint().location());
            Assert.isTrue(controller.isSet());
            Assert.isTrue(controller.isSettable());

            return true;
        }

        (:test)
        public function testWaypointControllerAutosetSetsReturnWaypointInUpdate(logger as Logger) as Boolean {
            var location = new WayfinderTests.StubLocationProvider();
            var sensor = new WayfinderTests.StubSensorProvider();
            var settings = new WayfinderTests.StubSettingsController();

            var controller = new WaypointsController(
                location,
                sensor,
                new WayfinderTests.MockWaypointStorage(),
                settings,
                new SettingsBoundUnitConverter(settings)
            );

            controller.autoSet();

            var position = new Position.Location({
                    :latitude => 52.52437,
                    :longitude => 13.41053,
                    :format => :degrees
                });
                
            location.setLastPosition(position);
            
            Assert.isFalse(controller.isSet());
            Assert.isNull(controller.returnWaypoint());
            Assert.isFalse(controller.isSettable());
            controller.update();

            Assert.isEqual(position, controller.returnWaypoint().location());
            Assert.isTrue(controller.isSet());
            Assert.isTrue(controller.isSettable());

            return true;
        }

        (:test)
        public function testWaypointsControllerUpdateWaypoints(logger as Logger) as Boolean {
            var location = new WayfinderTests.StubLocationProvider();
            var sensor = new WayfinderTests.StubSensorProvider();
            var settings = new WayfinderTests.StubSettingsController();

            var controller = new WaypointsController(
                location,
                sensor,
                new WayfinderTests.MockWaypointStorage(),
                settings,
                new SettingsBoundUnitConverter(settings)
            );

            var startPosition = new Position.Location({
                :latitude => 52.52437,
                :longitude => 13.41053,
                :format => :degrees
            });

            var northWaypoint = new Waypoint(startPosition.getProjectedLocation(0, 200));

            location.setLastPosition(startPosition);

            controller.setWaypoints([northWaypoint]);

            controller.update();

            Assert.isEqual(northWaypoint, controller.currentWaypoint());
            Assert.isEqual(0, northWaypoint.absoluteAngle());
            Assert.isEqual(0, northWaypoint.angle());

            sensor.setHeading(180);
            controller.update();

            Assert.isEqual(0, northWaypoint.absoluteAngle());
            Assert.isEqual(180, northWaypoint.angle());

            return true;
        }

        (:test)
        public function testWaypointsControllerSetsNextWaypoints(logger as Logger) as Boolean {
            var location = new WayfinderTests.StubLocationProvider();
            var sensor = new WayfinderTests.StubSensorProvider();
            var settings = new WayfinderTests.StubSettingsController();

            var controller = new WaypointsController(
                location,
                sensor,
                new WayfinderTests.MockWaypointStorage(),
                settings,
                new SettingsBoundUnitConverter(settings)
            );

            var startPosition = new Position.Location({
                :latitude => 52.52437,
                :longitude => 13.41053,
                :format => :degrees
            });

            settings.setDistanceToWaypoint(50);

            var northWaypoint = new Waypoint(startPosition.getProjectedLocation(0, 200));
            var southWaypoint = new Waypoint(startPosition.getProjectedLocation(Math.PI, 300));

            location.setLastPosition(startPosition);

            controller.setWaypoints([northWaypoint, southWaypoint]);

            controller.autoSet();
            controller.update();

            Assert.isEqual(northWaypoint, controller.currentWaypoint());
            
            location.setLastPosition(startPosition.getProjectedLocation(0, 151));
            controller.update();

            Assert.isEqual(southWaypoint, controller.currentWaypoint());

            location.setLastPosition(southWaypoint.location());
            controller.update();

            Assert.isEqual(startPosition, controller.returnWaypoint().location());

            return true;
        }
    }
}