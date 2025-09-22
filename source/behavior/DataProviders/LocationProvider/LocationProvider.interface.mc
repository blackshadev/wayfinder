import Toybox.Lang;
import Toybox.Position;

class LocationProviderInterface {
    public function getLastPosition() as Position.Location? {
        throw new NotImplemented();
    }

    public function getLastPositionInfo() as Position.Info? {
        throw new NotImplemented();
    }

    public function getConfiguration() as Position.Configuration? {
        throw new NotImplemented();
    }
}