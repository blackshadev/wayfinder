import Toybox.Lang;

class AverageSpeedValues {
    public var speed2s as AverageValue;
    public var speed10s as AverageValue;
    public var speed30m as AverageValue;
    public var speed60m as AverageValue;

    function initialize(
        speed2s as AverageValue,
        speed10s as AverageValue,
        speed30m as AverageValue,
        speed60m as AverageValue
    ) {
        self.speed2s = speed2s;
        self.speed10s = speed10s;
        self.speed30m = speed30m;
        self.speed60m = speed60m;
    }
}