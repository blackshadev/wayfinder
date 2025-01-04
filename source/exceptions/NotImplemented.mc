import Toybox.Lang;

class NotImplemented extends Exception {
    public function initialize() {
        Exception.initialize();
        self.mMessage = "Not implemented";
    }
}