import Toybox.Lang;
import Toybox.Test;
import Toybox.Application;
import Toybox.Time;


(:debug)
module WayfinderTests {
    class WindDirectionControllerTest {
        (:test)
        public function testInitialValueSetFromStorage(logger as Logger) as Boolean {
            var sensor = new WayfinderTests.StubSensorProvider();
            var weather = new WayfinderTests.StubWeatherProvider();
            
            Application.Properties.setValue("windDirection", 123);
            Application.Properties.setValue("windDirectionSetAt", Time.now().value());

            var controller = new WindDirectionController(sensor, weather);

            Assert.isTrue(controller.shouldShow());
            Assert.isEqual(123, controller.getWindDirection());

            return true;
        }

        (:test)
        public function testSetForecastWindDirection(logger as Logger) as Boolean {
            var sensor = new WayfinderTests.StubSensorProvider();
            var weather = new WayfinderTests.StubWeatherProvider();
            weather.setWindDirection(222);

            var controller = new WindDirectionController(sensor, weather);
            var now = Time.now().value();
            controller.setForecastWindDirection();

            Assert.isEqual(222, controller.getWindDirection());
            Assert.isTrue(controller.shouldShow());
            Assert.isEqual(Application.Properties.getValue("windDirection"), 222);
            Assert.isEqual(Application.Properties.getValue("windDirectionSetAt"), now);

            return true;
        }

        (:test)
        public function testSetWindDirection(logger as Logger) as Boolean {
            var sensor = new WayfinderTests.StubSensorProvider();
            var weather = new WayfinderTests.StubWeatherProvider();

            var controller = new WindDirectionController(sensor, weather);
            controller.setWindDirection(45);
            
            Assert.isTrue(controller.shouldShow());
            Assert.isEqual(45, controller.getWindDirection());
            
            return true;
        }

        (:test)
        public function testUnsetWindDirection(logger as Logger) as Boolean {
            var sensor = new WayfinderTests.StubSensorProvider();
            var weather = new WayfinderTests.StubWeatherProvider();

            var controller = new WindDirectionController(sensor, weather);
            controller.setWindDirection(90);
            controller.unsetWindDirection();
            
            Assert.isNull(controller.getWindDirection());
            Assert.isNull(Application.Properties.getValue("windDirectionSetAt"));
            Assert.isNull(Application.Properties.getValue("windDirection"));
            Assert.isFalse(controller.shouldShow());

            return true;
        }

        (:test)
        public function testFlipWindDirection(logger as Logger) as Boolean {
            var sensor = new WayfinderTests.StubSensorProvider();
            var weather = new WayfinderTests.StubWeatherProvider();

            var controller = new WindDirectionController(sensor, weather);

            controller.setWindDirection(10);
            controller.flipWindDirection();

            Assert.isTrue(controller.shouldShow());
            Assert.isEqual(190, controller.getWindDirection());

            return true;
        }

        (:test)
        public function testSetWindToCurrentDirection(logger as Logger) as Boolean {
            var sensor = new WayfinderTests.StubSensorProvider();
            var weather = new WayfinderTests.StubWeatherProvider();
            sensor.setHeading(77);

            var controller = new WindDirectionController(sensor, weather);

            controller.setWindToCurrentDirection();

            Assert.isTrue(controller.shouldShow());
            Assert.isEqual(77, controller.getWindDirection());

            return true;
        }

        (:test)
        public function testSetWindAwayFromCurrentDirection(logger as Logger) as Boolean {
            var sensor = new WayfinderTests.StubSensorProvider();
            var weather = new WayfinderTests.StubWeatherProvider();
            sensor.setHeading(100);

            var controller = new WindDirectionController(sensor, weather);

            controller.setWindAwayFromCurrentDirection();

            Assert.isTrue(controller.shouldShow());
            Assert.isEqual(280, controller.getWindDirection());
            
            return true;
        }
    }
}
