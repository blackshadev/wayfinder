(:debug)
class StubAverageSpeedsProvider extends AverageSpeedsProviderInterface {
    private var _value as AverageSpeedValues? = null;

    function initialize() {
        AverageSpeedsProviderInterface.initialize();
    }

    public function setValue(value as AverageSpeedValues?) as Void {
        self._value = value;
    }

    public function value() as AverageSpeedValues? {
        return self._value;
    }
}