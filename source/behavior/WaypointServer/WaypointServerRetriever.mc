import Toybox.Lang;
import Toybox.Position;
import Toybox.Communications;

class WaypointServerRetriever {
    enum Stage {
        Unregistered = 0,
        AwaitingRegistration = 1,
        AwaitingWaypoints = 2,
        Done = 3,

        RegistrationError = 11,
        WaypointRetrievalError = 12,
    }

    private var _ticker as Number = 0;
    private var _hasPendingRequest as Boolean = false;
    private var _stage as Stage = Unregistered;
    private var _deviceCode as String or Null = null;
    private var _errorCode as Number or Null = null;
    private var _waypoints as Array<Waypoint> = [];

    private var _client as WaypointServerClient;
    private var _waypointsController as WaypointsController;
    private var _tickerTimerSubscription as TimerSubscription;

    function initialize(
        client as WaypointServerClient,
        waypointsController as WaypointsController
    ) {
        self._client = client;
        self._waypointsController = waypointsController;

        self._tickerTimerSubscription = AppTimer.subscribeOnUpdate(method(:tick));
    }

    public function stop() as Void {
        self._tickerTimerSubscription.stop();
        Communications.cancelAllRequests();
    }

    public function start() as Void {
        self._tickerTimerSubscription.start();
        self._ticker = 0;
    }

    public function reset() as Void {
        self._ticker = 0;
        self._stage = Unregistered;
        self._waypoints = [];
        self._deviceCode = null;
        self._errorCode = null;
        self._hasPendingRequest = false;
        self._client.cancelPendingRequests();

    }

    public function registerDevice() as Void {
        if (self._stage == AwaitingRegistration || self._stage == AwaitingWaypoints) {
            return;
        }

        self._hasPendingRequest = true;

        self._client.registerDevice(
            method(:onReceiveCode)
        );

        self._stage = AwaitingRegistration;
    }

    public function onReceiveCode(status as Number, data as Dictionary) as Void {
        self._hasPendingRequest = false;
        if (status > 220 || status < 200) {
            self._errorCode = status;
            self._stage = RegistrationError;
            return;
        }

        self._deviceCode = data["code"];
        self._stage = AwaitingWaypoints;
        self._client.openDeviceCode(self._deviceCode);
    }

    public function retrieveWaypoints() as Void {
        if (self._deviceCode == null) {
            return;
        }

        self._hasPendingRequest = true;

        self._client.getDeviceWaypoints(self._deviceCode, method(:onReceiveWaypoints));
    }

    public function onReceiveWaypoints(status as Number, data as Dictionary) as Void {
        self._hasPendingRequest = false;

        if (status == 404) {
            return;
        }

        if (status > 299 || status < 100) {
            self._errorCode = status;
            self._stage = WaypointRetrievalError;
            self._stage = Unregistered;
            return;
        }

        var waypoints = [] as Array<Waypoint>;
        var retrievedWaypoints = data["waypoints"] as Array<Dictionary>;
        for (var iX = 0; iX < retrievedWaypoints.size(); iX++) {
            var waypoint = retrievedWaypoints[iX] as Dictionary;

            waypoints.add(
                new Waypoint(
                    new Position.Location({
                        :latitude => waypoint["latitude"],
                        :longitude => waypoint["longitude"],
                        :format => :degrees
                    })
                )
            );
        }

        self._waypointsController.setWaypoints(waypoints);

        self._waypoints = waypoints;
        self._stage = Done;
    }

    public function target() as String {
        return self._client.target();
    }

    public function deviceCode() as String {
        if (self._deviceCode == null) {
            return "----";
        }

        return self._deviceCode;
    }

    public function waypoints() as Array<Waypoint> {
        return self._waypoints;
    }

    public function stage() as Stage {
        return self._stage;
    }

    public function errorCode() as Number or Null {
        return self._errorCode;
    }

    public function tick() as Void {
        self._ticker = (self._ticker + 1) % 5;

        if (self._hasPendingRequest || self._ticker != 1) {
            return;
        }

        if (self._stage == Unregistered || self._stage == RegistrationError) {
            self.registerDevice();
            return;
        }

        if (self._stage == AwaitingWaypoints || self._stage == WaypointRetrievalError || self._stage == Done) {
            self.retrieveWaypoints();
            return;
        }
    }
}