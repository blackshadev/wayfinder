import Toybox.Lang;

class SensorProviderInterface {
    public function heading() as Float? {
        throw new NotImplemented();
    }

    public function speed() as Float? {
        throw new NotImplemented();
    }
}