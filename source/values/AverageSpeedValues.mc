import Toybox.Lang;

class AverageSpeedValues {
    public var speed2s as Float;
    public var speed10s as Float;
    public var speed30m as Float;
    public var speed60m as Float;

    function initialize(speed2s as Float, speed10s as Float, speed30m as Float, speed60m as Float) {
        self.speed2s = speed2s;
        self.speed10s = speed10s;
        self.speed30m = speed30m;
        self.speed60m = speed60m;
    }
}