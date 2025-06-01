import Toybox.Lang;

class MaxAverageSpeedValues {
    public var speed2s as Float = 0.0;
    public var speed10s as Float = 0.0;
    public var speed30m as Float = 0.0;
    public var speed60m as Float = 0.0;

    function initialize() {
        self.speed2s = speed2s;
        self.speed10s = speed10s;
        self.speed30m = speed30m;
        self.speed60m = speed60m;
    }

    public function update(values as AverageSpeedValues) as Void {
        if (values.speed2s.isComplete == true && values.speed2s.value > self.speed2s) {
            self.speed2s = values.speed2s.value;
        }
        
        if (values.speed10s.isComplete == true && values.speed10s.value > self.speed10s) {
            self.speed10s = values.speed10s.value;
        }

        if (values.speed30m.isComplete == true && values.speed30m.value > self.speed30m) {
            self.speed30m = values.speed30m.value;
        }

        if (values.speed60m.isComplete == true && values.speed60m.value > self.speed60m) {
            self.speed60m = values.speed60m.value;
        }
    }
}