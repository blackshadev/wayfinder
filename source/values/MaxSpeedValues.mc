import Toybox.Lang;

class MaxSpeedValues {
    private var _speed2s as Float;
    private var _speed10s as Float;

    function initialize(speed2s as Float, speed10s as Float) {
        self._speed2s = speed2s;
        self._speed10s = speed10s;
    }

    public function speed2s() as Float {
        return self._speed2s;
    }

    public function speed10s() as Float {
        return self._speed10s;
    }
}