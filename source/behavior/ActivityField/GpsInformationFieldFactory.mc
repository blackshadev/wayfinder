import Toybox.ActivityRecording;
import Toybox.FitContributor;

class GpsInformationFieldFactory extends ActivityFieldFactory {
    private var location as LocationProvider;

    function initialize(location as LocationProvider) {
        ActivityFieldFactory.initialize();
        self.location = location;
    }

    public function create(session as Session) as ActivityField {
        return new GpsInformationField(session, self.location);
    }
}