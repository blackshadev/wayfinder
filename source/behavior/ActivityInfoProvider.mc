import Toybox.Activity;
import Toybox.Lang;

class ActivityInfoProvider {

    private var activity as ActivityController;
    private var unitConverter as UnitConverter;

    function initialize(activity as ActivityController, unitConverter as UnitConverter) {
        self.activity = activity;
        self.unitConverter = unitConverter;
    }

    public function duration() as Number? {
        var cur = Activity.getActivityInfo();

        if (cur == null || !self.activity.isStarted()) {
            return null;
        }

        return cur.timerTime;
    }

    public function speed() as SpeedValue? {
        var cur = Activity.getActivityInfo();

        if (cur == null || !self.activity.isStarted()) {
            return null;
        }

        return new SpeedValue(
            self.unitConverter.speedFromMS(cur.currentSpeed),
            self.unitConverter.speedFromMS(cur.averageSpeed),
            self.unitConverter.speedFromMS(cur.maxSpeed)
        );
    }

    public function distance() as Float? {
        var cur = Activity.getActivityInfo();

        if (cur == null || !self.activity.isStarted()) {
            return null;
        }

        return cur.elapsedDistance;
    }
}