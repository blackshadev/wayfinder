import Toybox.Lang;

class MaxSpeedValues {
    private var _speed2s as Float;
    private var _speed10s as Float;

    function initialize(speed2s as Float, speed10s as Float) {
        self._speed2s = speed2s;
        self._speed10s = speed10s;
    }

    public function speed2sMPS() as Float {
        return self._speed2s;
    }

    public function speed10sMPS() as Float {
        return self._speed10s;
    }


    public function speed2sKMPH() as Float {
        return self._speed2s * 3.6;
    }

    public function speed10sKMPH() as Float {
        return self._speed10s * 3.6;
    }
}