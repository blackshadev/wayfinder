import Toybox.ActivityRecording;
import Toybox.FitContributor;
import Toybox.Timer;

class GpsInformationField extends ActivityField {

    private const FIELD_ID_GPS_GNSS_CONFIG = 10;
    private const FIELD_ID_GPS_FIX_QUALITY = 11;

    private var location as LocationProvider;

    private var gnsConfigField as FitContributor.Field;
    private var fixQualityField as FitContributor.Field;
    
    private var updateTimer as TimerSubscription;

    function initialize(session as Session, location as LocationProvider) {
        ActivityField.initialize();

        self.location = location;
        self.updateTimer = AppTimer.onUpdate();

        self.gnsConfigField = session.createField(
            WatchUi.loadResource(Rez.Strings.fieldLabelGnssConfig),
            FIELD_ID_GPS_GNSS_CONFIG,
            FitContributor.DATA_TYPE_UINT8,
            { 
                :mesgType => FitContributor.MESG_TYPE_SESSION, 
            }
        );

        self.fixQualityField = session.createField(
            WatchUi.loadResource(Rez.Strings.fieldLabelFixQuality),
            FIELD_ID_GPS_FIX_QUALITY,
            FitContributor.DATA_TYPE_UINT8,
            { 
                :mesgType => FitContributor.MESG_TYPE_RECORD, 
            }
        );
    }

    public function start() as Void {
        self.updateTimer.start(method(:updateValues));
    }

    public function stop() as Void {
        self.updateTimer.stop();
    }

    public function reset() as Void {}

    public function updateValues() as Void {
        var configuration = self.location.getConfiguration();
        if (configuration == null) {
            configuration = 0;
        }
        self.gnsConfigField.setData(configuration);

        var position = self.location.getLastPositionInfo();
        if (position != null) {
            self.fixQualityField.setData(position.accuracy);
        }
    }
}