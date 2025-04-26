import Toybox.Lang;
import Toybox.Timer;


(:test)
class NoopTimer extends Timer.Timer {
    public function initialize() {
        Timer.Timer.initialize();
    }

    public function start(callback as Method() as Void, time as Number, repeat as Boolean) as Void {}
    
    public function stop() as Void {}
}