import Toybox.WatchUi;
import Toybox.Position;
import Toybox.System;
import Toybox.Lang;
import Toybox.Attention;

class WaypointsController {
    private var _location as LocationProvider;
    private var _sensor as SensorProvider;
    private var _waypointStorage as WaypointStorage;
    private var _settings as SettingsController;
    private var _unitConverter as SettingsBoundUnitConverter;

    private var _lastPosition as Position.Location? = null;
    private var _shouldSetReturn as Boolean = false;
    private var _returnWaypoint as Waypoint? = null;
    private var _currentWaypoint as Waypoint? = null;
    private var _currentWaypointIndex = 0;
    private var _waypoints as Array<Waypoint> = [];
    private var _updateTimer as TimerSubscription;

    function initialize(
        location as LocationProvider, 
        sensor as SensorProvider,
        waypointStorage as WaypointStorage,
        settings as SettingsController,
        unitConverter as SettingsBoundUnitConverter
    ) {
        self._location = location;
        self._sensor = sensor;
        self._waypointStorage = waypointStorage;
        self._settings = settings;
        self._unitConverter = unitConverter;

        self._waypoints = self._waypointStorage.loadWaypoints();

        self._updateTimer = AppTimer.onUpdate();
        self._updateTimer.start(method(:update));
    }

    public function shouldShowReturnWaypoint() as Boolean {
        switch (self._settings.returnWaypointVisibility()) {
            case SettingsControllerInterface.RETURN_WAYPOINT_AFTER_LAST:
                return self._currentWaypoint == null;
            case SettingsControllerInterface.RETURN_WAYPOINT_ALWAYS:
                return true;
            default:
                return false;
        }
    }

    public function shouldShowCurrentWaypoint() as Boolean {
        return self._currentWaypoint != null;
    }

    public function update() as Void {
        self._lastPosition = self._location.getLastPosition();

        if (self._lastPosition == null) {
            return;
        }

        if (self._shouldSetReturn) {
            self.setReturn();
        }

        self.updateCurrentWaypoint();

        if (self._returnWaypoint != null) {
            self._returnWaypoint.update(self._lastPosition, self._sensor.heading());
        }
    }

    public function currentWaypoint() as Waypoint? {
        return self._currentWaypoint;
    }

    public function returnWaypoint() as Waypoint? {
        return self._returnWaypoint;
    }

    public function isSet() as Boolean {
        return self._returnWaypoint != null;
    }

    public function isSettable() as Boolean {
        return self._lastPosition != null;
    }

    public function autoSet() as Void {
        if (self.isSet()) {
            return;
        }

        if (!self.isSettable()) {
            self._shouldSetReturn = true;
            return;
        }

        self.setReturn();
    }

    public function setWaypoints(waypoints as Array<Waypoint>) as Void {
        self._waypoints = waypoints;
        self._waypointStorage.saveWaypoints(waypoints);

        if (waypoints.size() > 0) {
            self._currentWaypoint = waypoints[0];
        }
    }

    public function setWaypoint() as Void {
        if (!self.isSettable()) {
            return;
        }
    
        self.setWaypoints([new Waypoint(self._lastPosition)]);
    }

    public function count() as Number {
        return self._waypoints.size();
    }

    public function setReturn() as Void {
        if (!self.isSettable()) {
            return;
        }
    
        self._shouldSetReturn = false;
        self._returnWaypoint = new Waypoint(self._lastPosition);
    }

    public function clearWaypoints() as Void {
        self._waypoints = [];
        self._currentWaypoint = null;
        self._waypointStorage.clear();
    }

    private function updateCurrentWaypoint() as Void {
        
        if (self._currentWaypoint == null && self._currentWaypointIndex < self._waypoints.size()) {
            self.setNextWaypoint();
        }

        if (self._currentWaypoint == null || self._lastPosition == null) {
            return;
        }

        self._currentWaypoint.update(self._lastPosition, self._sensor.heading());

        while (self._unitConverter.smallDistanceFromMeters(self._currentWaypoint.distance()) <= self._settings.distanceToWaypoint()) {
            self.setNextWaypoint();

            if (self._currentWaypoint == null) {
                return;
            }
            
            self._currentWaypoint.update(self._lastPosition, self._sensor.heading());
        }
    }

    private function setNextWaypoint() as Void {
        if (self._currentWaypoint != null) {
            var vibeData =  [
                new Attention.VibeProfile(50, 500),
                new Attention.VibeProfile(0, 300),
                new Attention.VibeProfile(100, 300)
            ];
            Attention.vibrate(vibeData);
            Attention.playTone(Attention.TONE_INTERVAL_ALERT);
        }

        if (self._currentWaypointIndex >= self._waypoints.size()) {
            self._currentWaypoint = null;
            return;
        }

        self._currentWaypoint = self._waypoints[self._currentWaypointIndex];
        self._currentWaypointIndex += 1;
    }
}
