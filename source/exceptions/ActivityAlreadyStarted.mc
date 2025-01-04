import Toybox.Lang;

class ActivityAlreadyStarted extends Exception {
    public function initialize() {
        Exception.initialize();
        self.mMessage = "Activity already started";
    } 
}