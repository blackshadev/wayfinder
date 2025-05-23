import Toybox.ActivityRecording;
import Toybox.FitContributor;
import Toybox.Timer;

class AverageSpeedActivityField extends ActivityField {

    private const FIELD_ID_AVG_SPEED_2S = 1;
    private const FIELD_ID_AVG_SPEED_10S = 2;
    private const FIELD_ID_AVG_SPEED_30M = 3;
    private const FIELD_ID_AVG_SPEED_60M = 4;

    private static const UPDATE_TIME = 1000;
    
    private var speedAggregator as SpeedAggregationProvider;
    
    private var field2s as FitContributor.Field;
    private var field10s as FitContributor.Field;
    private var field30m as FitContributor.Field;
    private var field60m as FitContributor.Field;

    private var converter as UnitConverter;
    private var updateTimer as Timer.Timer;

    function initialize(session as Session, speedAggregator as SpeedAggregationProvider) {
        ActivityField.initialize();

        self.speedAggregator = speedAggregator;

        self.converter = new UnitConverter();
        self.updateTimer = new Timer.Timer();

        var fieldConfig = { 
            :mesgType => FitContributor.MESG_TYPE_RECORD, 
            :units => WatchUi.loadResource(Rez.Strings.settingsUnitsSpeedknots)
        };

        self.field2s = session.createField(
            WatchUi.loadResource(Rez.Strings.labelAvgSpeed2s),
            FIELD_ID_AVG_SPEED_2S,
            FitContributor.DATA_TYPE_FLOAT,
            fieldConfig
        );

        self.field10s = session.createField(
            WatchUi.loadResource(Rez.Strings.labelAvgSpeed10s),
            FIELD_ID_AVG_SPEED_10S,
            FitContributor.DATA_TYPE_FLOAT,
            fieldConfig
        );

        self.field30m = session.createField(
            WatchUi.loadResource(Rez.Strings.labelAvgSpeed30m),
            FIELD_ID_AVG_SPEED_30M,
            FitContributor.DATA_TYPE_FLOAT,
            fieldConfig
        );

        self.field60m = session.createField(
            WatchUi.loadResource(Rez.Strings.labelAvgSpeed60m),
            FIELD_ID_AVG_SPEED_60M,
            FitContributor.DATA_TYPE_FLOAT,
            fieldConfig
        );
    }

    public function start() as Void {
        self.updateTimer.start(method(:updateValues), UPDATE_TIME, true);
    }

    public function stop() as Void {
        self.updateTimer.stop();
    }

    public function updateValues() as Void {
        var value = self.speedAggregator.value();

        self.field2s.setData(self.converter.speedFromMS(value.speed2s, SettingsControllerInterface.SPEED_KNOTS));
        self.field10s.setData(self.converter.speedFromMS(value.speed10s, SettingsControllerInterface.SPEED_KNOTS));
        self.field30m.setData(self.converter.speedFromMS(value.speed30m, SettingsControllerInterface.SPEED_KNOTS));
        self.field60m.setData(self.converter.speedFromMS(value.speed60m, SettingsControllerInterface.SPEED_KNOTS));
    }
}