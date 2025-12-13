import Toybox.Lang;

(:debug)
module WayfinderTests {
    class StubWeatherProvider extends WeatherProviderInterface {
        private var _windDirection as Number?;

        function initialize() {
            WeatherProviderInterface.initialize();
        }

        public function setWindDirection(dir as Number?) as Void {
            self._windDirection = dir;
        }

        public function getWindDirection() as Number? {
            return self._windDirection;
        }
    }
}
