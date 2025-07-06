import Toybox.Lang;
import Toybox.Position;

typedef LocationEventsOptions as Position.LocationAcquisitionType
                              or { 
                                :aquisitionType as Position.LocationAcquisitionType,
                                :constellations as Array<Number>
                              } or { 
                                :aquisitionType as Position.LocationAcquisitionType,
                                :configuration as Position.Configuration,
                                :wut as String
                              };

class LocationProvider {
    private var lastPosition as Position.Info? = null;
    protected var _configuration as Position.Configuration? = null;
    

    public function start() as Void {
        self._configuration = self.getLocationConfiguration();
        var options = self.getLocationsEventsOptions();
        
        Position.enableLocationEvents(options, method(:onPosition));
    }

    public function stop() as Void {
        Position.enableLocationEvents(Position.LOCATION_DISABLE, null);
    }

    public function onPosition(info as Position.Info) as Void {
        self.lastPosition = info;   
    }

    public function getConfiguration() as Position.Configuration? {
        return self._configuration;
    }

    public function getLastPositionInfo() as Position.Info? {
        return self.lastPosition;
    }

    public function getLastPosition() as Position.Location? {
        if (self.lastPosition == null) {
            return null;
        }

        return self.lastPosition.position;
    }

    private function getLocationConfiguration() as Position.Configuration? {
        if (!(Position has :hasConfigurationSupport)) {
            return null;
        }

        // GPS L1 + L5, GLONASS, Galileo E1 + E5a, and BeiDou B1I + B2a (e.g. Forerunner 255)
        if (
            Position has :CONFIGURATION_GPS_GLONASS_GALILEO_BEIDOU_L1_L5 &&
            Position.hasConfigurationSupport(Position.CONFIGURATION_GPS_GLONASS_GALILEO_BEIDOU_L1_L5)
        ) {
            return Position.CONFIGURATION_GPS_GLONASS_GALILEO_BEIDOU_L1_L5;
        // GPS L1, GLONASS, Galileo E1, and BeiDou B1I (e.g. vívoactive 5)
        } else if (
            Position has :CONFIGURATION_GPS_GLONASS_GALILEO_BEIDOU_L1 &&
            Position.hasConfigurationSupport(Position.CONFIGURATION_GPS_GLONASS_GALILEO_BEIDOU_L1)
        ) {
            return Position.CONFIGURATION_GPS_GLONASS_GALILEO_BEIDOU_L1;
        // GPS L1 and Galileo E1 - May be skipped in the simulator (e.g. fēnix 6)
        } else if (
            Position has :CONFIGURATION_GPS_GALILEO &&
            Position.hasConfigurationSupport(Position.CONFIGURATION_GPS_GALILEO)
        ) {
            return Position.CONFIGURATION_GPS_GALILEO;
        // GPS L1 and BeiDou B1I
        } else if (
            Position has :CONFIGURATION_GPS_BEIDOU &&
            Position.hasConfigurationSupport(Position.CONFIGURATION_GPS_BEIDOU)
        ) {
            return Position.CONFIGURATION_GPS_BEIDOU;
        // GPS L1 and GLONASS
        } else if (
            Position has :CONFIGURATION_GPS_GLONASS &&
            Position.hasConfigurationSupport(Position.CONFIGURATION_GPS_GLONASS)
        ) {
            return Position.CONFIGURATION_GPS_GLONASS;
        // GPS L1 - Theoretically redundant
        } else if (
            Position has :CONFIGURATION_GPS &&
            Position.hasConfigurationSupport(Position.CONFIGURATION_GPS)
        ) {
            return Position.CONFIGURATION_GPS;
        }

        return null;
    }

    private function getLocationsEventsOptions() as LocationEventsOptions {
        var locationConfig = self.getLocationConfiguration();

        if (locationConfig != null) {
            return {
                :acquisitionType => Position.LOCATION_CONTINUOUS,
                :configuration => locationConfig,
            };
        }

        // GPS L1 and Galileo E1
        if (Position has :CONSTELLATION_GALILEO) {
            return {
                :acquisitionType => Position.LOCATION_CONTINUOUS,
                :constellations => [ Position.CONSTELLATION_GPS, Position.CONSTELLATION_GALILEO ]
            };
        }

        // GPS L1 and GLONASS
        if (Position has :CONSTELLATION_GLONASS) {
            return {
                :acquisitionType => Position.LOCATION_CONTINUOUS,
                :constellations => [ Position.CONSTELLATION_GPS, Position.CONSTELLATION_GLONASS ]
            };
        }

        return Position.LOCATION_CONTINUOUS;
    }
}