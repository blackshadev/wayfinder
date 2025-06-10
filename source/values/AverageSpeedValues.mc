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
        self.speed2s = speed2s.abs();
        self.speed10s = speed10s.abs();
        self.speed30m = speed30m.abs();
        self.speed60m = speed60m.abs();
    }
}