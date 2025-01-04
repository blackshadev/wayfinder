import Toybox.Lang;

class ActivityNotStarted extends Exception {
    public function initialize() {
        Exception.initialize();
        self.mMessage = "Activity not yet started";
    }
}