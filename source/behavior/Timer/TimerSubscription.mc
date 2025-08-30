import Toybox.Lang;
import Toybox.Timer;

class TimerSubscription {
    private var _method as Method?;
    private var _timer as AppTimerInterface;

    function initialize(timer as AppTimerInterface) {
        self._timer = timer;
    }

    public function stop() as Void {
        if (self._method == null) {
            return;
        }

        self._timer.remove(self._method);
        self._method = null;
    }

    public function start(method as Method) as Void {
        self._method = method;
        self._timer.add(self._method);
    }
}