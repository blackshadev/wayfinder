import Toybox.Lang;
import Toybox.Timer;

class TimerSubscription {
    private var _method as Method;
    private var _timer as AppTimerInterface;

    function initialize(method as Method, timer as AppTimerInterface) {
        self._method = method;
        self._timer = timer;
    }

    public function stop() as Void {
        self._timer.remove(self._method);
    }

    public function start() as Void {
        self._timer.add(self._method);
    }
}