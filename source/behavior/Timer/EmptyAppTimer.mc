import Toybox.Lang;

class EmptyAppTimer extends AppTimerInterface {
    function initialize() {
        AppTimerInterface.initialize();
    }

    public function add(ref as Method) as Void {
    }

    public function remove(ref as Method) as Void {
    }

    public function contains(ref as Method) as Boolean {
        return false;
    }

    public function start() as Void {}
    public function stop() as Void {}

    public function time() as Number {
        return 1000;
    }
} 