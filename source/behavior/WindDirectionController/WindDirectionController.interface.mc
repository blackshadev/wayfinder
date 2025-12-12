import Toybox.Lang;

class WindDirectionControllerInterface {
    public function getWindDirection() as Number? {
        throw new NotImplemented();
    }

    public function setWindDirection(dir as Number?) as Void {
        throw new NotImplemented();
    }

    public function unsetWindDirection() as Void {
        throw new NotImplemented();
    }

    public function flipWindDirection() as Void {
        throw new NotImplemented();
    }
    
    public function setForecastWindDirection() as Void {
        throw new NotImplemented();
    }

    public function setWindToCurrentDirection() as Void {
        throw new NotImplemented();
    }

    public function setWindAwayFromCurrentDirection() as Void {
        throw new NotImplemented();
    }

    public function shouldShow() as Boolean {
        throw new NotImplemented();
    }
}
