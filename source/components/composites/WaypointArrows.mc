import Toybox.Graphics;
import Toybox.Lang;

class WaypointArrows extends RelativeComponent {
    private var _waypoints as WaypointsController;

    private var _currentWaypoint as Arrow;
    private var _returnArrow as Arrow;
    private var _isAbsolute as Boolean;

    function initialize(
        settings as SettingsController,
        waypoints as WaypointsController,
        isAbsolute as Boolean
    ) {
        RelativeComponent.initialize();

        self._waypoints = waypoints;
        self._isAbsolute = isAbsolute == true;

        self._currentWaypoint = new Arrow({
            :size => settings.arrowSizeValue(),
            :color => Graphics.COLOR_GREEN
        });
        self._returnArrow = new Arrow({
            :size => settings.arrowSizeValue(),
            :color => Graphics.COLOR_DK_BLUE
        });
    }

    public function update() as Void {
        var currentWaypoint = self._waypoints.currentWaypoint();
        if (currentWaypoint != null && self._waypoints.shouldShowCurrentWaypoint()) {
            self._currentWaypoint.setAngle(self._isAbsolute ? currentWaypoint.absoluteAngle() : currentWaypoint.angle());
        }

        var returnWaypoint = self._waypoints.returnWaypoint();
        if (returnWaypoint != null && self._waypoints.shouldShowReturnWaypoint()) {
            self._returnArrow.setAngle(self._isAbsolute ? returnWaypoint.absoluteAngle() : returnWaypoint.angle());
        }
    }

    public function layout(dc as Dc) as Void {
        self._currentWaypoint.layout(dc);
        self._returnArrow.layout(dc);
    }

    public function draw(dc as Dc) as Void {
        if (self._waypoints.shouldShowCurrentWaypoint()) {
            self._currentWaypoint.draw(dc);
        }

        if (self._waypoints.shouldShowReturnWaypoint()) {
            self._returnArrow.draw(dc);
        }
    }
}