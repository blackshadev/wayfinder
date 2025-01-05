import Toybox.Activity;
import Toybox.Lang;

class ActivityInfoProvider {
    private var activity as ActivityController;

    function initialize(activity as ActivityController) {
        self.activity = activity;
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
            cur.currentSpeed,
            cur.averageSpeed,
            cur.maxSpeed
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