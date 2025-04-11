import Toybox.Lang;

class FakeSettingsController {

    private var _distance as Number;
    private var _unitsSpeed as Number;

    function initialize(
        distance as Number,
        unitsSpeed as Number
    ) {
        self._distance = distance;
        self._unitsSpeed = unitsSpeed;
    }

    public function distance() as Number {
        return self._distance;
    }

    public function unitsSpeed() as Number {
        return self._unitsSpeed;
    }
}