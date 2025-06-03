import Toybox.Lang;

class MaxAverageSpeedValues {
    public var speed2s as Float;
    public var speed10s as Float;
    public var speed30m as Float;
    public var speed60m as Float;

    public static function empty() as MaxAverageSpeedValues {
        return new MaxAverageSpeedValues(0.0, 0.0, 0.0, 0.0);
    }

    function initialize(
        speed2s as Float, 
        speed10s as Float, 
        speed30m as Float, 
        speed60m as Float
    ) {
        self.speed2s = speed2s;
        self.speed10s = speed10s;
        self.speed30m = speed30m;
        self.speed60m = speed60m;
    }

    public function combine(values as AverageSpeedValues) as MaxAverageSpeedValues {
        var newSpeed2s = self.speed2s;
        var newSpeed10s = self.speed10s;
        var newSpeed30m = self.speed30m;
        var newSpeed60m = self.speed60m;

        if (values.speed2s.isComplete == true && values.speed2s.value > newSpeed2s) {
            newSpeed2s = values.speed2s.value;
        }
        
        if (values.speed10s.isComplete == true && values.speed10s.value > newSpeed10s) {
            newSpeed10s = values.speed10s.value;
        }

        if (values.speed30m.isComplete == true && values.speed30m.value > newSpeed30m) {
            newSpeed30m = values.speed30m.value;
        }

        if (values.speed60m.isComplete == true && values.speed60m.value > newSpeed60m) {
            newSpeed60m = values.speed60m.value;
        }

        return new MaxAverageSpeedValues(
            newSpeed2s, 
            newSpeed10s, 
            newSpeed30m, 
            newSpeed60m
        );
    }
}